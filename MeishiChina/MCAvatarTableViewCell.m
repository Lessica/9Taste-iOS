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
static CGFloat const MCAvatarTableViewCellLabelTopMargin = 2.f;
static CGFloat const MCAvatarTableViewCellLabelMiddleMargin = 4.f;

@interface MCAvatarTableViewCell ()
@property (nonatomic, strong) MCCellAvatar *avatarView;
@property (nonatomic, strong) UILabel *userNameLabel;
@property (nonatomic, strong) UILabel *userEmailLabel;

@end

@implementation MCAvatarTableViewCell

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
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self addSubview:self.avatarView];
    [self addSubview:self.userNameLabel];
    [self addSubview:self.userEmailLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.avatarView.center = CGPointMake(MCAvatarTableViewCellAvatarLeftMargin + self.avatarView.width / 2, self.height / 2);
    self.userNameLabel.origin = CGPointMake(MCAvatarTableViewCellAvatarLeftMargin + self.avatarView.width + MCAvatarTableViewCellAvatarRightMargin, self.avatarView.origin.y + MCAvatarTableViewCellLabelTopMargin);
    self.userEmailLabel.origin = CGPointMake(self.userNameLabel.origin.x, self.userNameLabel.origin.y + self.userNameLabel.height + MCAvatarTableViewCellLabelMiddleMargin);
}

#pragma mark - Getters

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
        userNameLabel.text = NSLocalizedString(@"Not Login", nil);
        userNameLabel.font = MConfig.appearance.nickNameFont;
        userNameLabel.textColor = MConfig.appearance.nickNameColor;
        [userNameLabel sizeToFit];
        _userNameLabel = userNameLabel;
    }
    return _userNameLabel;
}

- (UILabel *)userEmailLabel {
    if (!_userEmailLabel) {
        UILabel *userEmailLabel = [[UILabel alloc] init];
        userEmailLabel.text = NSLocalizedString(@"Tap to Login", nil);
        userEmailLabel.font = MConfig.appearance.emailFont;
        userEmailLabel.textColor = MConfig.appearance.emailColor;
        [userEmailLabel sizeToFit];
        _userEmailLabel = userEmailLabel;
    }
    return _userEmailLabel;
}

#pragma mark - Setters

- (void)setAvatarImageUrl:(NSURL *)avatarImageUrl {
    _avatarImageUrl = avatarImageUrl;
    [self.avatarView yy_setImageWithURL:avatarImageUrl
                                options:YYWebImageOptionShowNetworkActivity | YYWebImageOptionProgressiveBlur | YYWebImageOptionSetImageWithFadeAnimation];
    [self.avatarView setHidesImageMaskView:YES];
}

- (void)setAvatarDelegate:(id<MCCellAvatarDelegate>)avatarDelegate {
    _avatarDelegate = avatarDelegate;
    self.avatarView.delegate = self.avatarDelegate;
}


- (void)setUserNameText:(NSString *)userNameText {
    _userNameText = userNameText;
    self.userNameLabel.text = userNameText;
    [self.userNameLabel sizeToFit];
}

- (void)setUserEmailText:(NSString *)userEmailText {
    _userEmailText = userEmailText;
    self.userEmailLabel.text = userEmailText;
    [self.userEmailLabel sizeToFit];
}

@end
