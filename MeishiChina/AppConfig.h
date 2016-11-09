//
//  AppConfig.h
//  MeishiChina
//
//  Created by Zheng on 06/11/2016.
//  Copyright © 2016 Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCAppearance.h"

@interface AppConfig : NSObject
@property (nonatomic, strong, readonly) MCAppearance *appearance;
+ (instancetype)sharedInstance;

@end
