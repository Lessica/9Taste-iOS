//
//  AppConfig.m
//  MeishiChina
//
//  Created by Zheng on 06/11/2016.
//  Copyright © 2016 Zheng. All rights reserved.
//

#import "AppConfig.h"
#import <UIKit/UIKit.h>

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

@implementation AppConfig {
    MCAppearance *_appearance;
}

+ (instancetype)sharedInstance
{
    static AppConfig *sharedInstance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init
{
    if (self = [super init])
    {
        [self setupAppearance];
    }
    return self;
}

- (MCAppearance *)appearance
{
    if (!_appearance)
    {
        _appearance = [[MCAppearance alloc] init];
    }
    return _appearance;
}

- (void)setupAppearance
{
    // Toast
    [CSToastManager setTapToDismissEnabled:YES];
    [CSToastManager setDefaultDuration:3.f];
    [CSToastManager setQueueEnabled:NO];
    [CSToastManager setDefaultPosition:CSToastPositionCenter];
    
    [CSToastManager sharedStyle].backgroundColor = self.appearance.toastColor;
    [CSToastManager sharedStyle].messageColor = self.appearance.toastMessageColor;
    [CSToastManager sharedStyle].messageFont = self.appearance.toastMessageFont;
    [CSToastManager sharedStyle].activitySize = CGSizeMake(80.f, 80.f);
    
    // Navigation Bar
    [UINavigationBar appearance].barTintColor = self.appearance.tintColor;
    [UINavigationBar appearance].tintColor = self.appearance.foregroundColor;
    [UINavigationBar appearance].titleTextAttributes =
  @{
    NSForegroundColorAttributeName: self.appearance.foregroundColor,
    NSFontAttributeName: self.appearance.navigationTitleFont,
    };
    [[UIBarButtonItem appearance] setTitleTextAttributes:
     @{
       NSFontAttributeName: self.appearance.navigationItemFont,
       } forState:UIControlStateNormal];
    [UIBarButtonItem appearance].tintColor = self.appearance.navigationItemColor;
    
    // Tab Bar
    [[UITabBarItem appearance] setTitleTextAttributes:
  @{
    NSFontAttributeName: self.appearance.tabbarTitleFont,
    } forState:UIControlStateNormal];
    [UITabBar appearance].tintColor = self.appearance.tintColor;
    
    // #import "MCCellBadge.h"
    // #import "MCCommonTableViewCell.h"
    // #import "MCCellAvatar.h"
    // #import "MCAvatarTableViewCell.h"
    
}

@end
