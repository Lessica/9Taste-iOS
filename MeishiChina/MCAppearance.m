//
//  MCAppearance.m
//  MeishiChina
//
//  Created by Zheng on 06/11/2016.
//  Copyright © 2016 Zheng. All rights reserved.
//

#import "MCAppearance.h"

static CGFloat const MCAppearanceFontSizeTitle = 20.f;
static CGFloat const MCAppearanceFontSizeExtraLarge = 18.f;
static CGFloat const MCAppearanceFontSizeLarge = 16.f;
static CGFloat const MCAppearanceFontSizeNormal = 14.f;
static CGFloat const MCAppearanceFontSizeSmall = 12.f;
static CGFloat const MCAppearanceFontSizeExtraSmall = 10.f;

@implementation MCAppearance

- (instancetype)init {
    if (self = [super init]) {
        [self setup];
    }
    return self;
}

#pragma mark - Fonts

+ (UIFont *)regularFontWithSize:(CGFloat)fontSize {
    return [UIFont fontWithName:@"Avenir" size:fontSize];
}

+ (UIFont *)italicFontWithSize:(CGFloat)fontSize {
    return [UIFont fontWithName:@"Avenir-Oblique" size:fontSize];
}

+ (UIFont *)boldFontWithSize:(CGFloat)fontSize {
    return [UIFont fontWithName:@"Avenir-Heavy" size:fontSize];
}

#pragma mark - Setup

- (void)setup
{
    [self setupColors];
    [self setupFonts];
}

- (void)setupColors
{
    _tintColor = _emailColor = _appNameColor = _buttonTintColor = _toastActivityColor =
            _toastMessageColor =
            [UIColor colorWithRGB:0xe74c3c];
    _foregroundColor = _maskLabelTextColor = _badgeTextColor =
            _navigationItemColor = _buttonTitleColor =
                    [UIColor whiteColor];
    _labelTextColor = _nickNameColor = _tagsDeleteButtonColor =
            [UIColor blackColor];
    _surveyBorderColor = [UIColor colorWithWhite:0.f alpha:0.1f];
    _toastColor = [UIColor colorWithWhite:1.f alpha:.95f];
    _pageControlCurrentTintColor = [UIColor colorWithWhite:1.f alpha:9.f];
    _pageControlTintColor = [UIColor colorWithWhite:1.f alpha:.5f];
    _textFieldPlaceHolderColor = [UIColor colorWithWhite:0.7f alpha:1.f];
    _badgeColor = [_tintColor colorWithAlphaComponent:.9f];
    _appDescriptionColor = [UIColor grayColor];
    _textFieldColor = _recipeDescriptionColor = [UIColor darkTextColor];
    _surveyWarningColor = _headerStateColor =
            [UIColor lightGrayColor];
    _tagsBackgroundColor = [UIColor colorWithRed:0.9 green:0.91 blue:0.925 alpha:1.f];
    _tagsTextColor = [UIColor darkGrayColor];
    _progressViewTintColor = [UIColor colorWithRGB:0xf1c40f];
}

- (void)setupFonts {
    _nickNameFont = _appNameFont = _navigationTitleFont =
            [[self class] regularFontWithSize:MCAppearanceFontSizeTitle];
    _surveyTitleFont = [[self class] boldFontWithSize:MCAppearanceFontSizeTitle];
    _toastMessageFont = _emailFont = _maskLabelTextFont = _surveyTagFont =
            _surveySectionHeaderFont = _recipeDescriptionFont =
            [[self class] italicFontWithSize:MCAppearanceFontSizeNormal];
    _appDescriptionFont = _tabbarTitleFont = _badgeTextFont =
            _headerStateFont =
            [[self class] regularFontWithSize:MCAppearanceFontSizeSmall];
    _buttonTitleFont = _textFieldFont = _textFieldPlaceHolderFont = _labelTextFont =
            _navigationItemFont =
            [[self class] regularFontWithSize:MCAppearanceFontSizeLarge];
    _surveyWarningFont = [[self class] regularFontWithSize:MCAppearanceFontSizeExtraLarge];
}

@end
