/**
 * Copyright (C) 2017 The Simlar Authors.
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

#import "SMLRNoAddressBookPermissionViewController.h"

#import "SMLRAlert.h"
#import "SMLRContact.h"
#import "SMLRLog.h"
#import "SMLRNoAddressBookPermissionViewControllerDelegate.h"

#import <ContactsUI/ContactsUI.h>


@interface SMLRNoAddressBookPermissionViewController  () <CNContactPickerDelegate>

- (IBAction)buttonGoToSettingsPressed:(id)sender;
- (IBAction)buttonCallContactPressed:(id)sender;

@property (weak, nonatomic) id<SMLRNoAddressBookPermissionViewControllerDelegate> delegate;

@end

@implementation SMLRNoAddressBookPermissionViewController

- (instancetype)initWithCoder:(NSCoder *const)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self == nil) {
        SMLRLogE(@"unable to create SMLRNoAddressBookPermissionViewController");
        return nil;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)buttonGoToSettingsPressed:(id)sender
{
    SMLRLogFunc;
    /// Note: iOS sends a SIGKILL to the app after the user changed permission preferences
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
}

- (IBAction)buttonCallContactPressed:(id)sender
{
    SMLRLogFunc;

    CNContactPickerViewController *contactPicker = [[CNContactPickerViewController alloc] init];
    /// partially working: displays only telephone numbers but still lets you pick e.g. e-mails
    contactPicker.displayedPropertyKeys = @[ CNContactPhoneNumbersKey ];
    /// show details only for contacts with more than one number
    contactPicker.predicateForSelectionOfContact = [NSPredicate predicateWithFormat:@"%K.@count == 1", CNContactPhoneNumbersKey];
    contactPicker.delegate = self;

    [self presentViewController:contactPicker animated:YES completion:nil];
}

- (void)contactPicker:(CNContactPickerViewController *const)picker didSelectContactProperty:(CNContactProperty *const)contactProperty
{
    dispatch_async(dispatch_get_main_queue(), ^(void){
        SMLRLogI(@"contactPicker did select contact property %@", contactProperty);

        [self callContact:contactProperty.contact
              phoneNumber:([CNContactPhoneNumbersKey isEqualToString:contactProperty.key]) ? [contactProperty.value stringValue] : contactProperty.value];
    });
}

- (void)contactPicker:(CNContactPickerViewController *const)picker didSelectContact:(CNContact *const)contact
{
    dispatch_async(dispatch_get_main_queue(), ^(void){
        SMLRLogI(@"contactPicker did select contact %@", contact);

        if ([contact.phoneNumbers count] <= 0) {
            SMLRLogE(@"contact has no telephone number");
            [SMLRAlert showWithViewController:self
                                        title:@"No telephone number"
                                      message:@"Your contact does not have a number. Pick another one."];
        } else {
            NSString *const phoneNumber = [contact.phoneNumbers[0].value stringValue];
            if ([contact.phoneNumbers count] > 1) {
                SMLRLogW(@"contact has more than one number using first %@", phoneNumber);
            }
            [self callContact:contact phoneNumber:phoneNumber];
        }
    });
}

- (void)callContact:(CNContact *const)contact phoneNumber:(NSString *const)phoneNumber
{
    SMLRContact *const simlarContact = [[SMLRContact alloc] initWithContact:contact phoneNumber:phoneNumber];
    if (!simlarContact) {
        SMLRLogE(@"invalid telephone number: %@", phoneNumber);
        [SMLRAlert showWithViewController:self
                                    title:@"Invalid telephone number"
                                  message:[NSString stringWithFormat:@"The number:\n%@\n is not usable with Simlar. Choose another contact.", phoneNumber]];
        return;
    }

    [self.delegate callContact:simlarContact
                        parent:self];
}

@end
