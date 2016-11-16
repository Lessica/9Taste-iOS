//
// Created by Zheng on 16/11/2016.
// Copyright (c) 2016 Zheng. All rights reserved.
//

#import "MCView.h"
#import "MCTextField.h"

@interface MCTextFieldView : MCView

typedef NSString *(^MCTextFieldVerifyBlock)(NSString *text);

@property (nonatomic, strong) MCTextField *textField;
@property (nonatomic, assign) BOOL highlighted;

@property (nonatomic, copy) MCTextFieldVerifyBlock verifyBlock;
@property (nonatomic, copy) NSString *verifyResult;
- (BOOL)verify;

@end
