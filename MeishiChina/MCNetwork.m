//
// Created by Zheng on 16/11/2016.
// Copyright (c) 2016 Zheng. All rights reserved.
//

#import "MCNetwork.h"

NSString * const MCNetworkUserStateKeyUserID = @"MCNetworkUserStateKeyUserID";
NSString * const MCNetworkUserStateKeyUserName = @"MCNetworkUserStateKeyUserName";

NSString * const MCNetworkNotificationUserStateChanged = @"MCNetworkNotificationUserStateChanged";
NSString * const MCNetworkNotificationUserInfoKeyUserState = @"MCNetworkNotificationUserInfoKeyUserState";

@implementation MCNetwork

- (instancetype)initWithURL:(NSURL *)url {
    if (self = [super init]) {
        _apiURL = url;
    }
    return self;
}

- (NSDictionary *)sendSynchronousRequest:(NSDictionary *)jsonDictionary
                                   error:(NSError **)error
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:_apiURL
                                                                cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                            timeoutInterval:10.f];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    if (jsonDictionary)
    {
        [request setHTTPBody:[[jsonDictionary jsonStringEncoded] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:error];
    if (error != nil && *error != nil) {
        return nil;
    }
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:received options:0 error:error];
    if (error != nil && *error != nil) {
        return nil;
    }
    return result;
}

#pragma mark - User State

- (NSDictionary *)userState {
    return (NSDictionary *)[MConfig.storage objectForKey:MConfigStorageUserStateKey];
}

- (void)setUserState:(NSDictionary *)userState {
    [MConfig.storage setObject:userState forKey:MConfigStorageUserStateKey];
    NSDictionary *userInfo = nil;
    if (userState) {
        userInfo = @{
                     MCNetworkNotificationUserInfoKeyUserState: userState,
                     };
    } else {
        userInfo = @{};
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:MCNetworkNotificationUserStateChanged
                                                        object:nil
                                                      userInfo:userInfo];
}

@end
