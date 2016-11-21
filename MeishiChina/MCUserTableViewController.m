//
//  MCUserTableViewController.m
//  MeishiChina
//
//  Created by Zheng on 06/11/2016.
//  Copyright © 2016 Zheng. All rights reserved.
//

#import "MCUserTableViewController.h"
#import "MCAvatarTableViewCell.h"
#import "MCCommonTableViewCell.h"
#import "MCSettingsTableViewController.h"
#import "MCWhiteNavigationController.h"
#import "MCLoginViewController.h"

static const NSInteger MCUserTableViewSectionNum = 4;
typedef enum : NSUInteger {
    MCUserTableViewSectionLogin = 0,
    MCUserTableViewSectionCard,
    MCUserTableViewSectionCategory,
    MCUserTableViewSectionLogout,
} MCUserTableViewSection;

static const NSInteger MCUserTableViewSectionLoginRowNum = 1;
typedef enum : NSUInteger {
    MCUserTableViewSectionLoginRowHead = 0,
} MCUserTableViewSectionLoginRow;
static NSString * const MCUserTableViewSectionLoginRowCellIdentifier = @"MCUserTableViewSectionLoginRowCellIdentifier";

static const NSInteger MCUserTableViewSectionCardRowNum = 1;
typedef enum : NSUInteger {
    MCUserTableViewSectionCardRowHead = 0,
} MCUserTableViewSectionCardRow;

static const NSInteger MCUserTableViewSectionCategoryRowNum = 4;
typedef enum : NSUInteger {
    MCUserTableViewSectionCategoryRowPublish = 0,
    MCUserTableViewSectionCategoryRowFavourite,
    MCUserTableViewSectionCategoryRowComment,
    MCUserTableViewSectionCategoryRowZan
} MCUserTableViewSectionCategoryRow;

static const NSInteger MCUserTableViewSectionLogoutRowNum = 1;
typedef enum : NSUInteger {
    MCUserTableViewSectionLogoutRowHead = 0,
} MCUserTableViewSectionLogoutRow;
static NSString * const MCUserTableViewSectionCommonRowCellIdentifier = @"MCUserTableViewSectionCommonRowCellIdentifier";

@interface MCUserTableViewController () <MCCellAvatarDelegate>
@property (nonatomic, strong) UIBarButtonItem *settingsButton; // Lazy

@end

@implementation MCUserTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.navigationController.navigationBar setTranslucent:NO];
    
    self.title = NSLocalizedString(@"Me", nil);
    self.navigationItem.rightBarButtonItem = self.settingsButton;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateUserState:MNet.userState];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationReceived:) name:MCNetworkNotificationUserStateChanged object:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MCNetworkNotificationUserStateChanged object:nil];
}

#pragma mark - Notification

- (void)notificationReceived:(NSNotification *)aNotification {
    if ([aNotification.name isEqualToString:MCNetworkNotificationUserStateChanged]) {
        [self updateUserState:aNotification.userInfo[MCNetworkNotificationUserInfoKeyUserState]];
    }
}

- (void)updateUserState:(NSDictionary *)userState {
    for (id cellObj in self.tableView.visibleCells) {
        if ([cellObj isKindOfClass:[MCAvatarTableViewCell class]]) {
            MCAvatarTableViewCell *cell = cellObj;
            [self reloadCell:cell withUserState:userState];
        }
    }
}

- (void)reloadCell:(MCAvatarTableViewCell *)cell withUserState:(NSDictionary *)userState {
    if (nil != userState) {
        NSString *username = userState[MCNetworkUserStateKeyUserName];
        cell.userNameText = username;
        cell.userEmailText = [NSString stringWithFormat:@"%@@82flex.com", [[username sha1String] substringToIndex:8]];
    } else {
        cell.userNameText = nil;
        cell.userEmailText = nil;
    }
}

#pragma mark - Bar Button Item

- (UIBarButtonItem *)settingsButton
{
    if (!_settingsButton)
    {
        UIBarButtonItem *settingsButton =
                [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"gear"]
                                                 style:UIBarButtonItemStylePlain
                                                target:self action:@selector(barButtonTapped:)];
        _settingsButton = settingsButton;
    }
    return _settingsButton;
}

#pragma mark - Selector Actions

