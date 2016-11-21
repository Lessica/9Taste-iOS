//
// Created by Zheng on 17/11/2016.
// Copyright (c) 2016 Zheng. All rights reserved.
//

#import "MCTabBarController.h"

@implementation MCTabBarController

- (instancetype)init
{
    if (self = [super init])
    {
        [self setup];
    }
    return self;
}

- (void)setup {

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tabBar setTranslucent:NO];
}

@end
