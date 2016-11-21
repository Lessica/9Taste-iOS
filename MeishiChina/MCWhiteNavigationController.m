//
// Created by Zheng on 15/11/2016.
// Copyright (c) 2016 Zheng. All rights reserved.
//

#import "MCWhiteNavigationController.h"


@implementation MCWhiteNavigationController

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return self.topViewController.preferredStatusBarStyle;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.navigationBar setTranslucent:NO];
    [self.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationBar setTitleTextAttributes:@{
            NSForegroundColorAttributeName: MConfig.appearance.tintColor,
            NSFontAttributeName: MConfig.appearance.navigationTitleFont,
    }];
}

@end
