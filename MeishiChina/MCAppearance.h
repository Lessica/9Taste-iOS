//
//  MCAppearance.h
//  MeishiChina
//
//  Created by Zheng on 06/11/2016.
//  Copyright © 2016 Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCAppearance : NSObject

#pragma mark - Global

@property (nonatomic, strong) UIColor *tintColor;
@property (nonatomic, strong) UIColor *foregroundColor;

#pragma mark - Navigation

@property (nonatomic, strong) UIFont *navigationTitleFont;
@property (nonatomic, strong) UIColor *navigationItemColor;
@property (nonatomic, strong) UIFont *navigationItemFont;

#pragma mark - Tabbar

@property (nonatomic, strong) UIFont *tabbarTitleFont;

#pragma mark - Table View

@property (nonatomic, strong) UIColor *labelTextColor;
@property (nonatomic, strong) UIFont *labelTextFont;

#pragma mark - Image View

@property (nonatomic, strong) UIColor *maskLabelTextColor;
@property (nonatomic, strong) UIFont *maskLabelTextFont;

#pragma mark - Badge View

@property (nonatomic, strong) UIColor *badgeColor;
@property (nonatomic, strong) UIColor *badgeTextColor;
@property (nonatomic, strong) UIFont *badgeTextFont;

#pragma mark - Toast

@property (nonatomic, strong) UIColor *toastColor;
@property (nonatomic, strong) UIColor *toastActivityColor;
@property (nonatomic, strong) UIColor *toastMessageColor;
@property (nonatomic, strong) UIFont *toastMessageFont;

#pragma mark - User

@property (nonatomic, strong) UIColor *nickNameColor;
@property (nonatomic, strong) UIFont *nickNameFont;

@property (nonatomic, strong) UIColor *emailColor;
@property (nonatomic, strong) UIFont *emailFont;

#pragma mark - About

@property (nonatomic, strong) UIColor *appNameColor;
@property (nonatomic, strong) UIFont *appNameFont;

@property (nonatomic, strong) UIColor *appDescriptionColor;
@property (nonatomic, strong) UIFont *appDescriptionFont;

#pragma mark - Login

@property (nonatomic, strong) UIColor *textFieldPlaceHolderColor;
@property (nonatomic, strong) UIFont *textFieldPlaceHolderFont;

@property (nonatomic, strong) UIColor *textFieldColor;
@property (nonatomic, strong) UIFont *textFieldFont;

@property (nonatomic, strong) UIColor *buttonTintColor;
@property (nonatomic, strong) UIColor *buttonTitleColor;
@property (nonatomic, strong) UIFont *buttonTitleFont;

@end
