//
// Created by Zheng on 16/11/2016.
// Copyright (c) 2016 Zheng. All rights reserved.
//

#import "MCRoundButton.h"

@implementation MCRoundButton

- (void)setup {
    [super setup];

//    self.showsTouchWhenHighlighted = YES;
    [self setBackgroundImage:[UIImage imageWithColor: MConfig.appearance.buttonTintColor]
                    forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageWithColor: [MConfig.appearance.buttonTintColor colorWithAlphaComponent:.6f]]
                    forState:UIControlStateHighlighted];
    [self.layer setCornerRadius:6.f];
    [self.layer setMasksToBounds:YES];
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state {
    NSDictionary *attributes = @{
            NSFontAttributeName: MConfig.appearance.buttonTitleFont,
            NSForegroundColorAttributeName: MConfig.appearance.buttonTitleColor
    };
    NSAttributedString *attributedTitle =
            [[NSAttributedString alloc] initWithString:title attributes:attributes];
    [super setAttributedTitle:attributedTitle forState:state];
}

@end