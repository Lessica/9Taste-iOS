//
// Created by Zheng on 21/11/2016.
// Copyright (c) 2016 Zheng. All rights reserved.
//

#import "MCTextCell.h"

@implementation MCTextCell

- (void)setup {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self addSubview:self.insetsLabel];
}

- (MCInsetsLabel *)insetsLabel {
    if (!_insetsLabel) {
        MCInsetsLabel *insetsLabel = [[MCInsetsLabel alloc] initWithFrame:self.bounds];
        insetsLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        insetsLabel.edgeInsets = UIEdgeInsetsMake(12.f, 16.f, 12.f, 16.f);
        insetsLabel.textColor = MConfig.appearance.recipeDescriptionColor;
        insetsLabel.font = MConfig.appearance.recipeDescriptionFont;
        insetsLabel.numberOfLines = 0;
        insetsLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        insetsLabel.textAlignment = NSTextAlignmentLeft;
        _insetsLabel = insetsLabel;
    }
    return _insetsLabel;
}

@end