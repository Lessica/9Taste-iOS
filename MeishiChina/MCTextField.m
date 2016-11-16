//
// Created by Zheng on 16/11/2016.
// Copyright (c) 2016 Zheng. All rights reserved.
//

#import "MCTextField.h"


@implementation MCTextField

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
    self.font = MConfig.appearance.textFieldFont;
    self.textColor = MConfig.appearance.textFieldColor;
    self.textAlignment = NSTextAlignmentLeft;
    self.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.autocorrectionType = UITextAutocorrectionTypeNo;
}

- (void)setPlaceholder:(NSString *)placeholder {
    NSDictionary *attributes = @{
            NSFontAttributeName: MConfig.appearance.textFieldPlaceHolderFont,
            NSForegroundColorAttributeName: MConfig.appearance.textFieldPlaceHolderColor,
    };
    NSAttributedString *attributedPlaceholder =
            [[NSAttributedString alloc] initWithString:placeholder attributes:attributes];
    [super setAttributedPlaceholder:attributedPlaceholder];
}

@end