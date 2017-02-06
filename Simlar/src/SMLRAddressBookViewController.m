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

#import "SMLRAddressBookViewController.h"

#import "SMLRAlert.h"
#import "SMLRCallViewController.h"
#import "SMLRContact.h"
#import "SMLRContactsProvider.h"
#import "SMLRIncomingCallLocalNotification.h"
#import "SMLRLog.h"
#import "SMLRMissedCallLocalNotification.h"
#import "SMLRNoAddressBookPermissionViewController.h"
#import "SMLRNoAddressBookPermissionViewControllerDelegate.h"
#import "SMLRPhoneManager.h"
#import "SMLRPhoneManagerDelegate.h"
#import "SMLRSettingsChecker.h"

#import <AVFoundation/AVFoundation.h>


@interface SMLRAddressBookViewController () <UITableViewDelegate, UITableViewDataSource, SMLRPhoneManagerRootViewControllerDelegate, SMLRNoAddressBookPermissionViewControllerDelegate>

@property (nonatomic, retain) UIRefreshControl *refreshControl;
@property (weak, nonatomic) IBOutlet UITableView *contactsTableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicator;

@property (nonatomic) NSArray *groupedContacts;
@property (nonatomic) SMLRPhoneManager *phoneManager;
@property (nonatomic) SMLRContactsProvider *contactsProvider;
@property (nonatomic) UILocalNotification *incomingCallNotification;

@end

@implementation SMLRAddressBookViewController

- (instancetype)initWithCoder:(NSCoder *const)aDecoder
{
    SMLRLogFunc;
    self = [super initWithCoder:aDecoder];
    if (self == nil) {
        SMLRLogE(@"unable to create SMLRAddressBookViewController");
        return nil;
    }

    _phoneManager     = [[SMLRPhoneManager alloc] init];
    _contactsProvider = [[SMLRContactsProvider alloc] init];

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    SMLRLogFunc;

    _contactsTableView.backgroundView  = nil;
    _contactsTableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"BackgroundTile"]];
    _contactsTableView.separatorColor  = [UIColor clearColor];

    [_phoneManager setDelegateRootViewController:self];

    [_contactsTableView setDelegate:self];
    [_contactsTableView setDataSource:self];

    self.refreshControl = [[UIRefreshControl alloc] init];
    [_refreshControl addTarget:self action:@selector(reloadContacts) forControlEvents:UIControlEventValueChanged];
    [_contactsTableView addSubview:_refreshControl];
}

- (void)viewWillAppear:(const BOOL)animated
{
    [super viewWillAppear:animated];
    SMLRLogFunc;

    [_contactsTableView deselectRowAtIndexPath:[_contactsTableView indexPathForSelectedRow] animated:animated];
}

- (void)viewDidAppear:(const BOOL)animated
{
    [super viewDidAppear:animated];
    SMLRLogFunc;

    /// make sure other view controllers get garbage collected
    self.view.window.rootViewController = self;

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appplicationDidBecomeActive)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appplicationWillResignActive)
                                                 name:UIApplicationWillResignActiveNotification
                                               object:nil];

    [self checkStatus];
}

- (void)viewWillDisappear:(BOOL)animated
{
    SMLRLogFunc;

    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillResignActiveNotification object:nil];

    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    SMLRLogFunc;
}

- (void)appplicationDidBecomeActive
{
    SMLRLogFunc;

    [self checkStatus];
}

- (void)appplicationWillResignActive
{
    SMLRLogFunc;

    UIAlertController *const alert = (UIAlertController *)self.presentedViewController;
    if ([alert isKindOfClass:UIAlertController.class]) {
        SMLRLogI(@"dismissing alert view: %@", alert.title);
        [alert dismissViewControllerAnimated:NO completion:nil];
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *const)tableView
{
    // Return the number of sections.
    return [_groupedContacts count];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    const unichar c        = [((SMLRContact *)_groupedContacts[section][0]) getGroupLetter];
    const CGFloat radius   = 10.0;
    const CGFloat diameter = 2 * radius;

    UILabel *const label = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, diameter, diameter)];
    label.font                = [UIFont boldSystemFontOfSize:16];
    label.text                = [NSString stringWithCharacters:&c length:1];
    label.textAlignment       = NSTextAlignmentCenter;
    label.layer.cornerRadius  = radius;
    label.layer.borderWidth   = 0.8;
    label.backgroundColor     = [UIColor whiteColor];
    label.layer.position      = CGPointMake(22.0, 12.0);
    label.layer.masksToBounds = YES;

    UIView *const view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, tableView.frame.size.width, 20)];
    [view addSubview:label];
    view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"BackgroundTile"]];
    return view;
}

