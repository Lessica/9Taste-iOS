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

- (instancetype)init {
    if (self = [super init]) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup {
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

#pragma mark - Getters

- (MCCellBadge *)badgeView {
    if (!_badgeView) {
        MCCellBadge *badgeView = [[MCCellBadge alloc] initWithFrame:CGRectMake(0, 0, MCCommonTableViewCellBadgeWidth, MCCommonTableViewCellBadgeHeight)];
        badgeView.hidden = YES;
        _badgeView = badgeView;
    }
    return _badgeView;
}

#pragma mark - Setters

- (void)setDisplayValue:(NSUInteger)displayValue {
    _displayValue = displayValue;
    [self.badgeView setDisplayValue:displayValue];
    if (displayValue == 0) {
        self.badgeView.hidden = YES;
    } else {
        self.badgeView.hidden = NO;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
