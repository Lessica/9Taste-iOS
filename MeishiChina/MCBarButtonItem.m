//
//  MCBarButtonItem.m
//  MeishiChina
//
//  Created by Zheng on 16/11/2016.
//  Copyright © 2016 Zheng. All rights reserved.
//

#import "MCBarButtonItem.h"

@implementation MCBarButtonItem

- (instancetype)init {
    if (self = [super init]) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title style:(UIBarButtonItemStyle)style target:(id)target action:(SEL)action {
    if (self = [super initWithTitle:title style:style target:target action:action]) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCustomView:(UIView *)customView {
    if (self = [super initWithCustomView:customView]) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithImage:(UIImage *)image style:(UIBarButtonItemStyle)style target:(id)target action:(SEL)action {
    if (self = [super initWithImage:image style:style target:target action:action]) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithBarButtonSystemItem:(UIBarButtonSystemItem)systemItem target:(id)target action:(SEL)action {
    if (self = [super initWithBarButtonSystemItem:systemItem target:target action:action]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    
}

#pragma mark - Reverse Style

- (void)setReversedStyle:(BOOL)reversedStyle {
    if (reversedStyle) {
        [self setTitleTextAttributes:@{ NSFontAttributeName: MConfig.appearance.navigationItemFont }
                            forState:UIControlStateNormal];
        [self setTintColor:MConfig.appearance.tintColor];
    } else {
        [self setTitleTextAttributes:@{ NSFontAttributeName: MConfig.appearance.navigationItemFont }
                            forState:UIControlStateNormal];
        [self setTintColor:MConfig.appearance.navigationItemColor];
    }
}

@end
