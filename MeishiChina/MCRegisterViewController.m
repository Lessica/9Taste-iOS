//
// Created by Zheng on 15/11/2016.
// Copyright (c) 2016 Zheng. All rights reserved.
//

#import "MCView.h"
#import "MCScrollView.h"
#import "MCRegisterViewController.h"
#import "MCLogo.h"
#import "MCTextFieldView.h"
#import "MCRoundButton.h"
#import <Masonry/Masonry.h>

static CGFloat const MCRegisterViewTopMargin = 32.f;
static CGFloat const MCRegisterViewLeftMargin = 32.f;
static CGFloat const MCRegisterViewRightMargin = 32.f;
static CGFloat const MCRegisterViewFieldHeight = 48.f;
static CGFloat const MCRegisterViewLogoHeight = 60.f;

@interface MCRegisterViewController () <UITextFieldDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) MCScrollView *scrollView;
@property (nonatomic, strong) MCLogo *logoView;
@property (nonatomic, strong) MCView *registerView;
@property (nonatomic, strong) MCTextFieldView *usernameView;
@property (nonatomic, strong) MCTextFieldView *passwordView;
@property (nonatomic, strong) MCTextFieldView *confirmPasswordView;
@property (nonatomic, assign) BOOL isEditing;
@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;
@property (nonatomic, strong) MCRoundButton *registerButton;
@property (nonatomic, strong) MCView *spaceView;

@end

@implementation MCRegisterViewController

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

- (void)setup {
    [super setup];
    self.hidesBottomBarWhenPushed = YES;
}

- (void)loadView {
    MCScrollView *scrollView = [[MCScrollView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    scrollView.backgroundColor = MConfig.appearance.foregroundColor;
    scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    scrollView.bounces = YES;
    scrollView.alwaysBounceVertical = YES;
    scrollView.delegate = self;
    self.view = scrollView;
    self.scrollView = scrollView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"Register", nil);

    [self.view addSubview:self.logoView];

    [self.registerView addSubview:self.usernameView];
    [self.registerView addSubview:self.passwordView];
    [self.registerView addSubview:self.confirmPasswordView];
    [self.view addSubview:self.registerView];
    [self.view addSubview:self.registerButton];
    [self.view addSubview:self.spaceView];

    self.scrollView.contentSize = CGSizeMake(self.scrollView.width,
            MCRegisterViewTopMargin * 5 + MCRegisterViewLogoHeight * 2 + MCRegisterViewFieldHeight * 4
    );

    [self.view addGestureRecognizer:self.tapGestureRecognizer];

    [self updateViewConstraints];
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
    [self.logoView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(MCRegisterViewTopMargin);
        make.centerX.mas_equalTo(self.view);
    }];
    [self updateScrollViewConstraintsWithScreenSize:self.view.bounds.size];
}

- (void)updateScrollViewConstraintsWithScreenSize:(CGSize)screenSize {
    [self.registerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.logoView.mas_bottom).with.offset(MCRegisterViewTopMargin);
        make.left.equalTo(self.view.mas_left).with.offset(MCRegisterViewLeftMargin);
        make.width.equalTo(@(screenSize.width - MCRegisterViewLeftMargin - MCRegisterViewRightMargin));
        make.height.equalTo(@(MCRegisterViewFieldHeight * 3));
    }];
    [self.usernameView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.registerView.mas_top);
        make.left.equalTo(self.registerView.mas_left);
        make.right.equalTo(self.registerView.mas_right);
        make.height.equalTo(@(MCRegisterViewFieldHeight));
    }];
    [self.passwordView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.usernameView.mas_bottom);
        make.left.equalTo(self.registerView.mas_left);
        make.right.equalTo(self.registerView.mas_right);
        make.height.equalTo(@(MCRegisterViewFieldHeight));
    }];
    [self.confirmPasswordView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordView.mas_bottom);
        make.left.equalTo(self.registerView.mas_left);
        make.right.equalTo(self.registerView.mas_right);
        make.height.equalTo(@(MCRegisterViewFieldHeight));
    }];
    [self.registerButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.registerView.mas_bottom).with.offset(MCRegisterViewTopMargin);
        make.left.equalTo(self.registerView.mas_left);
        make.right.equalTo(self.registerView.mas_right);
        make.height.equalTo(@(MCRegisterViewFieldHeight));
    }];
    [self.spaceView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.registerButton.mas_bottom).with.offset(MCRegisterViewTopMargin);
        make.left.equalTo(self.registerView.mas_left);
        make.right.equalTo(self.registerView.mas_right);
        make.height.equalTo(@(MCRegisterViewTopMargin + MCRegisterViewLogoHeight));
    }];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id <UIViewControllerTransitionCoordinator>)coordinator {
    if (self.isEditing)
    {
        [self resignKeyboard];
    }
    [self updateScrollViewConstraintsWithScreenSize:size];
}

