/**
 * Copyright (C) 2014 The Simlar Authors.
 *
 * This file is part of Simlar. (https://www.simlar.org)
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

#import "SMLRContactsProvider.h"

#import "SMLRContact.h"
#import "SMLRContactsProviderStatus.h"
#import "SMLRCredentials.h"
#import "SMLRGetContactStatus.h"
#import "SMLRHttpsPostError.h"
#import "SMLRLog.h"

#import <Contacts/Contacts.h>

//#define USE_FAKE_TELEPHONE_BOOK

@interface SMLRContactsProvider ()

@property (nonatomic) SMLRContactsProviderStatus status;
@property (nonatomic) NSDictionary *contacts;
@property (nonatomic) NSString *simlarIdToFind;
@property (nonatomic, copy) void (^simlarContactsHandler)(NSArray *const contacts, NSError *const);
@property (nonatomic, copy) void (^contactHandler)(SMLRContact *const contact, NSError *const);

@end

NSString *const SMLRContactsProviderErrorDomain = @"org.simlar.contactsProvider";

@implementation SMLRContactsProvider

- (void)getContactsWithCompletionHandler:(void (^)(NSArray *const contacts, NSError *const error))handler
{
    SMLRLogI(@"getContactsWithCompletionHandler with status=%@", nameSMLRContactsProviderStatus(_status));
    self.simlarContactsHandler = handler;

    switch (_status) {
        case SMLRContactsProviderStatusNone:
        case SMLRContactsProviderStatusError:
            [self createContacts];
            break;
        case SMLRContactsProviderStatusRequestingAddressBookAccess:
        case SMLRContactsProviderStatusParsingPhonesAddressBook:
        case SMLRContactsProviderStatusRequestingContactsStatus:
            break;
        case SMLRContactsProviderStatusInitialized:
        {
            NSMutableArray *const simlarContacts = [NSMutableArray array];
            for (SMLRContact *const contact in [_contacts allValues]) {
                if (contact.registered) {
                    [simlarContacts addObject:contact];
                }
            }

            [simlarContacts sortUsingSelector:@selector(compareByName:)];

            self.status = SMLRContactsProviderStatusInitialized;
            if (_simlarContactsHandler) {
                _simlarContactsHandler([SMLRContactsProvider groupContacts:simlarContacts], nil);
                self.simlarContactsHandler = nil;
            }
            break;
        }
    }
}

- (void)getContactBySimlarId:(NSString *const)simlarId completionHandler:(void (^)(SMLRContact *const contact, NSError *const error))handler
{
    SMLRLogI(@"getContactBySimlarId with status=%@", nameSMLRContactsProviderStatus(_status));

    self.contactHandler = handler;
    self.simlarIdToFind = simlarId;

    if ([simlarId length] == 0) {
        SMLRLogI(@"SimlarId is empty");
        [self handleErrorWithMessage:@"SimlarId is empty"];
        return;
    }

    switch (_status) {
        case SMLRContactsProviderStatusNone:
        case SMLRContactsProviderStatusError:
            [self createContacts];
            break;
        case SMLRContactsProviderStatusRequestingAddressBookAccess:
        case SMLRContactsProviderStatusParsingPhonesAddressBook:
            break;
        case SMLRContactsProviderStatusRequestingContactsStatus:
        case SMLRContactsProviderStatusInitialized:
            [self handleContactBySimlarId];
            break;
    }
}

- (void)reset
{
    if (_status == SMLRContactsProviderStatusInitialized) {
        SMLRLogI(@"resetting contacts");
        self.status = SMLRContactsProviderStatusNone;
    }
}

- (void)handleContactBySimlarId
{
    if (!_contactHandler || [_simlarIdToFind length] == 0) {
        return;
    }

    _contactHandler(_contacts[_simlarIdToFind], nil);
    self.contactHandler = nil;
    self.simlarIdToFind = nil;
}

- (void)handleError:(NSError *const)error
{
    self.status = SMLRContactsProviderStatusError;

    if (_simlarContactsHandler) {
        _simlarContactsHandler(nil, error);
        self.simlarContactsHandler = nil;
    }

    if (_contactHandler) {
        _contactHandler(nil, error);
        self.contactHandler = nil;
    }
}

- (void)handleErrorWithErrorCode:(const SMLRContactsProviderError)errorCode
{
    [self handleError:[NSError errorWithDomain:SMLRContactsProviderErrorDomain code:errorCode userInfo:nil]];
}

- (void)handleErrorWithMessage:(NSString *const)message
{
    [self handleError:[NSError errorWithDomain:SMLRContactsProviderErrorDomain
                                          code:SMLRContactsProviderErrorUnknown
                                      userInfo:@{ NSLocalizedDescriptionKey : message }]];
}

+ (NSString *)nameABAuthorizationStatus:(const CNAuthorizationStatus)status
{
    switch (status) {
        case CNAuthorizationStatusAuthorized:    return @"CNAuthorizationStatusAuthorized";
        case CNAuthorizationStatusDenied:        return @"CNAuthorizationStatusDenied";
        case CNAuthorizationStatusNotDetermined: return @"CNAuthorizationStatusNotDetermined";
        case CNAuthorizationStatusRestricted:    return @"CNAuthorizationStatusRestricted";
    }
}

- (void)createContacts
{
    self.status = SMLRContactsProviderStatusParsingPhonesAddressBook;
#ifndef USE_FAKE_TELEPHONE_BOOK
    [self checkAddressBookPermission];
#else
    [self createFakeContacts];
#endif
}

- (void)addressBookReadWithContacts:(NSDictionary *)contacts
{
    self.contacts = contacts;

    [self handleContactBySimlarId];
    [self getStatusForContacts];
}

- (void)checkAddressBookPermission
{
    SMLRLogFunc;

    const CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    switch (status) {
        case CNAuthorizationStatusRestricted:
        case CNAuthorizationStatusDenied:
            SMLRLogI(@"AddressBook access denied: status=%@", [SMLRContactsProvider nameABAuthorizationStatus:status]);
            [self handleErrorWithErrorCode:SMLRContactsProviderErrorNoPermission];
            break;
        case CNAuthorizationStatusNotDetermined:
        case CNAuthorizationStatusAuthorized:
            SMLRLogI(@"AddressBook access granted: status=%@", [SMLRContactsProvider nameABAuthorizationStatus:status]);
            [self requestAddressBookAccess];
            break;
    }
}

- (void)requestAddressBookAccess
{
    SMLRLogI(@"start requesting access to address book");
    self.status = SMLRContactsProviderStatusRequestingAddressBookAccess;

    CNContactStore *const store = [[CNContactStore alloc] init];
    [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(const BOOL granted, NSError *const _Nullable error) {
        SMLRLogI(@"AddressBookRequestAccess granted=%d", granted);

        if (error != NULL) {
            dispatch_async(dispatch_get_main_queue(), ^(void){
                [self handleError:error];
            });
        } else if (granted != YES) {
            dispatch_async(dispatch_get_main_queue(), ^(void){
                [self handleErrorWithErrorCode:SMLRContactsProviderErrorNoPermission];
            });
        } else {
            NSDictionary *const contacts = [SMLRContactsProvider readContactsFromAddressBookWithStore:store];

            dispatch_async(dispatch_get_main_queue(), ^(void){
                [self addressBookReadWithContacts:contacts];
            });
        }
    }];
}

+ (NSDictionary *)readContactsFromAddressBookWithStore:(CNContactStore *const)store
{
    SMLRLogI(@"start reading contacts from phones address book");
    NSDate *const date = [[NSDate alloc] init];

    NSMutableDictionary *const result = [NSMutableDictionary dictionary];

    CNContactFetchRequest *const request = [[CNContactFetchRequest alloc] initWithKeysToFetch:@[CNContactPhoneNumbersKey, [CNContactFormatter descriptorForRequiredKeysForStyle:CNContactFormatterStyleFullName]]];
    NSError *error = NULL;
    [store enumerateContactsWithFetchRequest:request error:&error usingBlock:^(CNContact *const __nonnull contact, BOOL *const __nonnull stop) {
        if (error != NULL) {
            SMLRLogE(@"Error accessing telephone book: %@", error);
        } else {
            for (CNLabeledValue *const label in contact.phoneNumbers) {
                SMLRContact *const simlarContact = [[SMLRContact alloc] initWithContact:contact phoneNumber:[label.value stringValue]];
                if (simlarContact && ![simlarContact.simlarId isEqualToString:[SMLRCredentials getSimlarId]]) {
                    [result setValue:simlarContact forKey:simlarContact.simlarId];
                }
            }
        }
    }];

    const long seconds = [[[NSDate alloc] init] timeIntervalSinceDate:date];
    SMLRLogI(@"reading %lu contacts from phones address book took %lu seconds", (unsigned long)[result count], seconds);

    return result;
}

+ (void)addContactToDictionary:(NSMutableDictionary *const)dictionary simlarId:(NSString *const)simlarId name:(NSString *const)name guiNumber:(NSString *const)guiNumber
{
    [dictionary setValue:[[SMLRContact alloc] initWithSimlarId:simlarId
                                            guiTelephoneNumber:guiNumber
                                                          name:name]
                  forKey:simlarId];
}

- (void)createFakeContacts
{
    NSMutableDictionary *const result = [NSMutableDictionary dictionary];

    [SMLRContactsProvider addContactToDictionary:result simlarId:@"*0002*" name:@"Barney Gumble"    guiNumber:@"+49 171 111111"];
    [SMLRContactsProvider addContactToDictionary:result simlarId:@"*0004*" name:@"Bender Rodriguez" guiNumber:@"+49 172 222222"];
    [SMLRContactsProvider addContactToDictionary:result simlarId:@"*0005*" name:@"Eric Cartman"     guiNumber:@"+49 173 333333"];
    [SMLRContactsProvider addContactToDictionary:result simlarId:@"*0006*" name:@"Earl Hickey"      guiNumber:@"+49 174 444444"];
    [SMLRContactsProvider addContactToDictionary:result simlarId:@"*0007*" name:@"H. M. Murdock"    guiNumber:@"+49 175 555555"];
    [SMLRContactsProvider addContactToDictionary:result simlarId:@"*0008*" name:@"Jackie Burkhart"  guiNumber:@"+49 176 666666"];
    [SMLRContactsProvider addContactToDictionary:result simlarId:@"*0003*" name:@"Peter Griffin"    guiNumber:@"+49 177 777777"];
    [SMLRContactsProvider addContactToDictionary:result simlarId:@"*0001*" name:@"Rosemarie"        guiNumber:@"+49 178 888888"];
    [SMLRContactsProvider addContactToDictionary:result simlarId:@"*0009*" name:@"Stan Smith"       guiNumber:@"+49 179 999999"];

    [self addressBookReadWithContacts:result];
}

- (void)getStatusForContacts
{
    SMLRLogI(@"start getting contacts status");
    self.status = SMLRContactsProviderStatusRequestingContactsStatus;

    [SMLRGetContactStatus getWithSimlarIds:[_contacts allKeys] completionHandler:^(NSDictionary *const contactStatusMap, NSError *const error) {
        if (error != nil) {
            if (isSMLRHttpsPostOfflineError(error)) {
                [self handleErrorWithErrorCode:SMLRContactsProviderErrorOffline];
                return;
            }

            [self handleError:error];
            return;
        }

        if (contactStatusMap == nil) {
            [self handleErrorWithMessage:@"empty contact status map"];
            return;
        }

        NSMutableArray *const simlarContacts = [NSMutableArray array];
        for (id simlarId in [contactStatusMap allKeys]) {
            SMLRContact *const contact = _contacts[simlarId];
            contact.registered = [(NSString *)contactStatusMap[simlarId] intValue] == 1;
            if (contact.registered) {
                [simlarContacts addObject:contact];
            }
        }

        SMLRLogI(@"Found %lu contacts registered at simlar", (unsigned long)[simlarContacts count]);

        [simlarContacts sortUsingSelector:@selector(compareByName:)];

        self.status = SMLRContactsProviderStatusInitialized;
        if (_simlarContactsHandler) {
            _simlarContactsHandler([SMLRContactsProvider groupContacts:simlarContacts], nil);
            self.simlarContactsHandler = nil;
        }
    }];
}

+ (NSArray *)groupContacts:(NSArray *const)sortedContacts
{
    if ([sortedContacts count] == 0) {
        return sortedContacts;
    }

    NSMutableArray *const groupedContacts = [NSMutableArray array];

    NSMutableArray *currentGroup = [NSMutableArray array];
    unichar currentGroupLetter   = '\0'; // no group letter

    for (SMLRContact *const contact in sortedContacts) {
        if ([contact getGroupLetter] != currentGroupLetter) {
            currentGroupLetter = [contact getGroupLetter];
            currentGroup = [NSMutableArray array];
            [groupedContacts addObject:currentGroup];
        }

        [currentGroup addObject:contact];
    }
    return groupedContacts;
}

@end
