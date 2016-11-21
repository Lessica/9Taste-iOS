//
// Created by Zheng on 15/11/2016.
// Copyright (c) 2016 Zheng. All rights reserved.
//

#import "MCViewController.h"
#import "MCNavigationController.h"
#import "MCWhiteNavigationController.h"
#import "MCBarButtonItem.h"

@interface MCViewController ()

@property (nonatomic, strong) MCBarButtonItem *closeButtonItem;

@end

@implementation MCViewController

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

- (void)setup {

}

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self.navigationController isKindOfClass:[MCNavigationController class]])
    {
        _isNavigationBarTransparent = NO;
    } else if ([self.navigationController isKindOfClass:[MCWhiteNavigationController class]])
    {
        _isNavigationBarTransparent = YES;
    }
    
    if (nil == self.navigationItem.leftBarButtonItem && nil == self.tabBarController)
    {
        [self.navigationItem setLeftBarButtonItem:self.closeButtonItem];
    }
}

- (MCBarButtonItem *)closeButtonItem {
    if (!_closeButtonItem)
    {
        NSString *closeButtonTitle = nil;
        if (self == self.navigationController.viewControllers[0])
        {
            closeButtonTitle = NSLocalizedString(@"Close", nil);
        } else {
            closeButtonTitle = NSLocalizedString(@"Back", nil);
        }
        MCBarButtonItem *closeButtonItem = [[MCBarButtonItem alloc] initWithTitle:closeButtonTitle
                                                                            style:UIBarButtonItemStylePlain
                                                                           target:self action:@selector(closeButtonItemTapped:)];
        if (self.isNavigationBarTransparent)
        {
            [closeButtonItem setReversedStyle:YES];
        }
        _closeButtonItem = closeButtonItem;
    }
    return _closeButtonItem;
}

- (void)closeButtonItemTapped:(UIBarButtonItem *)sender {
    [self viewControllerWillDismiss];
    if (self == self.navigationController.viewControllers[0]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - Dismiss

- (void)viewControllerWillDismiss {

}

#pragma mark - Memory

- (void)dealloc {
    NSLog(@"! %@", [self description]);
}

@end
