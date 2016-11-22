//
// Created by Zheng on 15/11/2016.
// Copyright (c) 2016 Zheng. All rights reserved.
//

#import "MCView.h"
#import "MCScrollView.h"
#import "MCLoginViewController.h"
#import "MCRegisterViewController.h"
#import "MCLogo.h"
#import "MCTextFieldView.h"
#import "MCRoundButton.h"
#import "MCBarButtonItem.h"
#import <Masonry/Masonry.h>

static CGFloat const MCLoginViewTopMargin = 32.f;
static CGFloat const MCLoginViewLeftMargin = 32.f;
static CGFloat const MCLoginViewRightMargin = 32.f;
static CGFloat const MCLoginViewFieldHeight = 48.f;
static CGFloat const MCLoginViewLogoHeight = 60.f;

@interface MCLoginViewController () <UITextFieldDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) MCScrollView *scrollView;
@property (nonatomic, strong) MCLogo *logoView;
@property (nonatomic, strong) MCView *loginView;
@property (nonatomic, strong) MCTextFieldView *usernameView;
@property (nonatomic, strong) MCTextFieldView *passwordView;
@property (nonatomic, assign) BOOL isEditing;
@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;
@property (nonatomic, strong) MCRoundButton *loginButton;
@property (nonatomic, strong) MCView *spaceView;
@property (nonatomic, strong) MCBarButtonItem *registerButtonItem;

@end

@implementation MCLoginViewController

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
    self.title = NSLocalizedString(@"Login", nil);

    [self.view addSubview:self.logoView];

    [self.loginView addSubview:self.usernameView];
    [self.loginView addSubview:self.passwordView];
    [self.view addSubview:self.loginView];
    [self.view addSubview:self.loginButton];
    [self.view addSubview:self.spaceView];

    self.scrollView.contentSize = CGSizeMake(MIN(self.scrollView.width, self.scrollView.height),
            MCLoginViewTopMargin * 5 + MCLoginViewLogoHeight * 2 + MCLoginViewFieldHeight * 3
    );

    [self.view addGestureRecognizer:self.tapGestureRecognizer];
    self.navigationItem.rightBarButtonItem = self.registerButtonItem;

    [self updateViewConstraints];
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
    [self.logoView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(MCLoginViewTopMargin);
        make.centerX.mas_equalTo(self.view);
    }];
    [self updateScrollViewConstraintsWithScreenSize:self.view.bounds.size];
}

- (void)updateScrollViewConstraintsWithScreenSize:(CGSize)screenSize {
    [self.loginView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.logoView.mas_bottom).with.offset(MCLoginViewTopMargin);
        make.left.equalTo(self.view.mas_left).with.offset(MCLoginViewLeftMargin);
        make.width.equalTo(@(screenSize.width - MCLoginViewLeftMargin - MCLoginViewRightMargin));
        make.height.equalTo(@(MCLoginViewFieldHeight * 2));
    }];
    [self.usernameView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loginView.mas_top);
        make.left.equalTo(self.loginView.mas_left);
        make.right.equalTo(self.loginView.mas_right);
        make.height.equalTo(@(MCLoginViewFieldHeight));
    }];
    [self.passwordView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.loginView.mas_bottom);
        make.left.equalTo(self.loginView.mas_left);
        make.right.equalTo(self.loginView.mas_right);
        make.height.equalTo(@(MCLoginViewFieldHeight));
    }];
    [self.loginButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loginView.mas_bottom).with.offset(MCLoginViewTopMargin);
        make.left.equalTo(self.loginView.mas_left);
        make.right.equalTo(self.loginView.mas_right);
        make.height.equalTo(@(MCLoginViewFieldHeight));
    }];
    [self.spaceView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loginButton.mas_bottom).with.offset(MCLoginViewTopMargin);
        make.left.equalTo(self.loginView.mas_left);
        make.right.equalTo(self.loginView.mas_right);
        make.height.equalTo(@(MCLoginViewTopMargin + MCLoginViewLogoHeight));
    }];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id <UIViewControllerTransitionCoordinator>)coordinator {
    if (self.isEditing) {
        [self resignKeyboard];
    }
    [coordinator animateAlongsideTransition:^(id <UIViewControllerTransitionCoordinatorContext> context) {
        [self updateScrollViewConstraintsWithScreenSize:size];
    } completion:^(id <UIViewControllerTransitionCoordinatorContext> context) {

    }];
}

