//
// Created by Zheng on 21/11/2016.
// Copyright (c) 2016 Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

#undef mc_weak
#if __has_feature(objc_arc_weak)
#define mc_weak weak
#else
#define mc_weak unsafe_unretained
#endif

extern const float MCInitialProgressValue;
extern const float MCInteractiveProgressValue;
extern const float MCFinalProgressValue;

typedef void (^MCWebViewProgressBlock)(float progress);
@protocol MCWebViewProgressDelegate;
@interface MCWebViewProgress : NSObject<UIWebViewDelegate>
@property (nonatomic, mc_weak) id<MCWebViewProgressDelegate>progressDelegate;
@property (nonatomic, mc_weak) id<UIWebViewDelegate>webViewProxyDelegate;
@property (nonatomic, copy) MCWebViewProgressBlock progressBlock;
@property (nonatomic, readonly) float progress; // 0.0..1.0

- (void)reset;
@end

@protocol MCWebViewProgressDelegate <NSObject>
- (void)webViewProgress:(MCWebViewProgress *)webViewProgress updateProgress:(float)progress;
@end
