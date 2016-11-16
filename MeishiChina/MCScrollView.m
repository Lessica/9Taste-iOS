//
// Created by Zheng on 16/11/2016.
// Copyright (c) 2016 Zheng. All rights reserved.
//

#import "MCScrollView.h"

@implementation MCScrollView

- (instancetype)init {
    if (self = [super init]) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup {

}

@end