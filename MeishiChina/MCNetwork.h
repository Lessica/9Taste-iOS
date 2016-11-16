//
// Created by Zheng on 16/11/2016.
// Copyright (c) 2016 Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCNetwork : NSObject

@property (nonatomic, strong, readonly) NSURL *apiURL;
@property (nonatomic, strong) NSDictionary *userState;

extern NSString * const MCNetworkUserStateKeyUserID;
extern NSString * const MCNetworkUserStateKeyUserName;

extern NSString * const MCNetworkNotificationUserStateChanged;
extern NSString * const MCNetworkNotificationUserInfoKeyUserState;

- (instancetype)initWithURL:(NSURL *)url;
- (NSDictionary *)sendSynchronousRequest:(NSDictionary *)jsonDictionary
                                   error:(NSError **)error;

@end
