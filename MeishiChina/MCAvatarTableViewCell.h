//
//  MCAvatarTableViewCell.h
//  MeishiChina
//
//  Created by Zheng on 08/11/2016.
//  Copyright © 2016 Zheng. All rights reserved.
//

#import "MCTableViewCell.h"
#import "MCCellAvatar.h"

@interface MCAvatarTableViewCell : MCTableViewCell

@property (nonatomic, strong) NSURL *avatarImageUrl; // Transfer
@property (nonatomic, weak) id<MCCellAvatarDelegate> avatarDelegate; // Transfer
@property (nonatomic, strong) NSString *userNameText; // Transfer
@property (nonatomic, strong) NSString *userEmailText; // Transfer

@end
