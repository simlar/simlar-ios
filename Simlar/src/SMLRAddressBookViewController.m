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

#import "SMLRCallViewController.h"
#import "SMLRContact.h"
#import "SMLRContactsProvider.h"
#import "SMLRCredentials.h"
#import "SMLRLog.h"
#import "SMLRPhoneManager.h"
#import "SMLRPhoneManagerDelegate.h"
#import "SMLRReportBug.h"
#import "SMLRRingingViewController.h"
#import "SMLRSettings.h"

#import <AVFoundation/AVFoundation.h>


@interface SMLRAddressBookViewController () <UITableViewDelegate, UITableViewDataSource, SMLRPhoneManagerRootViewControllerDelegate>

@property (nonatomic, retain) UIRefreshControl *refreshControl;
@property (weak, nonatomic) IBOutlet UITableView *contactsTableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicator;

@property NSArray *groupedContacts;
@property SMLRPhoneManager *phoneManager;
@property SMLRContactsProvider *contactsProvider;
@property SMLRReportBug *reportBug;

@end

@implementation SMLRAddressBookViewController

static NSString *const kRingToneFileName = @"ringtone.wav";

- (instancetype)initWithCoder:(NSCoder *const)aDecoder
{
    SMLRLogFunc;
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.phoneManager = [[SMLRPhoneManager alloc] init];
        self.contactsProvider = [[SMLRContactsProvider alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    SMLRLogFunc;

    [self.phoneManager setDelegateRootViewController:self];

    [self.contactsTableView setDelegate:self];
    [self.contactsTableView setDataSource:self];

    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(reloadContacts) forControlEvents:UIControlEventValueChanged];
    [self.contactsTableView addSubview:self.refreshControl];
}

- (void)viewWillAppear:(const BOOL)animated
{
    [super viewWillAppear:animated];
    SMLRLogFunc;

    [self.contactsTableView deselectRowAtIndexPath:[self.contactsTableView indexPathForSelectedRow] animated:animated];
}

- (void)viewDidAppear:(const BOOL)animated
{
    [super viewDidAppear:animated];
    SMLRLogFunc;

    /// make sure other view controllers get garbage collected
    self.view.window.rootViewController = self;

    [self checkReportBug];
    [self checkCreateAccountStatus];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onUserDefaultsChanged)
                                                 name:NSUserDefaultsDidChangeNotification
                                               object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    SMLRLogFunc;
}

- (void)onUserDefaultsChanged
{
    SMLRLogFunc;

    [SMLRLog enableLogging:[SMLRSettings getLogEnabled]];

    [self checkReportBug];

    if ([SMLRSettings getReregisterNextStart]) {
        [self checkCreateAccountStatus];
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *const)tableView
{
    // Return the number of sections.
    return [self.groupedContacts count];
}

- (NSString *)tableView:(UITableView *const)tableView titleForHeaderInSection:(const NSInteger)section
{
    const unichar c = [((SMLRContact *)self.groupedContacts[section][0]) getGroupLetter];
    return [NSString stringWithCharacters:&c length:1];
}

- (NSInteger)tableView:(UITableView *const)tableView numberOfRowsInSection:(const NSInteger)section
{
    // Return the number of rows in the section.
    return [self.groupedContacts[section] count];
}

- (UITableViewCell *)tableView:(UITableView *const)tableView cellForRowAtIndexPath:(NSIndexPath *const)indexPath
{
    UITableViewCell *const cell = [tableView dequeueReusableCellWithIdentifier:@"ContactCell" forIndexPath:indexPath];
    if (cell != nil) {
        cell.textLabel.text       = ((SMLRContact *)self.groupedContacts[indexPath.section][indexPath.row]).name;
        cell.detailTextLabel.text = ((SMLRContact *)self.groupedContacts[indexPath.section][indexPath.row]).guiTelephoneNumber;
    }
    return cell;
}

- (void)tableView:(UITableView *const)tableView didSelectRowAtIndexPath:(NSIndexPath *const)indexPath
{
    [self.phoneManager callWithSimlarId:((SMLRContact *)self.groupedContacts[indexPath.section][indexPath.row]).simlarId];

    SMLRCallViewController *const viewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"SMLRCallViewController"];
    viewController.phoneManager   = self.phoneManager;
    viewController.guiContactName = ((SMLRContact *)self.groupedContacts[indexPath.section][indexPath.row]).name;
    [self presentViewController:viewController animated:YES completion:nil];
}

- (IBAction)unwindToAddressBook:(UIStoryboardSegue *const)segue
{
    SMLRLogFunc;
}

- (void)checkReportBug
{
    if ([SMLRSettings getReportBugNextStart]) {
        [SMLRSettings resetReportBugNextStart];
        if (!self.reportBug) {
            self.reportBug = [[SMLRReportBug alloc] initWithViewController:self];
        }
        [self.reportBug reportBug];
    }
}

