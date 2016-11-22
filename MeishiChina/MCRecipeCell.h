//
//  MCRecipeCell.h
//  MeishiChina
//
//  Created by Zheng on 17/11/2016.
//  Copyright © 2016 Zheng. All rights reserved.
//

#import "MCTableViewCell.h"
#import "MCLabel.h"

@interface MCRecipeCell : MCTableViewCell
@property (nonatomic, strong) YYAnimatedImageView *backgroundImageView;
@property (nonatomic, strong) MCLabel *imageTitleLabel;

- (void)resizeImageTitle;
@end
