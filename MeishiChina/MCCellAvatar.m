//
//  MCCellAvatar.m
//  MeishiChina
//
//  Created by Zheng on 08/11/2016.
//  Copyright © 2016 Zheng. All rights reserved.
//

#import "MCCellAvatar.h"

@interface MCCellAvatar ()
@property (nonatomic, strong) UIButton *addMaskView;
@property (nonatomic, strong) UILabel *addLabel;

@end

@implementation MCCellAvatar

- (void)setup {
    [super setup];

    self.userInteractionEnabled = YES;
    [self.layer setCornerRadius:self.height / 2];
    [self.layer setMasksToBounds:YES];
    
    [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"alpha-pattern"]]];
    [self.addMaskView addSubview:self.addLabel];
    [self addSubview:self.addMaskView];
}

#pragma mark - Getters

- (UIButton *)addMaskView {
    if (!_addMaskView) {
        UIButton *addMaskView = [[UIButton alloc] initWithFrame:self.bounds];
        addMaskView.backgroundColor = [UIColor blackColor];
        addMaskView.alpha = .3f;
        addMaskView.showsTouchWhenHighlighted = YES;
        [addMaskView setTarget:self action:@selector(addMaskViewTapped:) forControlEvents:UIControlEventTouchUpInside];
        _addMaskView = addMaskView;
    }
    return _addMaskView;
}

- (UILabel *)addLabel {
    if (!_addLabel) {
        UILabel *addLabel = [[UILabel alloc] init];
        addLabel.text = NSLocalizedString(@"Add", nil);
        addLabel.textColor = MConfig.appearance.maskLabelTextColor;
        addLabel.font = MConfig.appearance.maskLabelTextFont;
        [addLabel sizeToFit];
        addLabel.center = CGPointMake(self.width / 2, self.height / 2);
        _addLabel = addLabel;
    }
    return _addLabel;
}

#pragma mark - Setters

- (void)setHidesImageMaskView:(BOOL)hides {
    self.addMaskView.hidden = hides;
}

#pragma mark - Actions

- (void)addMaskViewTapped:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(avatarDidTapped:)])
    {
        [_delegate avatarDidTapped:self];
    }
}

@end
