//
//  MCFirstNavigationController.m
//  MeishiChina
//
//  Created by Zheng on 06/11/2016.
//  Copyright © 2016 Zheng. All rights reserved.
//

#import "MCFirstNavigationController.h"
#import "MCRecommendTableViewController.h"

@interface MCFirstNavigationController ()

@end

@implementation MCFirstNavigationController

- (instancetype)init
{
    MCRecommendTableViewController *recommendController = [[MCRecommendTableViewController alloc] initWithStyle:UITableViewStylePlain];
    if (self = [super initWithRootViewController:recommendController])
    {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tabBarItem.title = NSLocalizedString(@"Recommend", nil);
    self.tabBarItem.image = [UIImage imageNamed:@"thumb-up"];
}

@end
