//
//  MCCommonTableViewCell.m
//  MeishiChina
//
//  Created by Zheng on 08/11/2016.
//  Copyright © 2016 Zheng. All rights reserved.
//

#import "MCCommonTableViewCell.h"
#import "MCCellBadge.h"

static CGFloat const MCCommonTableViewCellBadgeRightMargin = 48.f;
static CGFloat const MCCommonTableViewCellBadgeWidth = 28.f;
static CGFloat const MCCommonTableViewCellBadgeHeight = 20.f;

@interface MCCommonTableViewCell()
@property (nonatomic, strong) MCCellBadge *badgeView;

@end

@implementation MCCommonTableViewCell

- (void)setup {
    [super setup];

    self.separatorInset = UIEdgeInsetsZero;
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    [self.textLabel setTextColor:MConfig.appearance.labelTextColor];
    [self.textLabel setFont:MConfig.appearance.labelTextFont];
    
    [self addSubview:self.badgeView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.badgeView.center = CGPointMake(self.width - MCCommonTableViewCellBadgeRightMargin - self.badgeView.width / 2, self.height / 2);
}

#pragma mark - UIView Getters

- (MCCellBadge *)badgeView {
    if (!_badgeView) {
        MCCellBadge *badgeView = [[MCCellBadge alloc] initWithFrame:CGRectMake(0, 0, MCCommonTableViewCellBadgeWidth, MCCommonTableViewCellBadgeHeight)];
        badgeView.hidden = YES;
        _badgeView = badgeView;
    }
    return _badgeView;
}

#pragma mark - Foundation Getters

- (NSUInteger)displayValue {
    return self.badgeView.displayValue;
}

#pragma mark - Foundation Setters

- (void)setDisplayValue:(NSUInteger)displayValue {
    [self.badgeView setDisplayValue:displayValue];
    self.badgeView.hidden = (displayValue == 0);
}

@end
