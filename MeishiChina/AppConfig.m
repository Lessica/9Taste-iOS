//
//  AppConfig.m
//  MeishiChina
//
//  Created by Zheng on 06/11/2016.
//  Copyright © 2016 Zheng. All rights reserved.
//

#import "AppConfig.h"
#import <UIKit/UIKit.h>

static NSString * const MCKeyStorageDatabase = @"MCKeyStorageDatabase";

NSString * const MConfigStorageApiUrl = @"http://115.28.214.126:8080/meishi";

NSString * const MConfigStorageAppearanceKey = @"MConfigAppearanceKey";
NSString * const MConfigStorageUserStateKey = @"MConfigStorageUserStateKey";

@implementation AppConfig
{
    MCAppearance *_appearance;
    YYCache *_storage;
    MCNetwork *_networkService;
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
        [self setupStorage];
        [self setupAppearance];
        [self setupNetwork];
    }
    return self;
}

#pragma mark - Shared Getters

- (YYCache *)storage
{
    if (!_storage) {
        _storage = [[YYCache alloc] initWithName:MCKeyStorageDatabase];
    }
    return _storage;
}

- (MCAppearance *)appearance
{
    if (!_appearance)
    {
        NSString *appearanceClassName = (NSString *)[self.storage objectForKey:MConfigStorageAppearanceKey];
        MCLog(@"Load Appearance: %@", appearanceClassName);
        _appearance = (MCAppearance *)[[NSClassFromString(appearanceClassName) alloc] init];
    }
    return _appearance;
}

- (MCNetwork *)networkService {
    if (!_networkService)
    {
        NSString *apiURL = MConfigStorageApiUrl;
        MCLog(@"Load API: %@", apiURL);
        MCNetwork *networkService = [[MCNetwork alloc] initWithURL:[NSURL URLWithString:apiURL]];
        _networkService = networkService;
    }
    return _networkService;
}

#pragma mark - Setups

- (void)setupStorage
{
    YYCache *storage = [self storage];
    NSDictionary *defaultConfig = @{
        MConfigStorageAppearanceKey: @"MCAppearanceDefault",
    };
    // Process Default Config
    for (NSString *configKey in defaultConfig.allKeys) {
        BOOL containsKey = [storage containsObjectForKey:configKey];
        if (!containsKey)
        {
            [storage setObject:defaultConfig[configKey] forKey:configKey];
        }
    }
}

- (void)setupAppearance
{
    MCAppearance *appearance = [self appearance];

    // Toast
    [CSToastManager setTapToDismissEnabled:YES];
    [CSToastManager setDefaultDuration:3.f];
    [CSToastManager setQueueEnabled:NO];
    [CSToastManager setDefaultPosition:CSToastPositionCenter];
    
    [CSToastManager sharedStyle].backgroundColor = appearance.toastColor;
    [CSToastManager sharedStyle].messageColor = appearance.toastMessageColor;
    [CSToastManager sharedStyle].messageFont = appearance.toastMessageFont;
    [CSToastManager sharedStyle].activitySize = CGSizeMake(80.f, 80.f);

    [UIActivityIndicatorView appearance].color = appearance.toastActivityColor;
    
    // Navigation Bar
    [UINavigationBar appearance].barTintColor = appearance.tintColor;
    [UINavigationBar appearance].tintColor = appearance.foregroundColor;
    [UINavigationBar appearance].titleTextAttributes =
  @{
    NSForegroundColorAttributeName: appearance.foregroundColor,
    NSFontAttributeName: appearance.navigationTitleFont,
    };
    [[UIBarButtonItem appearance] setTitleTextAttributes:
     @{
       NSFontAttributeName: appearance.navigationItemFont,
       } forState:UIControlStateNormal];
    [UIBarButtonItem appearance].tintColor = appearance.navigationItemColor;
    
    // Tab Bar
    [[UITabBarItem appearance] setTitleTextAttributes:
  @{
    NSFontAttributeName: appearance.tabbarTitleFont,
    } forState:UIControlStateNormal];
    [UITabBar appearance].tintColor = appearance.tintColor;
    
    // Page Control
    [[UIPageControl appearance] setPageIndicatorTintColor:appearance.pageControlTintColor];
    [[UIPageControl appearance] setCurrentPageIndicatorTintColor:appearance.pageControlCurrentTintColor];
}

- (void)setupNetwork
{
    [self networkService];

}

@end
