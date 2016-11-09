//
//  MCCellBadge.m
//  MeishiChina
//
//  Created by Zheng on 08/11/2016.
//  Copyright © 2016 Zheng. All rights reserved.
//

#import "MCCellBadge.h"

@interface MCCellBadge ()
@property (nonatomic, strong) UILabel *valueLabel;

@end

@implementation MCCellBadge

- (instancetype)init {
    if (self = [super init]) {
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
    [self setBackgroundColor:MConfig.appearance.badgeColor];
    [self.layer setCornerRadius:self.height / 2];
    [self.layer setMasksToBounds:YES];
    
    [self.valueLabel setFont:MConfig.appearance.badgeTextFont];
    [self.valueLabel setTextColor:MConfig.appearance.badgeTextColor];
    [self addSubview:self.valueLabel];
}

#pragma mark - Getters

- (UILabel *)valueLabel {
    if (!_valueLabel) {
        UILabel *valueLabel = [[UILabel alloc] init];
        valueLabel.backgroundColor = [UIColor clearColor];
        
        _valueLabel = valueLabel;
    }
    return _valueLabel;
}

#pragma mark - Setters

- (void)setDisplayValue:(NSUInteger)displayValue {
    _displayValue = displayValue;
    [self.valueLabel setText:[NSString stringWithFormat:@"%lu", (unsigned long)displayValue]];
    [self.valueLabel sizeToFit];
    [self.valueLabel setCenter:CGPointMake(self.width / 2, self.height / 2)];
}

@end
