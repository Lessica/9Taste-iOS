//
//  MCRateStarView.m
//  RateFiveStarView
//
//  Created by wentian on 16/11/9.
//  Copyright © 2016年 wentian. All rights reserved.
//

#import "MCRateStarView.h"
#import "MCImageView.h"

static NSUInteger const MCRateStarNum = 10;
static CGFloat const MCRateStarTopMargin = 16.f;
static CGFloat const MCRateStarBottomMargin = 16.f;
static CGFloat const MCRateStarLeftMargin = 16.f;
static CGFloat const MCRateStarRightMargin = 16.f;

@interface MCRateStarView ()
@property (nonatomic, strong) NSMutableArray <MCImageView *> *starViews;

@end

@implementation MCRateStarView

- (void)setup {
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    
    CGFloat padding = 8.f;
    UIImage *grayStarImage = [UIImage imageNamed:@"comment_score_unselected"];
    UIImage *starImage = [UIImage imageNamed:@"comment_score_selected"];
    NSMutableArray *starViews = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < MCRateStarNum; i++) {
        MCImageView *grayStarView = [[MCImageView alloc] initWithFrame:CGRectMake((grayStarImage.size.width + padding) * i + MCRateStarLeftMargin, MCRateStarTopMargin, grayStarImage.size.width, grayStarImage.size.height)];
        grayStarView.image = grayStarImage;
        [self addSubview:grayStarView];

        MCImageView *starView = [[MCImageView alloc] initWithFrame:CGRectMake((grayStarImage.size.width + padding) * i + MCRateStarLeftMargin, MCRateStarTopMargin, grayStarImage.size.width, grayStarImage.size.height)];
        starView.image = starImage;
        starView.hidden = YES;
        [starViews addObject:starView];
        [self addSubview:starView];
    }
    self.starViews = starViews;
    self.contentSize = CGSizeMake(grayStarImage.size.width * MCRateStarNum + padding * (MCRateStarNum - 1) + MCRateStarLeftMargin + MCRateStarRightMargin, grayStarImage.size.height + MCRateStarTopMargin + MCRateStarBottomMargin);
}

- (void)setScore:(NSInteger)score {
    if (self.hasRated)
        return;
    _score = score;
    NSInteger sc = (NSInteger)score;
    
    for (NSInteger i = 0; i < MCRateStarNum; i++) {
        MCImageView *starView = self.starViews[i];
        [starView setHidden:(i > sc)];
    }

    if (_rateDelegate && [_rateDelegate respondsToSelector:@selector(rateViewDidTapped:)]) {
        [_rateDelegate rateViewDidTapped:self];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
    for (NSInteger i = 0; i < MCRateStarNum; i++) {
        MCImageView *starView = self.starViews[i];
        if (CGRectContainsPoint(starView.frame, point)) {
            [self setScore:i];
            break;
        }
    }
}

@end
