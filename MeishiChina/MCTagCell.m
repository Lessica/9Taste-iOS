//
// Created by Zheng on 21/11/2016.
// Copyright (c) 2016 Zheng. All rights reserved.
//

#import "MCTagCell.h"

@interface MCTagCell ()

@end

@implementation MCTagCell

- (void)setup {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self addSubview:self.tagsControl];
}

- (MCTagsControl *)tagsControl {
    if (!_tagsControl) {
        MCTagsControl *tagsControl = [[MCTagsControl alloc] initWithFrame:self.bounds];
        tagsControl.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        tagsControl.mode = MCTagsControlModeList;
        tagsControl.tagsBackgroundColor = MConfig.appearance.tagsBackgroundColor;
        tagsControl.tagsTextColor = MConfig.appearance.tagsTextColor;
        tagsControl.tagsDeleteButtonColor = MConfig.appearance.tagsDeleteButtonColor;
        tagsControl.contentInset = UIEdgeInsetsMake(12.f, 16.f, 12.f, 16.f);
        tagsControl.showsVerticalScrollIndicator = NO;
        tagsControl.showsHorizontalScrollIndicator = NO;
        tagsControl.bounces = YES;
        tagsControl.alwaysBounceHorizontal = YES;
        _tagsControl = tagsControl;
    }
    return _tagsControl;
}

@end