- (NSInteger)tableView:(UITableView *const)tableView numberOfRowsInSection:(const NSInteger)section
{
    // Return the number of rows in the section.
    return [_groupedContacts[section] count];
}

- (UITableViewCell *)tableView:(UITableView *const)tableView cellForRowAtIndexPath:(NSIndexPath *const)indexPath
{
    UITableViewCell *const cell = [tableView dequeueReusableCellWithIdentifier:@"ContactCell" forIndexPath:indexPath];
    if (cell != nil) {
        cell.textLabel.text       = ((SMLRContact *)_groupedContacts[indexPath.section][indexPath.row]).name;
        cell.detailTextLabel.text = ((SMLRContact *)_groupedContacts[indexPath.section][indexPath.row]).guiTelephoneNumber;
    }
    return cell;
}

- (void)tableView:(UITableView *const)tableView didSelectRowAtIndexPath:(NSIndexPath *const)indexPath
{
    [self callContact:(SMLRContact *)_groupedContacts[indexPath.section][indexPath.row]];
}

- (IBAction)unwindToAddressBook:(UIStoryboardSegue *const)segue
{
    SMLRLogFunc;
}

- (void)checkStatus
{
    [SMLRSettingsChecker checkStatus:self completionHandler:^{
        [self loadContacts];
    }];
}

- (void)loadContacts
{
    SMLRLogFunc;

    [_refreshControl beginRefreshing];
    _contactsTableView.hidden = YES;
    _loadingIndicator.hidden  = NO;
    [_loadingIndicator startAnimating];
    [_contactsProvider getContactsWithCompletionHandler:^(NSArray *const contacts, NSError *const error) {
        [_refreshControl endRefreshing];
        _loadingIndicator.hidden = YES;
        [_loadingIndicator stopAnimating];
        _contactsTableView.hidden = NO;

        if (error != nil) {
            if (![error.domain isEqualToString:SMLRContactsProviderErrorDomain]) {
                [self showUnknownAddressBookError:error];
                return;
            }

            switch ((SMLRContactsProviderError)error.code) {
                case SMLRContactsProviderErrorUnknown:
                    [self showUnknownAddressBookError:error];
                    return;
                case SMLRContactsProviderErrorNoPermission:
                    [self showNoAddressBookPermission];
                    return;
                case SMLRContactsProviderErrorOffline:
                    [self showOfflineMessage];
                    return;
            }
        }

        if (contacts == nil) {
            SMLRLogI(@"Error: no contacts and no error");
            [self showNoContactsFound];
            return;
        }

        if ([contacts count] == 0) {
            [self showNoContactsFound];
            return;
        }

        self.groupedContacts = contacts;
        [_contactsTableView reloadData];
    }];
}

- (void)reloadContacts
{
    SMLRLogFunc;
    [_contactsProvider reset];
    [self loadContacts];
}

- (void)showUnknownAddressBookError:(NSError *const)error
{
    [SMLRAlert showWithViewController:self
                                title:@"Address Book Unknown Error"
                              message:error.localizedDescription
                          buttonTitle:@"Try Again"
                        buttonHandler:^(UIAlertAction *action) {
                            [self checkStatus];
                        }];
}

- (void)showNoAddressBookPermission
{
    SMLRLogFunc;

    SMLRNoAddressBookPermissionViewController *const viewController =
        [[self storyboard] instantiateViewControllerWithIdentifier:@"SMLRNoAddressBookPermissionViewController"];
    [viewController setDelegate:self];
    [self presentViewController:viewController animated:NO completion:nil];
}

- (void)showOfflineMessage
{
    [SMLRAlert showWithViewController:self
                                title:@"You Are Offline"
                              message:@"Check your internet connection."
                          buttonTitle:@"Try Again"
                        buttonHandler:^(UIAlertAction *action) {
                            [self checkStatus];
                        }];
}

- (void)showNoContactsFound
{
    [SMLRAlert showWithViewController:self
                                title:@"No Contacts Found"
                              message:@"Ask some friends to install Simlar!"
                          buttonTitle:@"Try Again"
                        buttonHandler:^(UIAlertAction *action) {
                            [self reloadContacts];
                        }];
}

- (void)checkForIncomingCalls
{
    SMLRLogFunc;
    [_phoneManager checkForIncomingCall];
}