#pragma mark - UIView Getters

- (MCLogo *)logoView {
    if (!_logoView) {
        MCLogo *logoView = [[MCLogo alloc] init];
        _logoView = logoView;
    }
    return _logoView;
}

- (MCView *)registerView {
    if (!_registerView)
    {
        MCView *loginView = [[MCView alloc] init];
        _registerView = loginView;
    }
    return _registerView;
}

- (MCTextFieldView *)usernameView {
    if (!_usernameView)
    {
        MCTextFieldView *usernameView = [[MCTextFieldView alloc] init];
        [usernameView.textField setDelegate:self];
        [usernameView.textField setReturnKeyType:UIReturnKeyNext];
        [usernameView.textField setPlaceholder:NSLocalizedString(@"Username", nil)];
        usernameView.verifyBlock = ^NSString *(NSString *text) {
            if (text.length < 4) {
                return NSLocalizedString(@"Invalid username: too short (length < 4).", nil);
            }
            return nil;
        };
        _usernameView = usernameView;
    }
    return _usernameView;
}

- (MCTextFieldView *)passwordView {
    if (!_passwordView)
    {
        MCTextFieldView *passwordView = [[MCTextFieldView alloc] init];
        [passwordView.textField setDelegate:self];
        [passwordView.textField setReturnKeyType:UIReturnKeyNext];
        [passwordView.textField setSecureTextEntry:YES];
        [passwordView.textField setPlaceholder:NSLocalizedString(@"Password", nil)];
        passwordView.verifyBlock = ^NSString *(NSString *text) {
            if (text.length < 7) {
                return NSLocalizedString(@"Invalid password: too short (length < 7).", nil);
            }
            return nil;
        };
        _passwordView = passwordView;
    }
    return _passwordView;
}

- (MCTextFieldView *)confirmPasswordView {
    if (!_confirmPasswordView)
    {
        MCTextFieldView *confirmPasswordView = [[MCTextFieldView alloc] init];
        [confirmPasswordView.textField setDelegate:self];
        [confirmPasswordView.textField setReturnKeyType:UIReturnKeyDone];
        [confirmPasswordView.textField setSecureTextEntry:YES];
        [confirmPasswordView.textField setPlaceholder:NSLocalizedString(@"Confirm Password", nil)];
        @weakify(self);
        confirmPasswordView.verifyBlock = ^NSString *(NSString *text) {
            @strongify(self);
            if (text.length < 7) {
                return NSLocalizedString(@"Invalid confirm password: too short (length < 7).", nil);
            }
            if (![text isEqualToString:self.passwordView.textField.text]) {
                return NSLocalizedString(@"Invalid confirm password: not equal to password.", nil);
            }
            return nil;
        };
        _confirmPasswordView = confirmPasswordView;
    }
    return _confirmPasswordView;
}

- (UITapGestureRecognizer *)tapGestureRecognizer {
    if (!_tapGestureRecognizer)
    {
        UITapGestureRecognizer *tapGestureRecognizer =
                [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewTapped:)];
        _tapGestureRecognizer = tapGestureRecognizer;
    }
    return _tapGestureRecognizer;
}

- (MCRoundButton *)registerButton {
    if (!_registerButton)
    {
        MCRoundButton *loginButton = [[MCRoundButton alloc] init];
        [loginButton setTarget:self action:@selector(registerButtonTapped:)
              forControlEvents:UIControlEventTouchUpInside];
        [loginButton setTitle:NSLocalizedString(@"Register", nil) forState:UIControlStateNormal];
        _registerButton = loginButton;
    }
    return _registerButton;
}

