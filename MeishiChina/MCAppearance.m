//
//  MCAppearance.m
//  MeishiChina
//
//  Created by Zheng on 06/11/2016.
//  Copyright © 2016 Zheng. All rights reserved.
//

#import "MCAppearance.h"

@implementation MCAppearance

- (instancetype)init {
    if (self = [super init]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    // Colors
    _tintColor = [UIColor colorWithRGB:0xe74c3c];
    _foregroundColor = [UIColor whiteColor];
    _labelTextColor = [UIColor blackColor];
    _maskLabelTextColor = [UIColor whiteColor];
    _badgeColor = [_tintColor colorWithAlphaComponent:.9f];
    _badgeTextColor = [UIColor whiteColor];
    _nickNameColor = [UIColor blackColor];
    _emailColor = _tintColor;
    _toastColor = [UIColor colorWithWhite:0.f alpha:.6f];
    _toastMessageColor = [UIColor whiteColor];
    _navigationItemColor = [UIColor whiteColor];
    
    // Fonts
    _navigationTitleFont = [UIFont fontWithName:@"Avenir-Heavy" size:20.f];
    _tabbarTitleFont = [UIFont fontWithName:@"Avenir" size:10.f];
    _labelTextFont = [UIFont fontWithName:@"Avenir" size:16.f];
    _maskLabelTextFont = [UIFont fontWithName:@"Avenir-Heavy" size:14.f];
    _badgeTextFont = [UIFont fontWithName:@"Avenir-Heavy" size:12.f];
    _nickNameFont = [UIFont fontWithName:@"Avenir" size:24.f];
    _emailFont = [UIFont fontWithName:@"Avenir-Oblique" size:14.f];
    _toastMessageFont = [UIFont fontWithName:@"Avenir" size:14.f];
    _navigationItemFont = [UIFont fontWithName:@"Avenir" size:16.f];
}

@end
