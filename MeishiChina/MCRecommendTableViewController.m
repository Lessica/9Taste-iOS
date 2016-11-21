//
//  MCRecommendTableViewController.m
//  MeishiChina
//
//  Created by Zheng on 06/11/2016.
//  Copyright © 2016 Zheng. All rights reserved.
//

#import "MCRecommendTableViewController.h"
#import "MCRefreshControl.h"
#import "MCRecipeCell.h"

static const NSInteger MCRecommendTableViewSectionNum = 1;
typedef enum : NSUInteger {
    MCRecommendTableViewSectionHead = 0,
} MCRecommendTableViewSection;
static NSString * const MCRecommendTableViewSectionHeadRowCellIdentifier = @"MCRecommendTableViewSectionHeadRowCellIdentifier";
static CGFloat const MCRecommendTableViewSectionHeadRowCellHeight = 144.f;

@interface MCRecommendTableViewController ()

@property (nonatomic, strong) MCRefreshControl *refreshControl;

@end

@implementation MCRecommendTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.navigationController.navigationBar setTranslucent:NO];
    
    self.title = NSLocalizedString(@"Recommend", nil);
    [self refreshControl];
}

#pragma mark - MJRefresh Header

- (MCRefreshControl *)refreshControl {
    if (!_refreshControl) {
        MCRefreshControl *refreshControl = [[MCRefreshControl alloc] initInScrollView:self.tableView];
        [refreshControl addTarget:self action:@selector(startRefreshing) forControlEvents:UIControlEventValueChanged];
        refreshControl.tintColor = MConfig.appearance.headerStateColor;
        refreshControl.activityIndicatorViewColor = MConfig.appearance.headerStateColor;
        refreshControl.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        _refreshControl = refreshControl;
    }
    return _refreshControl;
}

- (void)startRefreshing {
    [self performSelector:@selector(endRefreshing) withObject:nil afterDelay:3.f];
}

- (void)endRefreshing {
    [self.refreshControl endRefreshing];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return MCRecommendTableViewSectionNum;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
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
        return cell;
    }
    return [[MCRecipeCell alloc] init];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

#pragma mark - Load

- (void)loadRecipe {
    
}

@end