+ (NSString *)getViewControllerNameBasedOnCreateAccountStatus
{
    if ([SMLRSettings getReregisterNextStart]) {
        SMLRLogI(@"user triggered reregistration => deleting credentials and settings => starting AgreeViewController");
        [SMLRSettings reset];
        [SMLRCredentials delete];
        return @"SMLRAgreeViewController";
    }

    switch ([SMLRSettings getCreateAccountStatus]) {
        case SMLRCreateAccountStatusSuccess:
            if (![SMLRCredentials isInitialized]) {
                SMLRLogI(@"ERROR: CreateAccountStatusSuccess but simlarId or password not set => starting AgreeViewController");
                return @"SMLRAgreeViewController";
            }
            SMLRLogI(@"CreateAccountStatusSuccess");
            return nil;
        case SMLRCreateAccountStatusWaitingForSms:
            SMLRLogI(@"CreateAccountStatusWaitingForSms => starting CreateAccountViewController");
            return @"SMLRCreateAccountViewController";
        case SMLRCreateAccountStatusAgreed:
            SMLRLogI(@"CreateAccountStatusAgreed => starting VerifyNumberViewController");
            return @"SMLRVerifyNumberViewController";
        case SMLRCreateAccountStatusNone:
        default:
            SMLRLogI(@"CreateAccountStatusNone => starting AgreeViewController");
            return @"SMLRAgreeViewController";
    }
}

- (void)checkCreateAccountStatus
{
    SMLRLogFunc;
    NSString *viewControllerName = [SMLRAddressBookViewController getViewControllerNameBasedOnCreateAccountStatus];
    if (viewControllerName != nil) {
        UIViewController *viewController = [[self storyboard] instantiateViewControllerWithIdentifier:viewControllerName];
        [self presentViewController:viewController animated:NO completion:nil];
    } else {
        [self loadContacts];
    }
}

- (void)loadContacts
{
    [self.refreshControl beginRefreshing];
    [self.contactsTableView setHidden:YES];
    [self.loadingIndicator setHidden:NO];
    [self.loadingIndicator startAnimating];
    [self.contactsProvider getContactsWithCompletionHandler:^(NSArray *const contacts, NSError *const error) {
        [self.refreshControl endRefreshing];
        [self.loadingIndicator setHidden:YES];
        [self.loadingIndicator stopAnimating];
        [self.contactsTableView setHidden:NO];

        if (error != nil) {
            SMLRLogI(@"Error while getting contacts: %@", error);
            [self showOfflineMessage];
            return;
        }

        if (contacts == nil) {
            SMLRLogI(@"Error: no contacts and no error");
            [self showOfflineMessage];
            return;
        }

        if ([contacts count] == 0) {
            [self showNoContactsFound];
            return;
        }

        self.groupedContacts = contacts;
        [self.contactsTableView reloadData];
    }];
}

- (void)reloadContacts
{
    [self.contactsProvider reset];
    [self loadContacts];
}

- (void)showOfflineMessage
{
    UIViewController *viewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"SMLROfflineViewController"];
    [self presentViewController:viewController animated:NO completion:nil];
}

- (void)showNoContactsFound
{
    UIViewController *viewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"SMLRNoContactsFoundViewController"];
    [self presentViewController:viewController animated:NO completion:nil];
}

- (void)checkForIncomingCalls
{
    SMLRLogFunc;
    [self.phoneManager checkForIncomingCall];
}

- (void)onIncomingCall
{
    NSString *const simlarId = [self.phoneManager getCurrentCallSimlarId];
    SMLRLogI(@"incoming call with simlarId=%@", simlarId);

    [self.contactsProvider getContactBySimlarId:simlarId completionHanlder:^(SMLRContact *const contact, NSError *const error) {
        if (error != nil) {
            SMLRLogE(@"Error getting contact: %@", error);
        }

        SMLRContact *const contactCalling = contact != nil ? contact :
                                            [[SMLRContact alloc] initWithSimlarId:simlarId guiTelephoneNumber:simlarId name:simlarId];


        [self showIncomingCallWithContact:contactCalling];

        if ([UIApplication sharedApplication].applicationState != UIApplicationStateActive) {
            [self showIncomingCallNotificationWithContact:contactCalling];
        }
    }];
}

- (void)showIncomingCallWithContact:(SMLRContact *const)contact
{
    SMLRLogFunc;

    SMLRRingingViewController *const viewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"SMLRRingingViewController"];
    viewController.phoneManager = self.phoneManager;
    viewController.contact      = contact;
    [self presentViewController:viewController animated:YES completion:nil];
}

+ (float)getSoundDuration:(NSString *const)resourceFileName
{
    return CMTimeGetSeconds([AVURLAsset URLAssetWithURL:[[NSBundle mainBundle] URLForResource:resourceFileName withExtension:nil]
                                                options:nil].duration);
}

- (void)showIncomingCallNotificationWithContact:(SMLRContact *const)contact
{
    SMLRLogFunc;

    UILocalNotification *const incomingCallNotification = [[UILocalNotification alloc] init];
    incomingCallNotification.alertBody   = [NSString stringWithFormat:@"%@ is calling you", contact.name];
    incomingCallNotification.alertAction = @"Accept";
    incomingCallNotification.soundName   = kRingToneFileName;
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [[UIApplication sharedApplication] presentLocalNotificationNow:incomingCallNotification];

    const float retriggerInterval = [SMLRAddressBookViewController getSoundDuration:kRingToneFileName] + 1;
    SMLRLogI(@"schedule check for new incoming call local notification in %.1f seconds", retriggerInterval);
    [NSTimer scheduledTimerWithTimeInterval:retriggerInterval
                                     target:self
                                   selector:@selector(showIncomingCallNotificationTimer:)
                                   userInfo:contact
                                    repeats:NO];
}

- (void)showIncomingCallNotificationTimer:(NSTimer *const)timer
{
    if (![self.phoneManager hasIncomingCall] || [UIApplication sharedApplication].applicationState == UIApplicationStateActive) {
        return;
    }

    [self showIncomingCallNotificationWithContact:timer.userInfo];
}

- (void)onCallEnded
{
    SMLRLogFunc;

    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}

@end
