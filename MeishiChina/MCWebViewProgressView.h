//
// Created by Zheng on 21/11/2016.
// Copyright (c) 2016 Zheng. All rights reserved.
//

#import "MCView.h"

@interface MCWebViewProgressView : MCView
@property (nonatomic) float progress;

@property (nonatomic) UIView *progressBarView;
@property (nonatomic) NSTimeInterval barAnimationDuration; // default 0.1
@property (nonatomic) NSTimeInterval fadeAnimationDuration; // default 0.27
@property (nonatomic) NSTimeInterval fadeOutDelay; // default 0.1
@property (nonatomic, strong) UIColor *progressTintColor;

- (void)setProgress:(float)progress animated:(BOOL)animated;

@end