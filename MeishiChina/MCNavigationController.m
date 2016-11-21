//
// Created by Zheng on 15/11/2016.
// Copyright (c) 2016 Zheng. All rights reserved.
//

#import "MCNavigationController.h"

@implementation MCNavigationController

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return self.topViewController.preferredStatusBarStyle;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

@end
