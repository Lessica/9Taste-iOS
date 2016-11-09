//
//  MCCellAvatar.h
//  MeishiChina
//
//  Created by Zheng on 08/11/2016.
//  Copyright © 2016 Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MCCellAvatar;

@protocol MCCellAvatarDelegate <NSObject>
- (void)avatarDidTapped:(MCCellAvatar *)avatar;

@end

@interface MCCellAvatar : UIImageView
@property (nonatomic, weak) id<MCCellAvatarDelegate> delegate;

- (void)setHidesImageMaskView:(BOOL)hides;
@end
