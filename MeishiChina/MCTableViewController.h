//
// Created by Zheng on 15/11/2016.
// Copyright (c) 2016 Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCTableView.h"

@interface MCTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
/*
 * Why XIB based here?
 * You will find it is strange if you create a UITableView via code.
 * Cells inside that UITableView will not be auto-layout properly as those inside XIBs.
 */
@property (nonatomic, weak) IBOutlet MCTableView *tableView;

- (instancetype)initWithStyle:(UITableViewStyle)style;
- (void)setup;

@end
