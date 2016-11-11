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
#import "MCSettingsViewController.h"

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

@interface MCUserTableViewController () <UITableViewDelegate, UITableViewDataSource, MCCellAvatarDelegate>
@property (nonatomic, strong) UIBarButtonItem *settingsButton; // Lazy

@end

@implementation MCUserTableViewController

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (instancetype)init
{
    if (self = [super init])
    {
        [self setup];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
    if (self = [super initWithStyle:style]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"Me", nil);
    self.navigationItem.rightBarButtonItem = self.settingsButton;
}

#pragma mark - Bar Button Item

- (UIBarButtonItem *)settingsButton
{
    if (!_settingsButton)
    {
        UIBarButtonItem *settingsButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"gear"] style:UIBarButtonItemStylePlain target:self action:@selector(barButtonTapped:)];
        _settingsButton = settingsButton;
    }
    return _settingsButton;
}

#pragma mark - Selector Actions

- (void)barButtonTapped:(UIBarButtonItem *)sender
{
    if (sender == self.settingsButton)
    {
        MCSettingsViewController *settingsController = [[MCSettingsViewController alloc] initWithStyle:UITableViewStyleGrouped];
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
                cell = [[MCAvatarTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MCUserTableViewSectionLoginRowCellIdentifier];
                cell.avatarDelegate = self;
            }
            return cell;
        }
    }
    else
    {
        MCCommonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MCUserTableViewSectionCommonRowCellIdentifier];
        if (nil == cell)
        {
            cell = [[MCCommonTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MCUserTableViewSectionCommonRowCellIdentifier];
        }
        if (indexPath.section == MCUserTableViewSectionCard)
        {
            if (indexPath.row == MCUserTableViewSectionCardRowHead)
            {
                cell.textLabel.text = NSLocalizedString(@"Survey Cards", nil);
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
    } else {
        if (indexPath.section == MCUserTableViewSectionCard) {
            if (indexPath.row == MCUserTableViewSectionCardRowHead) {
#warning "Debug Badge 12"
#ifdef DEBUG
                UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                [(MCCommonTableViewCell *)cell setDisplayValue:0];
                [self.navigationController.tabBarItem setBadgeValue:nil];
#endif
            }
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
    [self.navigationController.view makeToast:NSLocalizedString(@"Not implemented", nil)];
}

@end
