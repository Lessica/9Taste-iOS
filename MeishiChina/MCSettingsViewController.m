//
//  MCSettingsViewController.m
//  MeishiChina
//
//  Created by Zheng on 09/11/2016.
//  Copyright © 2016 Zheng. All rights reserved.
//

#import "MCSettingsViewController.h"

@interface MCSettingsViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation MCSettingsViewController

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
    self.hidesBottomBarWhenPushed = YES;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)loadView {
    [super loadView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"Settings", nil);
}

@end
