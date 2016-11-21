//
//  MCMainTabBarController.m
//  MeishiChina
//
//  Created by Zheng on 06/11/2016.
//  Copyright © 2016 Zheng. All rights reserved.
//

#import "MCMainTabBarController.h"
#import "MCFirstNavigationController.h"
#import "MCLastNavigationController.h"
#import "MCMiddleNavigationController.h"

@interface MCMainTabBarController ()

@end

@implementation MCMainTabBarController

- (instancetype)init
{
    if (self = [super init])
    {
        MCFirstNavigationController *firstController = [[MCFirstNavigationController alloc] init];
        MCLastNavigationController *lastController = [[MCLastNavigationController alloc] init];
        MCMiddleNavigationController *middleController = [[MCMiddleNavigationController alloc] init];
        self.viewControllers = @[firstController, middleController, lastController];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.tabBar setTranslucent:NO];
}

@end
