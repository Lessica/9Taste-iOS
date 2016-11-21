//
//  MCMiddleNavigationController.m
//  MeishiChina
//
//  Created by Zheng on 17/11/2016.
//  Copyright © 2016 Zheng. All rights reserved.
//

#import "MCMiddleNavigationController.h"
#import "MCSurveyViewController.h"

@interface MCMiddleNavigationController ()

@end

@implementation MCMiddleNavigationController

- (instancetype)init
{
    MCSurveyViewController *userController = [[MCSurveyViewController alloc] init];
    if (self = [super initWithRootViewController:userController])
    {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBarItem.title = NSLocalizedString(@"Survey", nil);
    self.tabBarItem.image = [UIImage imageNamed:@"tag"];
}



@end
