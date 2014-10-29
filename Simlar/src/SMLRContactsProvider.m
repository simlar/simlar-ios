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
#import "SMLRLog.h"
#import "SMLRPhoneNumber.h"

#import <AddressBook/AddressBook.h>

@interface SMLRContactsProvider ()

@property (nonatomic) SMLRContactsProviderStatus status;
@property (nonatomic) NSDictionary *contacts;
@property (nonatomic) NSString *simlarIdToFind;
@property (nonatomic, copy) void (^simlarContactsHandler)(NSArray *const contacts, NSError *const);
@property (nonatomic, copy) void (^contactHandler)(SMLRContact *const contact, NSError *const);

@end

@implementation SMLRContactsProvider

- (void)getContactsWithCompletionHandler:(void (^)(NSArray *const contacts, NSError *const error))handler
{
    SMLRLogI(@"getContactsWithCompletionHandler with status=%@", nameSMLRContactsProviderStatus(self.status));
    self.simlarContactsHandler = handler;

    switch (self.status) {
        case SMLRContactsProviderStatusNone:
        case SMLRContactsProviderStatusError:
            [self requestAddressBookAccess];
            break;
        case SMLRContactsProviderStatusRequestingAddressBookAccess:
        case SMLRContactsProviderStatusParsingPhonesAddressBook:
        case SMLRContactsProviderStatusRequestingContactsStatus:
            break;
        case SMLRContactsProviderStatusInitialized:
        {
            NSMutableArray *const simlarContacts = [NSMutableArray array];
            for (SMLRContact *const contact in [self.contacts allValues]) {
                if (contact.registered) {
                    [simlarContacts addObject:contact];
                }
            }

            [simlarContacts sortUsingSelector:@selector(compareByName:)];

            self.status = SMLRContactsProviderStatusInitialized;
            if (self.simlarContactsHandler) {
                self.simlarContactsHandler([SMLRContactsProvider groupContacts:simlarContacts], nil);
                self.simlarContactsHandler = nil;
            }
            break;
        }
    }
}

- (void)getContactBySimlarId:(NSString *const)simlarId completionHanlder:(void (^)(SMLRContact *const contact, NSError *const error))handler
{
    SMLRLogI(@"getContactBySimlarId with status=%@", nameSMLRContactsProviderStatus(self.status));

    self.contactHandler = handler;
    self.simlarIdToFind = simlarId;

    if ([simlarId length] == 0) {
        SMLRLogI(@"SimlarId is empty");
        [self handleErrorWithMessage:@"SimlarId is empty"];
        return;
    }

    switch (self.status) {
        case SMLRContactsProviderStatusNone:
        case SMLRContactsProviderStatusError:
            [self requestAddressBookAccess];
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
    if (self.status == SMLRContactsProviderStatusInitialized) {
        SMLRLogI(@"reseting contacts");
        self.status = SMLRContactsProviderStatusNone;
    }
}

- (void)handleContactBySimlarId
{
    if (!self.contactHandler || [self.simlarIdToFind length] == 0) {
        return;
    }

    self.contactHandler(self.contacts[self.simlarIdToFind], nil);
    self.contactHandler = nil;
    self.simlarIdToFind = nil;
}

+ (NSString *)createNameWithFirstName:(NSString *const)firstName lastName:(NSString *const)lastName
{
    if ([firstName length] > 0 && [lastName length] > 0) {
        return ABPersonGetSortOrdering() == kABPersonSortByFirstName
        ? [NSString stringWithFormat:@"%@ %@", firstName, lastName]
        : [NSString stringWithFormat:@"%@ %@", lastName, firstName];
    }

    return [firstName length] > 0 ? firstName : lastName;
}

- (void)handleError:(NSError *const)error
{
    self.status = SMLRContactsProviderStatusError;

    if (self.simlarContactsHandler) {
        self.simlarContactsHandler(nil, error);
        self.simlarContactsHandler = nil;
    }

    if (self.contactHandler) {
        self.contactHandler(nil, error);
        self.contactHandler = nil;
    }
}

- (void)handleErrorWithMessage:(NSString *const)message
{
    [self handleError:[NSError errorWithDomain:@"org.simlar.contactsProvider" code:1 userInfo:@{ NSLocalizedDescriptionKey : message }]];
}

- (void)requestAddressBookAccess
{
    SMLRLogI(@"start requesting access to address book");
    self.status = SMLRContactsProviderStatusRequestingAddressBookAccess;
    CFErrorRef error = nil;
    const ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, &error);

    if (error != nil) {
        SMLRLogI(@"Error while creating address book reference: %@", error);
        CFRelease(addressBook);
        [self handleError:(__bridge_transfer NSError *)error];
        return;
    }

    if (addressBook == nil) {
        SMLRLogI(@"Error while creating address book reference");
        [self handleErrorWithMessage:@"Error while creating address book reference"];
        return;
    }

    ABAddressBookRequestAccessWithCompletion(addressBook, ^(const bool granted, const CFErrorRef requestAccessError) {
        dispatch_async(dispatch_get_main_queue(), ^(void){
            SMLRLogI(@"AddressBookRequestAccess granted=%d", granted);

            if (requestAccessError != nil) {
                [self handleError:(__bridge_transfer NSError *)requestAccessError];
            } else if (!granted) {
                [self handleErrorWithMessage:@"Address book access not granted"];
            } else {
                [self readContactsFromAddressBook:addressBook];
            }
        });
    });
}

