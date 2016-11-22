//
//  MCRateStarView.h
//  RateFiveStarView
//
//  Created by wentian on 16/11/9.
//  Copyright © 2016年 wentian. All rights reserved.
//

#import "MCScrollView.h"

@class MCRateStarView;

@protocol MCRateViewDelegate <NSObject>
- (void)rateViewDidTapped:(MCRateStarView *)view;

@end

@interface MCRateStarView : MCScrollView
@property (nonatomic, assign) NSInteger score;
@property (nonatomic, weak) id <MCRateViewDelegate> rateDelegate;
@property (nonatomic, assign) BOOL hasRated;

@end