- (void)barButtonTapped:(UIBarButtonItem *)sender
{
    if (sender == self.settingsButton)
    {
        MCSettingsTableViewController *settingsController = [[MCSettingsTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
        [self.navigationController pushViewController:settingsController animated:YES];
    }
}

#pragma mark - Table View Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return MCUserTableViewSectionNum;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case MCUserTableViewSectionLogin:
            return MCUserTableViewSectionLoginRowNum;
        case MCUserTableViewSectionCard:
            return MCUserTableViewSectionCardRowNum;
        case MCUserTableViewSectionCategory:
            return MCUserTableViewSectionCategoryRowNum;
        case MCUserTableViewSectionLogout:
            return MCUserTableViewSectionLogoutRowNum;
        default:
            break;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case MCUserTableViewSectionLogin:
            return 96;
        case MCUserTableViewSectionCard:
        case MCUserTableViewSectionCategory:
        case MCUserTableViewSectionLogout:
            return 48;
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == MCUserTableViewSectionLogin)
    {
        if (indexPath.row == MCUserTableViewSectionLoginRowHead)
        {
            MCAvatarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MCUserTableViewSectionLoginRowCellIdentifier];
            if (nil == cell)
            {
                cell = [[MCAvatarTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                    reuseIdentifier:MCUserTableViewSectionLoginRowCellIdentifier];
                cell.avatarDelegate = self;
            }
            [self reloadCell:cell withUserState:MNet.userState];
            return cell;
        }
    }
    else
    {
        MCCommonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MCUserTableViewSectionCommonRowCellIdentifier];
        if (nil == cell)
        {
            cell = [[MCCommonTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                reuseIdentifier:MCUserTableViewSectionCommonRowCellIdentifier];
        }
        if (indexPath.section == MCUserTableViewSectionCard)
        {
            if (indexPath.row == MCUserTableViewSectionCardRowHead)
            {
                cell.textLabel.text = NSLocalizedString(@"Message Cards", nil);
#ifdef DEBUG
                cell.displayValue = 12;
#endif
            }
        }
        else if (indexPath.section == MCUserTableViewSectionCategory)
        {
            if (indexPath.row == MCUserTableViewSectionCategoryRowPublish)
            {
                cell.textLabel.text = NSLocalizedString(@"Recipes", nil);
            }
            else if (indexPath.row == MCUserTableViewSectionCategoryRowFavourite)
            {
                cell.textLabel.text = NSLocalizedString(@"Favourites", nil);
            }
            else if (indexPath.row == MCUserTableViewSectionCategoryRowComment)
            {
                cell.textLabel.text = NSLocalizedString(@"Comments & Ratings", nil);
            }
            else if (indexPath.row == MCUserTableViewSectionCategoryRowZan)
            {
                cell.textLabel.text = NSLocalizedString(@"Zans", nil);
            }
        }
        else if (indexPath.section == MCUserTableViewSectionLogout)
        {
            if (indexPath.row == MCUserTableViewSectionLogoutRowHead)
            {
                cell.textLabel.text = NSLocalizedString(@"Logout", nil);
            }
        }
        
        return cell;
    }
    return [[MCCommonTableViewCell alloc] init];
}

#pragma mark - Table View Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == MCUserTableViewSectionLogin) {
        if (indexPath.row == MCUserTableViewSectionLoginRowHead) {
            
        }
    } else if (indexPath.section == MCUserTableViewSectionCard) {
        if (indexPath.row == MCUserTableViewSectionCardRowHead) {
#ifdef DEBUG
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            [(MCCommonTableViewCell *)cell setDisplayValue:0];
            [self.navigationController.tabBarItem setBadgeValue:nil];
#endif
        }
    } else if (indexPath.section == MCUserTableViewSectionLogout) {
        if (indexPath.row == MCUserTableViewSectionLogoutRowHead) {
            [self logoutNow];
        }
    }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

#pragma mark - Component Actions

- (void)avatarDidTapped:(MCCellAvatar *)avatar {
    if (MNet.userState) {
        
    } else {
        MCLoginViewController *loginViewController = [[MCLoginViewController alloc] init];
        MCWhiteNavigationController *transparentController = [[MCWhiteNavigationController alloc] initWithRootViewController:loginViewController];
        [self.navigationController presentViewController:transparentController animated:YES completion:nil];
    }
}

#pragma mark - Actions

- (void)logoutNow {
    if (!MNet.userState) return;
    NSDictionary *requestDictionary = @{
                                        @"action": @"logout",
                                        };
    self.navigationController.view.userInteractionEnabled = NO;
    [self.navigationController.view makeToastActivity:CSToastPositionCenter];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^() {
        NSError *requestError = nil;
        NSDictionary *responseDictionary = [MNet sendSynchronousRequest:requestDictionary error:&requestError];
        dispatch_async_on_main_queue(^() {
            [self.navigationController.view hideToastActivity];
            self.navigationController.view.userInteractionEnabled = YES;
            if (requestError != nil) {
                [self.navigationController.view makeToast:[requestError localizedDescription]];
                return;
            }
            MCLog(@"%@", responseDictionary);
            NSString *errorMsg = responseDictionary[@"error"];
            if (errorMsg && errorMsg.length > 0) {
                [self.navigationController.view makeToast:errorMsg];
                return;
            }
            [self.navigationController.view makeToast:NSLocalizedString(@"Logout succeed", nil)];
            [MNet setUserState:nil];
        });
    });
}

@end
