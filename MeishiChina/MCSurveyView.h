//
// Created by Zheng on 17/11/2016.
// Copyright (c) 2016 Zheng. All rights reserved.
//

#import "MCView.h"

@class MCSurveyView;

@protocol MCSurveyViewDelegate <NSObject>
- (void)surveyViewDidChanged:(MCSurveyView *)view;
- (void)surveyViewDetailDidTapped:(MCSurveyView *)view;

@end

@interface MCSurveyView : MCView

@property (nonatomic, strong) NSDictionary *surveyDict;
@property (nonatomic, strong) NSDictionary *answerDict;
@property (nonatomic, weak) id <MCSurveyViewDelegate> delegate;
@property (nonatomic, assign) BOOL hasAnswered;

extern NSString * const kMCSurveyKeyRecipeId;
extern NSString * const kMCSurveyKeyRecipeFirstImageUrl;
extern NSString * const kMCSurveyKeyRecipeMaterials;
extern NSString * const kMCSurveyKeyAuthorId;
extern NSString * const kMCSurveyKeyRecipeName;
extern NSString * const kMCSurveyKeyRecipeTags;
extern NSString * const kMCSurveyKeyRecipeTip;
extern NSString * const kMCSurveyKeyRecipeDescription;

extern NSString * const kMCAnswerKeyRecipeRating;

@end