//
//  MCTagsControl.h
//  TagsInputSample
//
//  Created by Антон Кузнецов on 11.02.15.
//  Copyright (c) 2015 TheLightPrjg. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MCTagsControl;

@protocol MCTagsControlDelegate <NSObject>

- (void)tagsControl:(MCTagsControl *)tagsControl tappedAtIndex:(NSInteger)index;

@end

typedef NS_ENUM(NSUInteger, MCTagsControlMode) {
    MCTagsControlModeEdit,
    MCTagsControlModeList,
};

@interface MCTagsControl : UIScrollView

@property (nonatomic, strong) NSMutableArray *tags;
@property (nonatomic, strong) UIColor *tagsBackgroundColor;
@property (nonatomic, strong) UIColor *tagsTextColor;
@property (nonatomic, strong) UIColor *tagsDeleteButtonColor;
@property (nonatomic, strong) NSString *tagPlaceholder;
@property (nonatomic) MCTagsControlMode mode;

@property (assign, nonatomic) id<MCTagsControlDelegate> tapDelegate;

- (id)initWithFrame:(CGRect)frame andTags:(NSArray *)tags withTagsControlMode:(MCTagsControlMode)mode;

- (void)addTag:(NSString *)tag;
- (void)reloadTagSubviews;

@end