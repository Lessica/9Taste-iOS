//
//  MCSurveyViewController.m
//  MeishiChina
//
//  Created by Zheng on 17/11/2016.
//  Copyright © 2016 Zheng. All rights reserved.
//

#import "MCSurveyViewController.h"
#import "MCScrollView.h"
#import "MCPageControl.h"
#import "MCSurveyView.h"
#import "MCWebViewController.h"

#define MC_SURVEY_PAGE_NUM 10

@interface MCSurveyViewController () <UIScrollViewDelegate, MCSurveyViewDelegate>

@property (nonatomic, strong) MCScrollView *scrollView;
@property (nonatomic, strong) MCPageControl *pageControl;
@property (nonatomic, strong) NSArray <MCSurveyView *> *surveyViewList;
@property (nonatomic, assign) BOOL dataLoading;
@property (nonatomic, assign) BOOL dataLoaded;

@end

@implementation MCSurveyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.navigationController.navigationBar setTranslucent:NO];
    
    self.title = NSLocalizedString(@"Survey", nil);
    [self.view addSubview:self.scrollView];
    [self loadSurveyViewWithSize:self.view.size];
    [self.view addSubview:self.pageControl];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // Load Survey Here
    if (!self.dataLoaded && !self.dataLoading) {
        self.dataLoading = YES;
        [self loadSurvey];
    }
}

#pragma mark - Load

- (void)loadSurvey {
    NSDictionary *requestDictionary = @{
            @"action": @"fetch_survey",
            @"form": @{
                    @"length": @(MC_SURVEY_PAGE_NUM),
            }
    };
    self.navigationController.view.userInteractionEnabled = NO;
    [self.navigationController.view makeToastActivity:CSToastPositionCenter];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^() {
        NSError *requestError = nil;
        NSDictionary *responseDictionary = [MNet sendSynchronousRequest:requestDictionary error:&requestError];
        dispatch_async_on_main_queue(^() {
            self.dataLoading = NO;
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
            NSArray *dataList = dataDict[@"list"];
            if (!dataList) {
                return;
            }
            MCLog(@"%@", dataList);
            self.dataLoaded = YES;
            [self loadSurveyList:dataList];
        });
    });
}

- (void)loadSurveyList:(NSArray <NSDictionary *> *)surveyArray {
    NSUInteger pageIndex = 0;
    for (MCSurveyView *surveyView in self.surveyViewList)
    {
        if (pageIndex >= surveyArray.count) break;
        surveyView.surveyDict = surveyArray[pageIndex];
        pageIndex++;
    }
}

- (void)loadSurveyViewWithSize:(CGSize)size {
    NSMutableArray <MCSurveyView *> *surveyViewList = [[NSMutableArray alloc] initWithCapacity:MC_SURVEY_PAGE_NUM];
    CGFloat pageWidth = size.width;
    for (NSUInteger pageIndex = 0; pageIndex < MC_SURVEY_PAGE_NUM; pageIndex++)
    {
        CGRect surveyRect = CGRectMake(pageIndex * pageWidth, 0, size.width, size.height);
        MCSurveyView *surveyView =
                [[MCSurveyView alloc] initWithFrame:surveyRect];
        surveyView.delegate = self;
        [self.scrollView addSubview:surveyView];
        [surveyViewList addObject:surveyView];
    }
    self.surveyViewList = surveyViewList;
    self.scrollView.contentSize = CGSizeMake(pageWidth * MC_SURVEY_PAGE_NUM, 0);
}

#pragma mark - UIView Getters

- (MCPageControl *)pageControl {
    if (!_pageControl) {
        MCPageControl *pageControl = [[MCPageControl alloc] initWithFrame:CGRectMake(0, 4.f, self.view.width, 16.f)];
        pageControl.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        pageControl.numberOfPages = MC_SURVEY_PAGE_NUM;
        pageControl.currentPage = 0;
        [pageControl addTarget:self action:@selector(pageControlTapped:) forControlEvents:UIControlEventValueChanged];
        _pageControl = pageControl;
    }
    return _pageControl;
}

- (MCScrollView *)scrollView {
    if (!_scrollView) {
        MCScrollView *scrollView = [[MCScrollView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        scrollView.backgroundColor = MConfig.appearance.foregroundColor;
        scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        scrollView.bounces = NO;
        scrollView.pagingEnabled = YES;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.delegate = self;
        _scrollView = scrollView;
    }
    return _scrollView;
}

#pragma mark - ScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == self.scrollView) {
        self.pageControl.currentPage = (NSInteger) (scrollView.contentOffset.x / scrollView.width);
    }
}

#pragma mark - MCPageControl

- (void)pageControlTapped:(MCPageControl *)pageControl {
    CGRect toRect = self.scrollView.bounds;
    toRect.origin.x = pageControl.currentPage * toRect.size.width;
    toRect.origin.y = 0;
    [self.scrollView setContentOffset:toRect.origin animated:YES];
}

#pragma mark - MCSurveyViewDelegate

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
                                    @"rating": view.answerDict[kMCAnswerKeyRecipeRating],
                            }
                    ]
            }
    };
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
            [NSURL URLWithString:[NSString stringWithFormat:@"http://m.meishichina.com/recipe/%u/", [view.surveyDict[kMCSurveyKeyRecipeId] unsignedIntegerValue]]];
    MCWebViewController *webViewController = [[MCWebViewController alloc] init];
    webViewController.url = recipeUrl;
    [self.navigationController pushViewController:webViewController animated:YES];
}

@end
