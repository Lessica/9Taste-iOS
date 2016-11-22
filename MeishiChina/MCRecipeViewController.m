//
//  MCRecipeViewController.m
//  MeishiChina
//
//  Created by Zheng on 22/11/2016.
//  Copyright © 2016 Zheng. All rights reserved.
//

#import "MCRecipeViewController.h"
#import "MCSurveyView.h"
#import "MCWebViewController.h"

@interface MCRecipeViewController () <MCSurveyViewDelegate>
@property (nonatomic, strong) MCSurveyView *surveyView;

@end

@implementation MCRecipeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.surveyView];
}

#pragma mark - UIView Getters

- (MCSurveyView *)surveyView {
    if (!_surveyView) {
        MCSurveyView *surveyView = [[MCSurveyView alloc] initWithFrame:self.view.bounds];
        surveyView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        surveyView.delegate = self;
        surveyView.surveyDict = self.surveyDict.mutableCopy;
        _surveyView = surveyView;
    }
    return _surveyView;
}

#pragma mark - MCSurveyView

- (void)surveyViewDidChanged:(MCSurveyView *)view {
    NSNumber *userId = MNet.userState[MCNetworkUserStateKeyUserID];
    if (!userId) {
        [self.navigationController.view makeToast:NSLocalizedString(@"Please Login", nil)];
        return;
    }
    NSDictionary *requestDictionary = @{
                                        @"action": @"rate",
                                        @"form": @{
                                                @"user_id": userId,
                                                @"feedbacks": @[
                                                        @{
                                                            @"recipe_id": view.surveyDict[kMCSurveyKeyRecipeId],
                                                            @"rating": view.surveyDict[kMCAnswerKeyRecipeRating],
                                                            }
                                                        ]
                                                }
                                        };
    MCLog(@"%@", requestDictionary);
    self.navigationController.view.userInteractionEnabled = NO;
    [self.navigationController.view makeToastActivity:CSToastPositionCenter];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^() {
        NSError *requestError = nil;
        NSDictionary *responseDictionary = [MNet sendSynchronousRequest:requestDictionary error:&requestError];
        dispatch_async_on_main_queue(^() {
            view.hasAnswered = YES;
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
            [self.navigationController.view makeToast:NSLocalizedString(@"Operation completed", nil)];
        });
    });
}

- (void)surveyViewDetailDidTapped:(MCSurveyView *)view {
    NSURL *recipeUrl =
    [NSURL URLWithString:[NSString stringWithFormat:@"http://m.meishichina.com/recipe/%lu/", [view.surveyDict[kMCSurveyKeyRecipeId] unsignedIntegerValue]]];
    MCWebViewController *webViewController = [[MCWebViewController alloc] init];
    webViewController.url = recipeUrl;
    [self.navigationController pushViewController:webViewController animated:YES];
}

@end
