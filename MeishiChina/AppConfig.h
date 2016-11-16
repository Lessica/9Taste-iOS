//
//  AppConfig.h
//  MeishiChina
//
//  Created by Zheng on 06/11/2016.
//  Copyright © 2016 Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYCache/YYCache.h>
#import "MCAppearance.h"
#import "MCNetwork.h"

@interface AppConfig : NSObject

@property (nonatomic, strong, readonly) YYCache *storage;
@property (nonatomic, strong, readonly) MCAppearance *appearance;
@property (nonatomic, strong, readonly) MCNetwork *networkService;

extern NSString * const MConfigStorageAppearanceKey;
extern NSString * const MConfigStorageApiUrlKey;
extern NSString * const MConfigStorageUserStateKey;

+ (instancetype)sharedInstance;

@end
