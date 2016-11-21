//
//  MCRateStarView.h
//  RateFiveStarView
//
//  Created by wentian on 16/11/9.
//  Copyright © 2016年 wentian. All rights reserved.
//

#import "MCView.h"

@class MCRateStarView;

@protocol MCRateViewDelegate <NSObject>
- (void)rateViewDidTapped:(MCRateStarView *)view;

@end

@interface MCRateStarView : MCView
@property (nonatomic, assign) NSUInteger score;
@property (nonatomic, weak) id <MCRateViewDelegate> delegate;
@property (nonatomic, assign) BOOL hasRated;

@end