#pragma mark - UIView Getters

- (MCLogo *)logoView {
    if (!_logoView) {
        MCLogo *logoView = [[MCLogo alloc] init];
        _logoView = logoView;
    }
    return _logoView;
}

- (MCView *)loginView {
    if (!_loginView)
    {
        MCView *loginView = [[MCView alloc] init];
        _loginView = loginView;
    }
    return _loginView;
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
        [passwordView.textField setReturnKeyType:UIReturnKeyDone];
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

- (UITapGestureRecognizer *)tapGestureRecognizer {
    if (!_tapGestureRecognizer)
    {
        UITapGestureRecognizer *tapGestureRecognizer =
                [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewTapped:)];
        _tapGestureRecognizer = tapGestureRecognizer;
    }
    return _tapGestureRecognizer;
}

- (MCRoundButton *)loginButton {
    if (!_loginButton)
    {
        MCRoundButton *loginButton = [[MCRoundButton alloc] init];
        [loginButton setTarget:self action:@selector(loginButtonTapped:)
              forControlEvents:UIControlEventTouchUpInside];
        [loginButton setTitle:NSLocalizedString(@"Login", nil) forState:UIControlStateNormal];
        _loginButton = loginButton;
    }
    return _loginButton;
}

- (MCView *)spaceView {
    if (!_spaceView)
    {
        MCView *spaceView = [[MCView alloc] init];
        _spaceView = spaceView;
    }
    return _spaceView;
}

- (MCBarButtonItem *)registerButtonItem {
    if (!_registerButtonItem) {
        MCBarButtonItem *registerButtonItem = [[MCBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Register", nil)
                                                                               style:UIBarButtonItemStylePlain
                                                                              target:self action:@selector(registerBarButtonTapped:)];
        [registerButtonItem setReversedStyle:YES];
        _registerButtonItem = registerButtonItem;
    }
    return _registerButtonItem;
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    MCTextFieldView *fieldView = (MCTextFieldView *)textField.superview;
    [fieldView setHighlighted:YES];
    [self.scrollView setContentOffset:CGPointMake(0, MCLoginViewTopMargin + self.logoView.height) animated:YES];
    self.scrollView.scrollEnabled = NO;
    self.isEditing = YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    MCTextFieldView *fieldView = (MCTextFieldView *)textField.superview;
    [fieldView setHighlighted:NO];
    [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    self.scrollView.scrollEnabled = YES;
    self.isEditing = NO;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    MCTextFieldView *fieldView = (MCTextFieldView *)textField.superview;
    if (fieldView == self.usernameView)
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
    } else {
        BOOL passwordVerify = [self.passwordView verify];
        if (!passwordVerify) {
            [self.navigationController.view makeToast:[self.passwordView verifyResult]];
            return NO;
        } else {
            [self loginButtonTapped:nil];
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
    }
}

- (void)viewControllerWillDismiss {
    [self resignKeyboard];
}

#pragma mark - Component Actions

- (void)loginButtonTapped:(MCButton *)sender {
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
    if (usernameVerify && passwordVerify)
    {
        [self loginNow];
    }
}

- (void)registerBarButtonTapped:(UIBarButtonItem *)sender {
    [self resignKeyboard];
    MCRegisterViewController *registerController = [[MCRegisterViewController alloc] init];
    [self.navigationController pushViewController:registerController animated:YES];
}

#pragma mark - Actions

- (void)loginNow {
    NSString *username = self.usernameView.textField.text;
    NSString *password = [self.passwordView.textField.text sha1String];
    NSDictionary *requestDictionary = @{
        @"action": @"login",
        @"form": @{
            @"username": username,
            @"password": password
        }
    };
    MCLog(@"%@", requestDictionary);
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
            NSDictionary *userState = @{ MCNetworkUserStateKeyUserName: username, MCNetworkUserStateKeyUserID: userid };
            [MNet setUserState:userState];
            [self viewControllerWillDismiss];
            [self dismissViewControllerAnimated:YES completion:nil];
        });
    });
}

@end
