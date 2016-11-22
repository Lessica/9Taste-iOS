//
// Created by Zheng on 21/11/2016.
// Copyright (c) 2016 Zheng. All rights reserved.
//

#import "MCRateCell.h"

@implementation MCRateCell

- (void)setup {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self addSubview:self.rateStarView];
}

- (MCRateStarView *)rateStarView {
    if (!_rateStarView) {
        MCRateStarView *rateStarView = [[MCRateStarView alloc] initWithFrame:self.bounds];
        rateStarView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _rateStarView = rateStarView;
    }
    return _rateStarView;
}

@end
