//
// Created by Zheng on 15/11/2016.
// Copyright (c) 2016 Zheng. All rights reserved.
//

#import "MCTableViewController.h"
#import "MCTableView.h"

@interface MCTableViewController ()

@property (nonatomic, assign) UITableViewStyle tableViewStyle;

@end

@implementation MCTableViewController

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (instancetype)init
{
    if (self = [super init])
    {
        [self setup];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
    if (self = [super init]) {
        self.tableViewStyle = style;
        [self setup];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.tableViewStyle == UITableViewStylePlain) {
        [[NSBundle mainBundle] loadNibNamed:@"MCTableViewPlain" owner:self options:nil];
    } else if (self.tableViewStyle == UITableViewStyleGrouped) {
        [[NSBundle mainBundle] loadNibNamed:@"MCTableViewGrouped" owner:self options:nil];
    }
    self.tableView.frame = self.view.bounds;
    [self.view addSubview:self.tableView];
}

- (void)setup {

}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UITableViewCell new];
}

@end
