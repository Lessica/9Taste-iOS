//
//  MCAvatarTableViewCell.m
//  MeishiChina
//
//  Created by Zheng on 08/11/2016.
//  Copyright © 2016 Zheng. All rights reserved.
//

#import "MCAvatarTableViewCell.h"

static CGFloat const MCAvatarTableViewCellAvatarLeftMargin = 16.f;
static CGFloat const MCAvatarTableViewCellAvatarRightMargin = 16.f;
static CGFloat const MCAvatarTableViewCellLabelTopMargin = 6.f;
static CGFloat const MCAvatarTableViewCellLabelMiddleMargin = 4.f;

@interface MCAvatarTableViewCell ()
@property (nonatomic, strong) MCCellAvatar *avatarView;
@property (nonatomic, strong) UILabel *userNameLabel;
@property (nonatomic, strong) UILabel *userEmailLabel;

@end

@implementation MCAvatarTableViewCell

- (void)setup {
    [super setup];

    self.separatorInset = UIEdgeInsetsZero;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self addSubview:self.avatarView];
    [self addSubview:self.userNameLabel];
    [self addSubview:self.userEmailLabel];
    self.userNameText = nil;
    self.userEmailText = nil;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.avatarView.center = CGPointMake(
            MCAvatarTableViewCellAvatarLeftMargin + self.avatarView.width / 2,
            self.height / 2);
    self.userNameLabel.origin = CGPointMake(
            MCAvatarTableViewCellAvatarLeftMargin + self.avatarView.width + MCAvatarTableViewCellAvatarRightMargin,
            self.avatarView.origin.y + MCAvatarTableViewCellLabelTopMargin);
    self.userEmailLabel.origin = CGPointMake(
            self.userNameLabel.origin.x,
            self.userNameLabel.origin.y + self.userNameLabel.height + MCAvatarTableViewCellLabelMiddleMargin);
}

#pragma mark - UIView Getters

- (MCCellAvatar *)avatarView {
    if (!_avatarView) {
        MCCellAvatar *avatarView = [[MCCellAvatar alloc] initWithFrame:CGRectMake(0, 0, 64, 64)];
        _avatarView = avatarView;
    }
    return _avatarView;
}

- (UILabel *)userNameLabel {
    if (!_userNameLabel) {
        UILabel *userNameLabel = [[UILabel alloc] init];
        userNameLabel.font = MConfig.appearance.nickNameFont;
        userNameLabel.textColor = MConfig.appearance.nickNameColor;
        _userNameLabel = userNameLabel;
    }
    return _userNameLabel;
}

- (UILabel *)userEmailLabel {
    if (!_userEmailLabel) {
        UILabel *userEmailLabel = [[UILabel alloc] init];
        userEmailLabel.font = MConfig.appearance.emailFont;
        userEmailLabel.textColor = MConfig.appearance.emailColor;
        _userEmailLabel = userEmailLabel;
    }
    return _userEmailLabel;
}

#pragma mark - Foundation Getters

- (NSURL *)avatarImageUrl {
    return self.avatarView.yy_imageURL;
}

- (id <MCCellAvatarDelegate>)avatarDelegate {
    return self.avatarView.delegate;
}

- (NSString *)userNameText {
    return self.userNameLabel.text;
}

- (NSString *)userEmailText {
    return self.userEmailLabel.text;
}

#pragma mark - Foundation Setters

- (void)setAvatarImageUrl:(NSURL *)avatarImageUrl {
    [self.avatarView yy_setImageWithURL:avatarImageUrl
                                options:YYWebImageOptionShowNetworkActivity | YYWebImageOptionProgressiveBlur | YYWebImageOptionSetImageWithFadeAnimation];
    [self.avatarView setHidesImageMaskView:YES];
}

- (void)setAvatarDelegate:(id<MCCellAvatarDelegate>)avatarDelegate {
    self.avatarView.delegate = avatarDelegate;
}

- (void)setUserNameText:(NSString *)userNameText {
    if (userNameText) {
        self.userNameLabel.text = userNameText;
    } else {
        self.userNameLabel.text = NSLocalizedString(@"Not Login", nil);
    }
    [self.userNameLabel sizeToFit];
}

- (void)setUserEmailText:(NSString *)userEmailText {
    if (userEmailText) {
        self.userEmailLabel.text = userEmailText;
    } else {
        self.userEmailLabel.text = NSLocalizedString(@"Tap to Login", nil);
    }
    [self.userEmailLabel sizeToFit];
}

@end