- (MCView *)spaceView {
    if (!_spaceView)
    {
        MCView *spaceView = [[MCView alloc] init];
        _spaceView = spaceView;
    }
    return _spaceView;
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    MCTextField *fieldView = (MCTextField *)textField.superview;
    [fieldView setHighlighted:YES];
    [self.scrollView setContentOffset:CGPointMake(0, MCRegisterViewTopMargin + self.logoView.height) animated:YES];
    self.scrollView.scrollEnabled = NO;
    self.isEditing = YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    MCTextField *fieldView = (MCTextField *)textField.superview;
    [fieldView setHighlighted:NO];
    [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    self.scrollView.scrollEnabled = YES;
    self.isEditing = NO;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.usernameView.textField)
    {
        BOOL usernameVerify = [self.usernameView verify];
        if (!usernameVerify) {
            [self.navigationController.view makeToast:[self.usernameView verifyResult]];
            return NO;
        } else {
            if ([textField isFirstResponder]) {
                [self.passwordView.textField becomeFirstResponder];
            }
        }
    } else if (textField == self.passwordView.textField) {
        BOOL passwordVerify = [self.passwordView verify];
        if (!passwordVerify) {
            [self.navigationController.view makeToast:[self.passwordView verifyResult]];
            return NO;
        } else {
            if ([textField isFirstResponder]) {
                [self.confirmPasswordView.textField becomeFirstResponder];
            }
        }
    } else {
        BOOL confirmPasswordVerify = [self.confirmPasswordView verify];
        if (!confirmPasswordVerify) {
            [self.navigationController.view makeToast:[self.confirmPasswordView verifyResult]];
            return NO;
        } else {
            [self registerButtonTapped:nil];
        }
    }
    return YES;
}

#pragma mark - Tap Event

- (void)scrollViewTapped:(UITapGestureRecognizer *)sender {
    if (self.isEditing) {
        [self resignKeyboard];
    }
}

#pragma mark - Dismiss

- (void)resignKeyboard {
    if ([self.usernameView.textField isFirstResponder]) {
        [self.usernameView.textField resignFirstResponder];
    } else if ([self.passwordView.textField isFirstResponder]) {
        [self.passwordView.textField resignFirstResponder];
    } else if ([self.confirmPasswordView.textField isFirstResponder]) {
        [self.confirmPasswordView.textField resignFirstResponder];
    }
}

- (void)viewControllerWillDismiss {
    [self resignKeyboard];
}

#pragma mark - Actions

- (void)registerButtonTapped:(UIBarButtonItem *)sender {
    BOOL usernameVerify = [self.usernameView verify];
    if (!usernameVerify) {
        [self.navigationController.view makeToast:[self.usernameView verifyResult]];
        return;
    }
    BOOL passwordVerify = [self.passwordView verify];
    if (!passwordVerify) {
        [self.navigationController.view makeToast:[self.passwordView verifyResult]];
        return;
    }
    BOOL confirmPasswordVerify = [self.confirmPasswordView verify];
    if (!confirmPasswordVerify) {
        [self.navigationController.view makeToast:[self.confirmPasswordView verifyResult]];
        return;
    }
    if (usernameVerify && passwordVerify && confirmPasswordVerify)
    {
        [self registerNow];
    }
}

- (void)registerNow {
    NSString *username = self.usernameView.textField.text;
    NSString *password = [self.passwordView.textField.text sha1String];
    NSDictionary *requestDictionary = @{
        @"action": @"register",
        @"form": @{
            @"username": username,
            @"password": password
        }
    };
    self.navigationController.view.userInteractionEnabled = NO;
    [self.navigationController.view makeToastActivity:CSToastPositionCenter];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^() {
        NSError *requestError = nil;
        NSDictionary *responseDictionary = [MNet sendSynchronousRequest:requestDictionary error:&requestError];
        dispatch_async_on_main_queue(^() {
            [self.navigationController.view hideToastActivity];
            self.navigationController.view.userInteractionEnabled = YES;
            if (requestError != nil) {
                [self.navigationController.view makeToast:[requestError localizedDescription]];
                return;
            }
            MCLog(@"%@", responseDictionary);
            NSString *errorMsg = responseDictionary[@"error"];
            if (errorMsg && errorMsg.length > 0) {
                [self.navigationController.view makeToast:errorMsg];
                return;
            }
            NSDictionary *dataDict = responseDictionary[@"data"];
            if (!dataDict) {
                return;
            }
            NSNumber *userid = dataDict[@"user_id"];
            if (!userid) {
                return;
            }
            [self.navigationController.view makeToast:NSLocalizedString(@"Register succeed, please login.", nil)];
            [self viewControllerWillDismiss];
            [self.navigationController popViewControllerAnimated:YES];
        });
    });
}

@end