- (void)readContactsFromAddressBook:(const ABAddressBookRef)addressBook
{
    SMLRLogI(@"start reading contacts from phones address book");
    self.status = SMLRContactsProviderStatusParsingPhonesAddressBook;

    NSArray *const allContacts = (__bridge_transfer NSArray *)ABAddressBookCopyArrayOfAllPeople(addressBook);

    NSMutableDictionary *const result = [NSMutableDictionary dictionary];
    for (id item in allContacts) {
        const ABRecordRef contact = (__bridge ABRecordRef)item;
        NSString *const firstName = (__bridge_transfer NSString*)ABRecordCopyValue(contact, kABPersonFirstNameProperty);
        NSString *const lastName  = (__bridge_transfer NSString*)ABRecordCopyValue(contact, kABPersonLastNameProperty);
        NSString *const name      = [SMLRContactsProvider createNameWithFirstName:firstName lastName:lastName];

        const ABMultiValueRef phoneNumbers = ABRecordCopyValue(contact, kABPersonPhoneProperty);
        for (CFIndex i = 0; i < ABMultiValueGetCount(phoneNumbers); i++) {
            NSString *const phoneNumber = (__bridge_transfer NSString *)ABMultiValueCopyValueAtIndex(phoneNumbers, i);
            if ([phoneNumber length] > 0) {
                if ([SMLRPhoneNumber isSimlarId:phoneNumber]) {
                    [result setValue:[[SMLRContact alloc]initWithSimlarId:phoneNumber
                                                       guiTelephoneNumber:phoneNumber
                                                                     name:name]
                              forKey:phoneNumber];
                } else {
                    SMLRPhoneNumber *const smlrPhoneNumber = [[SMLRPhoneNumber alloc] initWithNumber:phoneNumber];
                    if (![smlrPhoneNumber.getSimlarId isEqualToString:[SMLRCredentials getSimlarId]]) {
                        [result setValue:[[SMLRContact alloc] initWithSimlarId:[smlrPhoneNumber getSimlarId]
                                                            guiTelephoneNumber:[smlrPhoneNumber getGuiNumber]
                                                                          name:name]
                                  forKey:[smlrPhoneNumber getSimlarId]];
                    }
                }
            }
        }
        CFRelease(phoneNumbers);
        CFRelease(contact);
    }

    self.contacts = result;
    [self handleContactBySimlarId];
    [self getStatusForContacts];
}

- (void)getStatusForContacts
{
    SMLRLogI(@"start getting contacts status");
    self.status = SMLRContactsProviderStatusRequestingContactsStatus;

    [SMLRGetContactStatus getWithSimlarIds:[self.contacts allKeys] completionHandler:^(NSDictionary *const contactStatusMap, NSError *const error) {
        if (error != nil) {
            [self handleError:error];
            return;
        }

        if (contactStatusMap == nil) {
            [self handleErrorWithMessage:@"empty contact status map"];
            return;
        }

        NSMutableArray *const simlarContacts = [NSMutableArray array];
        for (id simlarId in [contactStatusMap allKeys]) {
            SMLRContact *const contact = self.contacts[simlarId];
            contact.registered = [(NSString *)contactStatusMap[simlarId] intValue] == 1;
            if (contact.registered) {
                [simlarContacts addObject:contact];
            }
        }

        SMLRLogI(@"Found %lu contacts registered at simlar", (unsigned long)[simlarContacts count]);

        [simlarContacts sortUsingSelector:@selector(compareByName:)];

        self.status = SMLRContactsProviderStatusInitialized;
        if (self.simlarContactsHandler) {
            self.simlarContactsHandler([SMLRContactsProvider groupContacts:simlarContacts], nil);
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
