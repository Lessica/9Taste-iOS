//
// Created by Zheng on 15/11/2016.
// Copyright (c) 2016 Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCViewController : UIViewController
@property (nonatomic, assign, readonly) BOOL isNavigationBarTransparent;

- (void)setup;
- (void)viewControllerWillDismiss;

@end
