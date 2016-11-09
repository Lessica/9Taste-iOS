//
//  MCAvatarTableViewCell.h
//  MeishiChina
//
//  Created by Zheng on 08/11/2016.
//  Copyright © 2016 Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCCellAvatar.h"

@interface MCAvatarTableViewCell : UITableViewCell
@property (nonatomic, strong) NSURL *avatarImageUrl;
@property (nonatomic, weak) id<MCCellAvatarDelegate> avatarDelegate;

@property (nonatomic, strong) NSString *userNameText;
@property (nonatomic, strong) NSString *userEmailText;

@end
