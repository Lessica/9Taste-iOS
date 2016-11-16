//
//  MCSettingsTableViewController.m
//  MeishiChina
//
//  Created by Zheng on 09/11/2016.
//  Copyright © 2016 Zheng. All rights reserved.
//

#import "MCSettingsTableViewController.h"
#import "MCAboutTableViewCell.h"
#import "MCCommonTableViewCell.h"
#import <FLEX/FLEX.h>

static const NSInteger MCAboutTableViewSectionNum = 3;
typedef enum : NSUInteger {
    MCAboutTableViewSectionLogo = 0,
    MCAboutTableViewSectionGeneral,
    MCAboutTableViewSectionFeedback
} MCAboutTableViewSection;

static const NSInteger MCAboutTableViewSectionLogoRowNum = 1;
typedef enum : NSUInteger {
    MCAboutTableViewSectionLogoRowHead = 0
} MCAboutTableViewSectionLogoRow;
static NSString * const MCAboutTableViewSectionLogoRowCellIdentifier = @"MCAboutTableViewSectionLogoRowCellIdentifier";

static const NSInteger MCAboutTableViewSectionGeneralRowNum = 3;
typedef enum : NSUInteger {
    MCAboutTableViewSectionGeneralRowGeneral = 0,
    MCAboutTableViewSectionGeneralRowNotification,
    MCAboutTableViewSectionGeneralRowAppearance
} MCAboutTableViewSectionGeneralRow;

static const NSInteger MCAboutTableViewSectionFeedbackRowNum = 4;
typedef enum : NSUInteger {
    MCAboutTableViewSectionFeedbackRowAgreement = 0,
    MCAboutTableViewSectionFeedbackRowHomepage,
    MCAboutTableViewSectionFeedbackRowCredits,
    MCAboutTableViewSectionFeedbackRowEmail
} MCAboutTableViewSectionFeedbackRow;
static NSString * const MCAboutTableViewSectionCommonRowCellIdentifier = @"MCAboutTableViewSectionCommonRowCellIdentifier";

@interface MCSettingsTableViewController ()
@property (nonatomic, strong) UIBarButtonItem *debugButton; // Lazy

@end

@implementation MCSettingsTableViewController

- (void)setup {
    [super setup];
    self.hidesBottomBarWhenPushed = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"Settings", nil);
#ifdef DEBUG
    self.navigationItem.rightBarButtonItem = self.debugButton;
#endif //DEBUG
}

#pragma mark - Bar Button Item

- (UIBarButtonItem *)debugButton {
    if (!_debugButton) {
        UIBarButtonItem *debugButton =
                [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                              target:self action:@selector(barButtonTapped:)];
        _debugButton = debugButton;
    }
    return _debugButton;
}

#pragma mark - Selector Actions

- (void)barButtonTapped:(UIBarButtonItem *)sender
{
    if (sender == self.debugButton)
    {
        [[FLEXManager sharedManager] showExplorer];
    }
}

#pragma mark - Table View Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return MCAboutTableViewSectionNum;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case MCAboutTableViewSectionLogo:
            return MCAboutTableViewSectionLogoRowNum;
        case MCAboutTableViewSectionGeneral:
            return MCAboutTableViewSectionGeneralRowNum;
        case MCAboutTableViewSectionFeedback:
            return MCAboutTableViewSectionFeedbackRowNum;
        default:
            break;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case MCAboutTableViewSectionLogo:
            return 220;
        case MCAboutTableViewSectionGeneral:
        case MCAboutTableViewSectionFeedback:
            return 48;
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == MCAboutTableViewSectionLogo)
    {
        if (indexPath.row == MCAboutTableViewSectionLogoRowHead)
        {
            MCAboutTableViewCell *cell =
                    [tableView dequeueReusableCellWithIdentifier:MCAboutTableViewSectionLogoRowCellIdentifier];
            if (nil == cell)
            {
                cell = [[MCAboutTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                   reuseIdentifier:MCAboutTableViewSectionLogoRowCellIdentifier];
            }
            return cell;
        }
    }
    else
    {
        MCCommonTableViewCell *cell =
                [tableView dequeueReusableCellWithIdentifier:MCAboutTableViewSectionCommonRowCellIdentifier];
        if (nil == cell)
        {
            cell = [[MCCommonTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                reuseIdentifier:MCAboutTableViewSectionCommonRowCellIdentifier];
        }
        if (indexPath.section == MCAboutTableViewSectionGeneral)
        {
            if (indexPath.row == MCAboutTableViewSectionGeneralRowGeneral)
            {
                cell.textLabel.text = NSLocalizedString(@"General", nil);
            }
            else if (indexPath.row == MCAboutTableViewSectionGeneralRowAppearance)
            {
                cell.textLabel.text = NSLocalizedString(@"Appearance", nil);
            }
            else if (indexPath.row == MCAboutTableViewSectionGeneralRowNotification)
            {
                cell.textLabel.text = NSLocalizedString(@"Notification", nil);
            }
        }
        else if (indexPath.section == MCAboutTableViewSectionFeedback)
        {
            if (indexPath.row == MCAboutTableViewSectionFeedbackRowHomepage)
            {
                cell.textLabel.text = NSLocalizedString(@"Homepage", nil);
            }
            else if (indexPath.row == MCAboutTableViewSectionFeedbackRowAgreement)
            {
                cell.textLabel.text = NSLocalizedString(@"Agreement", nil);
            }
            else if (indexPath.row == MCAboutTableViewSectionFeedbackRowCredits)
            {
                cell.textLabel.text = NSLocalizedString(@"Credits", nil);
            }
            else if (indexPath.row == MCAboutTableViewSectionFeedbackRowEmail)
            {
                cell.textLabel.text = NSLocalizedString(@"Email", nil);
            }
        }
        return cell;
    }
    return [[MCCommonTableViewCell alloc] init];
}

#pragma mark - Table View Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

@end
