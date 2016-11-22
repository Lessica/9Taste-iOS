//
//  MCRecipeCell.m
//  MeishiChina
//
//  Created by Zheng on 17/11/2016.
//  Copyright © 2016 Zheng. All rights reserved.
//

#import "MCRecipeCell.h"

static CGFloat const kMCSurveyTitleLeftMargin = 24.f;
static CGFloat const kMCSurveyTitleRightMargin = 24.f;

@implementation MCRecipeCell

- (void)setup {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self addSubview:self.backgroundImageView];
    [self addSubview:self.imageTitleLabel];
}

#pragma mark - UIView Getters

- (YYAnimatedImageView *)backgroundImageView {
    if (!_backgroundImageView) {
        YYAnimatedImageView *backgroundImageView = [[YYAnimatedImageView alloc] initWithFrame:self.bounds];
        backgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
        backgroundImageView.layer.masksToBounds = YES;
        _backgroundImageView = backgroundImageView;
    }
    return _backgroundImageView;
}

- (MCLabel *)imageTitleLabel {
    if (!_imageTitleLabel) {
        MCLabel *imageTitleLabel =
        [[MCLabel alloc] initWithFrame:CGRectMake(0, 0, self.width - kMCSurveyTitleLeftMargin - kMCSurveyTitleRightMargin, 0)];
        imageTitleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        imageTitleLabel.font = MConfig.appearance.surveyTitleFont;
        imageTitleLabel.textAlignment = NSTextAlignmentCenter;
        imageTitleLabel.textColor = [UIColor whiteColor];
        imageTitleLabel.layer.shadowColor = [UIColor blackColor].CGColor;
        imageTitleLabel.layer.shadowOffset = CGSizeMake(4.f, 4.f);
        imageTitleLabel.layer.shadowOpacity = .6f;
        imageTitleLabel.numberOfLines = 0;
        _imageTitleLabel = imageTitleLabel;
    }
    return _imageTitleLabel;
}

- (void)resizeImageTitle {
    CGSize toSize = [self.imageTitleLabel.text boundingRectWithSize:CGSizeMake(self.width, MAXFLOAT)
                                                            options:NSStringDrawingUsesLineFragmentOrigin
                                                         attributes:@{
                                                                      NSFontAttributeName : self.imageTitleLabel.font
                                                                      } context:nil].size;
    self.imageTitleLabel.size = toSize;
    self.imageTitleLabel.center = self.backgroundImageView.center;
}

@end
