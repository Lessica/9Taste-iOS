//
//  MCRateStarView.m
//  RateFiveStarView
//
//  Created by wentian on 16/11/9.
//  Copyright © 2016年 wentian. All rights reserved.
//

#import "MCRateStarView.h"
#import "MCImageView.h"

@interface MCRateStarView ()
@property (nonatomic, strong) NSMutableArray <MCImageView *> *starViews;

@end

@implementation MCRateStarView

- (void)setup {
    CGFloat padding = 8.f;
    UIImage *grayStarImage = [UIImage imageNamed:@"comment_score_unselected"];
    UIImage *starImage = [UIImage imageNamed:@"comment_score_selected"];
    NSMutableArray *starViews = [[NSMutableArray alloc] init];
    for (int i = 0; i < 5; i++) {
        MCImageView *grayStarView = [[MCImageView alloc] initWithFrame:CGRectMake((grayStarImage.size.width + padding) * i, 0, grayStarImage.size.width, grayStarImage.size.height)];
        grayStarView.image = grayStarImage;
        [self addSubview:grayStarView];

        MCImageView *starView = [[MCImageView alloc] initWithFrame:CGRectMake((grayStarImage.size.width + padding) * i, 0, grayStarImage.size.width, grayStarImage.size.height)];
        starView.image = starImage;
        [starViews addObject:starView];
        [self addSubview:starView];
    }
    self.starViews = starViews;
    self.bounds = CGRectMake(0, 0, grayStarImage.size.width * 5 + padding * 4, grayStarImage.size.height);
}

- (void)setScore:(NSUInteger)score {
    if (self.hasRated)
        return;
    _score = score;
    NSUInteger sc = (NSUInteger)score;
    
    for (NSUInteger i = 0; i < 5; i++) {
        MCImageView *starView = self.starViews[i];
        [starView setHidden:(i > sc)];
    }

    if (_delegate && [_delegate respondsToSelector:@selector(rateViewDidTapped:)]) {
        [_delegate rateViewDidTapped:self];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
    for (NSUInteger i = 0; i < 5; i++) {
        MCImageView *starView = self.starViews[i];
        if (CGRectContainsPoint(starView.frame, point)) {
            [self setScore:i];
            break;
        }
    }
}

@end
