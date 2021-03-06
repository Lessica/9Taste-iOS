//
//  MCLastNavigationController.m
//  MeishiChina
//
//  Created by Zheng on 06/11/2016.
//  Copyright © 2016 Zheng. All rights reserved.
//

#import "MCLastNavigationController.h"
#import "MCUserTableViewController.h"

@interface MCLastNavigationController ()

@end

@implementation MCLastNavigationController

- (instancetype)init
{
    MCUserTableViewController *userController = [[MCUserTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    if (self = [super initWithRootViewController:userController])
    {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tabBarItem.title = NSLocalizedString(@"Me", nil);
    self.tabBarItem.image = [UIImage imageNamed:@"person"];
    
#ifdef DEBUG
    [self.tabBarItem setBadgeValue:@"12"];
    if (IOS_VERSION_10) {
        [self.tabBarItem setBadgeColor:MConfig.appearance.badgeColor];
        [self.tabBarItem setBadgeTextAttributes:
         @{
           NSFontAttributeName: MConfig.appearance.badgeTextFont,
           NSForegroundColorAttributeName: MConfig.appearance.badgeTextColor,
           } forState:UIControlStateNormal];
    }
#endif
}

@end