- (void)acceptCall
{
    SMLRLogFunc;
    [_phoneManager acceptCall];
}

- (void)declineCall
{
    SMLRLogFunc;
    [_phoneManager terminateAllCalls];
}

- (void)callContact:(SMLRContact *const)contact
{
    [self callContact:contact parent:self];
}

- (void)callContact:(SMLRContact *const)contact parent:(UIViewController *const)parent
{
    [_phoneManager callWithSimlarId:contact.simlarId];
    
    SMLRCallViewController *const viewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"SMLRCallViewController"];
    viewController.phoneManager = _phoneManager;
    viewController.contact      = contact;
    [parent presentViewController:viewController animated:YES completion:nil];
}

- (void)onIncomingCall
{
    NSString *const simlarId = [_phoneManager getCurrentCallSimlarId];
    SMLRLogI(@"incoming call with simlarId=%@", simlarId);

    [_contactsProvider getContactBySimlarId:simlarId completionHandler:^(SMLRContact *const contact, NSError *const error) {
        if (error != nil) {
            SMLRLogE(@"Error getting contact: %@", error);
        }

        SMLRContact *const contactCalling = contact != nil ? contact :
                                            [[SMLRContact alloc] initWithSimlarId:simlarId guiTelephoneNumber:simlarId name:simlarId];


        [self showIncomingCallViewWithContact:contactCalling];

        if ([UIApplication sharedApplication].applicationState != UIApplicationStateActive) {
            [self showIncomingCallNotificationWithContact:contactCalling];
        }
    }];
}

- (UIViewController *)getPresentingViewController
{
    UIViewController *viewController = self;
    while ([viewController.presentedViewController isKindOfClass:UIViewController.class]) {
        viewController = viewController.presentedViewController;
    }
    return viewController;
}

- (void)showIncomingCallViewWithContact:(SMLRContact *const)contact
{
    SMLRLogFunc;

    UIViewController *const currentViewController = [self getPresentingViewController];

    SMLRCallViewController *const currentCallViewController = (SMLRCallViewController *)currentViewController;
    if ([currentCallViewController isKindOfClass:SMLRCallViewController.class]) {
        currentCallViewController.phoneManager = _phoneManager;
        currentCallViewController.contact      = contact;
        [currentCallViewController update];
    } else {
        [self presentCallViewControllerWithPresenter:currentViewController contact:contact];
    }
}

- (void)presentCallViewControllerWithPresenter:(UIViewController *const)presenter contact:(SMLRContact *const)contact
{
    SMLRCallViewController *const viewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"SMLRCallViewController"];
    viewController.phoneManager = _phoneManager;
    viewController.contact      = contact;
    [presenter presentViewController:viewController animated:YES completion:nil];
}

+ (float)getSoundDuration:(NSString *const)resourceFileName
{
    return CMTimeGetSeconds([AVURLAsset URLAssetWithURL:[[NSBundle mainBundle] URLForResource:resourceFileName withExtension:nil]
                                                options:nil].duration);
}

- (void)showIncomingCallNotificationWithContact:(SMLRContact *const)contact
{
    SMLRLogFunc;

    [self cancelIncomingCallLocalNotification];

    self.incomingCallNotification = [SMLRIncomingCallLocalNotification createWithContactName:contact.name];

    [[UIApplication sharedApplication] presentLocalNotificationNow:_incomingCallNotification];
}

- (void)onCallEnded:(NSString *const)missedCaller
{
    SMLRLogFunc;

    [self cancelIncomingCallLocalNotification];

    if ([missedCaller length] > 0) {
        SMLRLogI(@"missed call with simlarId=%@", missedCaller);

        [_contactsProvider getContactBySimlarId:missedCaller completionHandler:^(SMLRContact *const contact, NSError *const error) {
            if (error != nil) {
                SMLRLogE(@"Error getting contact: %@", error);
            }

            SMLRLogI(@"showing missed call notification");
            [[UIApplication sharedApplication] presentLocalNotificationNow:[SMLRMissedCallLocalNotification createWithContact:
                                                                            contact != nil ? contact :
                                                                            [[SMLRContact alloc] initWithSimlarId:missedCaller guiTelephoneNumber:missedCaller name:missedCaller]]];
        }];
    }
}

- (void)cancelIncomingCallLocalNotification
{
    if (_incomingCallNotification == nil) {
        return;
    }

    [[UIApplication sharedApplication] cancelLocalNotification:_incomingCallNotification];
    _incomingCallNotification = nil;
}

@end
