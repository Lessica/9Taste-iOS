//
//  MCAppearance.h
//  MeishiChina
//
//  Created by Zheng on 06/11/2016.
//  Copyright © 2016 Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCAppearance : NSObject

@property (nonatomic, strong) UIFont *navigationTitleFont;
@property (nonatomic, strong) UIFont *tabbarTitleFont;

@property (nonatomic, strong) UIColor *tintColor;
@property (nonatomic, strong) UIColor *foregroundColor;

@property (nonatomic, strong) UIColor *labelTextColor;
@property (nonatomic, strong) UIFont *labelTextFont;

@property (nonatomic, strong) UIColor *maskLabelTextColor;
@property (nonatomic, strong) UIFont *maskLabelTextFont;

@property (nonatomic, strong) UIColor *badgeColor;
@property (nonatomic, strong) UIColor *badgeTextColor;
@property (nonatomic, strong) UIFont *badgeTextFont;

@property (nonatomic, strong) UIColor *nickNameColor;
@property (nonatomic, strong) UIFont *nickNameFont;

@property (nonatomic, strong) UIColor *emailColor;
@property (nonatomic, strong) UIFont *emailFont;

@property (nonatomic, strong) UIColor *toastColor;
@property (nonatomic, strong) UIColor *toastMessageColor;
@property (nonatomic, strong) UIFont *toastMessageFont;

@end
