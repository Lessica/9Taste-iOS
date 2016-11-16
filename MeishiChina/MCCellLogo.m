//
// Created by Zheng on 15/11/2016.
// Copyright (c) 2016 Zheng. All rights reserved.
//

#import "MCCellLogo.h"

@implementation MCCellLogo

- (void)setup {
    [super setup];

    self.userInteractionEnabled = NO;
    self.bounds = CGRectMake(0, 0, 60, 60);
    self.image = [UIImage imageNamed:@"AppLogo"];
    [self.layer setCornerRadius:12];
    [self.layer setMasksToBounds:YES];
}

@end