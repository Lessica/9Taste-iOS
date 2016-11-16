//
// Created by Zheng on 15/11/2016.
// Copyright (c) 2016 Zheng. All rights reserved.
//

#import "MCAboutTableViewCell.h"
#import "MCCellLogo.h"
#import "MCLabel.h"

static CGFloat const MCAboutTableViewCellLogoTopMargin = 18.f;
static CGFloat const MCAboutTableViewCellAppNameTopMargin = 8.f;
static CGFloat const MCAboutTableViewCellAppDescriptionTopMargin = 8.f;

@interface MCAboutTableViewCell ()
@property (nonatomic, strong) MCCellLogo *logoImage;
@property (nonatomic, strong) MCLabel *appNameLabel;
@property (nonatomic, strong) MCLabel *appDescriptionLabel;

@end

@implementation MCAboutTableViewCell

- (void)setup {
    [super setup];

    self.separatorInset = UIEdgeInsetsZero;
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    [self addSubview:self.logoImage];
    [self addSubview:self.appNameLabel];
    [self addSubview:self.appDescriptionLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.logoImage.center = CGPointMake(self.width / 2,
            self.logoImage.height / 2 + MCAboutTableViewCellLogoTopMargin);
    self.appNameLabel.center = CGPointMake(self.width / 2,
            self.logoImage.bottom + self.appNameLabel.height / 2 + MCAboutTableViewCellAppNameTopMargin);
    self.appDescriptionLabel.center = CGPointMake(self.width / 2,
            self.appNameLabel.bottom + self.appDescriptionLabel.height / 2 + MCAboutTableViewCellAppDescriptionTopMargin);
}

#pragma mark - UIView Getters

- (MCCellLogo *)logoImage {
    if (!_logoImage) {
        MCCellLogo *logoImage = [[MCCellLogo alloc] init];
        _logoImage = logoImage;
    }
    return _logoImage;
}

- (MCLabel *)appNameLabel {
    if (!_appNameLabel) {
        MCLabel *appNameLabel = [[MCLabel alloc] init];
        appNameLabel.text = [NSString stringWithFormat:NSLocalizedString(@"9Taste\nV%@ (%@)", nil),
                        [[UIApplication sharedApplication] appVersion],
                        [[UIApplication sharedApplication] appBuildVersion]];
        appNameLabel.numberOfLines = 2;
        appNameLabel.textAlignment = NSTextAlignmentCenter;
        appNameLabel.textColor = MConfig.appearance.appNameColor;
        appNameLabel.font = MConfig.appearance.appNameFont;
        [appNameLabel sizeToFit];
        _appNameLabel = appNameLabel;
    }
    return _appNameLabel;
}

- (MCLabel *)appDescriptionLabel {
    if (!_appDescriptionLabel) {
        MCLabel *appDescriptionLabel = [[MCLabel alloc] init];
        appDescriptionLabel.text = NSLocalizedString(@"https://82flex.com\n2016 © 82Flex Studio.\nAll rights reserved.", nil);
        appDescriptionLabel.numberOfLines = 3;
        appDescriptionLabel.textAlignment = NSTextAlignmentCenter;
        appDescriptionLabel.textColor = MConfig.appearance.appDescriptionColor;
        appDescriptionLabel.font = MConfig.appearance.appDescriptionFont;
        [appDescriptionLabel sizeToFit];
        _appDescriptionLabel = appDescriptionLabel;
    }
    return _appDescriptionLabel;
}

@end
