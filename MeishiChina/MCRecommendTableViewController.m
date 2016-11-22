//
//  MCRecommendTableViewController.m
//  MeishiChina
//
//  Created by Zheng on 06/11/2016.
//  Copyright © 2016 Zheng. All rights reserved.
//

#import "MCRecommendTableViewController.h"
#import "MCRecipeCell.h"
#import "MCSurveyView.h"
#import "MCRecipeViewController.h"

#define MC_RECOMMENDATION_PAGE_NUM 10

static const NSInteger MCRecommendTableViewSectionNum = 1;
typedef enum : NSUInteger {
    MCRecommendTableViewSectionHead = 0,
} MCRecommendTableViewSection;
static NSString * const MCRecommendTableViewSectionHeadRowCellIdentifier = @"MCRecommendTableViewSectionHeadRowCellIdentifier";
static CGFloat const MCRecommendTableViewSectionHeadRowCellHeight = 144.f;

@interface MCRecommendTableViewController ()

@property (nonatomic, strong) NSArray <NSDictionary *> *recommendationList;
@property (nonatomic, assign) BOOL dataLoading;
@property (nonatomic, assign) BOOL dataLoaded;

@end

@implementation MCRecommendTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UITableViewController *tableViewController = [[UITableViewController alloc] init];
    tableViewController.tableView = self.tableView;
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(loadRecommendation:) forControlEvents:UIControlEventValueChanged];
    [tableViewController setRefreshControl:refreshControl];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.navigationController.navigationBar setTranslucent:NO];
    
    self.title = NSLocalizedString(@"Recommend", nil);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationReceived:) name:MCNetworkNotificationUserStateChanged object:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // Load Survey Here
    if (!self.dataLoaded && !self.dataLoading) {
        self.dataLoading = YES;
        [self loadRecommendation:nil];
    } else if (!MNet.userState) {
        [self clearData];
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MCNetworkNotificationUserStateChanged object:nil];
}

- (void)notificationReceived:(NSNotification *)aNotification {
    if ([aNotification.name isEqualToString:MCNetworkNotificationUserStateChanged]) {
        if (!aNotification.userInfo[MCNetworkNotificationUserInfoKeyUserState]) {
            [self clearData];
        }
    }
}

#pragma mark - Load

- (void)clearData {
    self.dataLoaded = NO;
    self.dataLoading = NO;
    self.recommendationList = nil;
    [self.tableView reloadData];
}

- (void)loadRecommendation:(UIRefreshControl *)sender {
    NSNumber *userId = MNet.userState[MCNetworkUserStateKeyUserID];
    if (!userId) {
        self.dataLoading = NO;
        [self.navigationController.view makeToast:NSLocalizedString(@"Please Login", nil)];
        if ([sender isRefreshing]) {
            [sender endRefreshing];
        }
        return;
    }
    NSDictionary *requestDictionary = @{
                                        @"action": @"fetch_recommendation",
                                        @"form": @{
                                                @"user_id": userId,
                                                @"length": @(MC_RECOMMENDATION_PAGE_NUM),
                                                }
                                        };
    MCLog(@"%@", requestDictionary);
    if (!sender) {
        self.navigationController.view.userInteractionEnabled = NO;
        [self.navigationController.view makeToastActivity:CSToastPositionCenter];
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^() {
        NSError *requestError = nil;
        NSDictionary *responseDictionary = [MNet sendSynchronousRequest:requestDictionary error:&requestError];
        dispatch_async_on_main_queue(^() {
            self.dataLoading = NO;
            if (!sender) {
                [self.navigationController.view hideToastActivity];
                self.navigationController.view.userInteractionEnabled = YES;
            }
            if ([sender isRefreshing]) {
                [sender endRefreshing];
            }
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
            self.recommendationList = dataList;
            [self.tableView reloadData];
        });
    });
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return MCRecommendTableViewSectionNum;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == MCRecommendTableViewSectionHead) {
        return self.recommendationList.count;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == MCRecommendTableViewSectionHead) {
        return MCRecommendTableViewSectionHeadRowCellHeight;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == MCRecommendTableViewSectionHead)
    {
        MCRecipeCell *cell = [tableView dequeueReusableCellWithIdentifier:MCRecommendTableViewSectionHeadRowCellIdentifier];
        if (nil == cell)
        {
            cell = [[MCRecipeCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:MCRecommendTableViewSectionHeadRowCellIdentifier];
        }
        @weakify(self);
        [cell.backgroundImageView yy_setImageWithURL:[NSURL URLWithString:self.recommendationList[indexPath.row][kMCSurveyKeyRecipeFirstImageUrl]]
                                         placeholder:nil
                                             options:YYWebImageOptionShowNetworkActivity | YYWebImageOptionProgressiveBlur | YYWebImageOptionSetImageWithFadeAnimation
                                          completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
                                              @strongify(self);
                                              cell.imageTitleLabel.text = self.recommendationList[indexPath.row][kMCSurveyKeyRecipeName];
                                              [cell resizeImageTitle];
                                          }];
        return cell;
    }
    return [[MCRecipeCell alloc] init];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == MCRecommendTableViewSectionHead) {
        MCRecipeViewController *recipeViewController = [[MCRecipeViewController alloc] init];
        recipeViewController.surveyDict = self.recommendationList[indexPath.row];
        [self.navigationController pushViewController:recipeViewController animated:YES];
    }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

@end
