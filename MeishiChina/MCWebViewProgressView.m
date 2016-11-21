//
// Created by Zheng on 21/11/2016.
// Copyright (c) 2016 Zheng. All rights reserved.
//

#import "MCWebViewProgressView.h"

@implementation MCWebViewProgressView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configureViews];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self configureViews];
}

- (void)configureViews
{
    self.userInteractionEnabled = NO;
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _progressBarView = [[UIView alloc] initWithFrame:self.bounds];
    _progressBarView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self addSubview:_progressBarView];

    _barAnimationDuration = 0.27f;
    _fadeAnimationDuration = 0.27f;
    _fadeOutDelay = 0.1f;
    _progressTintColor = [UIColor colorWithRed:22.f / 255.f green:126.f / 255.f blue:251.f / 255.f alpha:1.0];
}

- (void)setProgressTintColor:(UIColor *)progressTintColor {
    _progressBarView.backgroundColor = progressTintColor;
}

-(void)setProgress:(float)progress
{
    [self setProgress:progress animated:NO];
}

- (void)setProgress:(float)progress animated:(BOOL)animated
{
    BOOL isGrowing = progress > 0.0;
    [UIView animateWithDuration:(isGrowing && animated) ? _barAnimationDuration : 0.0 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        CGRect frame = _progressBarView.frame;
        frame.size.width = progress * self.bounds.size.width;
        _progressBarView.frame = frame;
    } completion:nil];

    if (progress >= 1.0) {
        [UIView animateWithDuration:animated ? _fadeAnimationDuration : 0.0 delay:_fadeOutDelay options:UIViewAnimationOptionCurveEaseInOut animations:^{
            _progressBarView.alpha = 0.0;
        } completion:^(BOOL completed){
            CGRect frame = _progressBarView.frame;
            frame.size.width = 0;
            _progressBarView.frame = frame;
        }];
    }
    else {
        [UIView animateWithDuration:animated ? _fadeAnimationDuration : 0.0 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            _progressBarView.alpha = 1.0;
        } completion:nil];
    }
}

@end