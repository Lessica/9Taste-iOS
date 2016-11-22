//
// Created by Zheng on 17/11/2016.
// Copyright (c) 2016 Zheng. All rights reserved.
//

#import "MCSurveyView.h"
#import "MCLabel.h"
#import "MCTableView.h"
#import "MCInsetsLabel.h"
#import "MCTagCell.h"
#import "MCRateCell.h"
#import "MCTextCell.h"

static CGFloat const kMCSurveyLeftMargin = 5.f;
static CGFloat const kMCSurveyRightMargin = 5.f;

static CGFloat const kMCSurveyTitleLeftMargin = 24.f;
static CGFloat const kMCSurveyTitleRightMargin = 24.f;

NSString * const kMCSurveyKeyRecipeId = @"recipeId";
NSString * const kMCSurveyKeyRecipeFirstImageUrl = @"recipeFirstImageUrl";
NSString * const kMCSurveyKeyRecipeMaterials = @"recipeMaterials";
NSString * const kMCSurveyKeyAuthorId = @"authorId";
NSString * const kMCSurveyKeyRecipeName = @"recipeName";
NSString * const kMCSurveyKeyRecipeTags = @"recipeTags";
NSString * const kMCSurveyKeyRecipeTip = @"recipeTip";
NSString * const kMCSurveyKeyRecipeDescription = @"recipeDescription";

NSString * const kMCAnswerKeyRecipeRating = @"kMCAnswerKeyRecipeRating";

NSUInteger const MCSurveyTableViewSectionNum = 5;
typedef enum : NSUInteger {
    MCSurveyTableViewSectionLink = 0,
    MCSurveyTableViewSectionRate,
    MCSurveyTableViewSectionMaterial,
    MCSurveyTableViewSectionTag,
    MCSurveyTableViewSectionDescription
} MCSurveyTableViewSection;
static NSString * const MCMaterialCellReuseIdentifier = @"MCMaterialCellReuseIdentifier";
static NSString * const MCTagCellReuseIdentifier = @"MCTagCellReuseIdentifier";
static NSString * const MCRateCellReuseIdentifier = @"MCRateCellReuseIdentifier";
static NSString * const MCTextCellReuseIdentifier = @"MCTextCellReuseIdentifier";
static NSString * const MCLinkCellReuseIdentifier = @"MCLinkCellReuseIdentifier";

@interface MCSurveyView () <UITableViewDataSource, UITableViewDelegate, MCRateViewDelegate>

@property (nonatomic, strong) YYAnimatedImageView *imageView;
@property (nonatomic, strong) MCLabel *imageTitleLabel;
@property (nonatomic, strong) MCTableView *tableView;
@property (nonatomic, strong) MCTagCell *materialCell;
@property (nonatomic, strong) MCTagCell *tagCell;
@property (nonatomic, strong) MCRateCell *rateCell;
@property (nonatomic, strong) MCTextCell *textCell;
@property (nonatomic, strong) MCTableViewCell *linkCell;

@end

@implementation MCSurveyView

- (void)setup {
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.backgroundColor = [UIColor whiteColor];
    self.layer.borderColor = MConfig.appearance.surveyBorderColor.CGColor;
    self.layer.borderWidth = 1.f;
    self.layer.masksToBounds = YES;
    
    [self addSubview:self.imageView];
    [self addSubview:self.imageTitleLabel];
    [self addSubview:self.tableView];
}

#pragma mark - UIView Getters

- (YYAnimatedImageView *)imageView {
    if (!_imageView) {
        YYAnimatedImageView *imageView = [[YYAnimatedImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height / 3)];
        imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.hidden = YES;
        imageView.layer.masksToBounds = YES;
        _imageView = imageView;
    }
    return _imageView;
}

- (MCLabel *)imageTitleLabel {
    if (!_imageTitleLabel) {
        MCLabel *imageTitleLabel =
                [[MCLabel alloc] initWithFrame:CGRectMake(0, 0, self.width - kMCSurveyTitleLeftMargin - kMCSurveyTitleRightMargin, 0)];
        imageTitleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        imageTitleLabel.font = MConfig.appearance.surveyTitleFont;
        imageTitleLabel.textAlignment = NSTextAlignmentCenter;
        imageTitleLabel.textColor = [UIColor whiteColor];
        imageTitleLabel.layer.shadowColor = [UIColor blackColor].CGColor;
        imageTitleLabel.layer.shadowOffset = CGSizeMake(4.f, 4.f);
        imageTitleLabel.layer.shadowOpacity = .6f;
        imageTitleLabel.numberOfLines = 0;
        imageTitleLabel.hidden = YES;
        _imageTitleLabel = imageTitleLabel;
    }
    return _imageTitleLabel;
}

- (MCTableView *)tableView {
    if (!_tableView)
    {
        MCTableView *tableView =
                [[MCTableView alloc] initWithFrame:CGRectMake(0, self.height / 3, self.width, self.height / 3 * 2)
                                             style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.hidden = YES;
        tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _tableView = tableView;
    }
    return _tableView;
}

#pragma mark - Load

- (void)setSurveyDict:(NSMutableDictionary *)surveyDict {
    _surveyDict = surveyDict;
    [self reloadSurveyData];
}

- (void)reloadSurveyData {
    @weakify(self);
    [self.imageView yy_setImageWithURL:[NSURL URLWithString:self.surveyDict[kMCSurveyKeyRecipeFirstImageUrl]]
                           placeholder:nil
                               options:YYWebImageOptionShowNetworkActivity | YYWebImageOptionProgressive | YYWebImageOptionSetImageWithFadeAnimation
                            completion:^(UIImage *image, NSURL *url, YYWebImageFromType from, YYWebImageStage stage, NSError *error) {
                                @strongify(self);
                                if (stage == YYWebImageStageFinished) {
                                    [self setNeedsDisplay];
                                    [self resizeImageTitle];
                                }
                            }];
    self.tableView.hidden = NO;
    self.imageView.hidden = NO;
    self.imageTitleLabel.hidden = NO;
    
    [self.materialCell.tagsControl.tags removeAllObjects];
    for (NSString *materialName in self.surveyDict[kMCSurveyKeyRecipeMaterials]) {
        [self.materialCell.tagsControl.tags addObject:materialName];
    }
    [self.materialCell.tagsControl reloadTagSubviews];
    
    [self.tagCell.tagsControl.tags removeAllObjects];
    for (NSString *tagName in self.surveyDict[kMCSurveyKeyRecipeTags]) {
        [self.tagCell.tagsControl.tags addObject:tagName];
    }
    [self.tagCell.tagsControl reloadTagSubviews];
    
    self.textCell.insetsLabel.text = self.surveyDict[kMCSurveyKeyRecipeDescription];
}

- (void)resizeImageTitle {
    self.imageTitleLabel.text = self.surveyDict[kMCSurveyKeyRecipeName];
    CGSize toSize = [self.imageTitleLabel.text boundingRectWithSize:CGSizeMake(self.imageTitleLabel.width, MAXFLOAT)
                                                            options:NSStringDrawingUsesLineFragmentOrigin
                                                         attributes:@{
                                                                 NSFontAttributeName : self.imageTitleLabel.font
                                                         } context:nil].size;
    self.imageTitleLabel.size = toSize;
    self.imageTitleLabel.center = self.imageView.center;
}

- (MCTagCell *)tagCell {
    if (!_tagCell) {
        MCTagCell *tagCell = [[MCTagCell alloc] initWithStyle:UITableViewCellStyleDefault
                                              reuseIdentifier:MCTagCellReuseIdentifier];
        if (self.surveyDict) {
            [tagCell.tagsControl.tags removeAllObjects];
            for (NSString *tagName in self.surveyDict[kMCSurveyKeyRecipeMaterials]) {
                [tagCell.tagsControl.tags addObject:tagName];
            }
            [tagCell.tagsControl reloadTagSubviews];
        }
        _tagCell = tagCell;
    }
    return _tagCell;
}

- (MCTagCell *)materialCell {
    if (!_materialCell) {
        MCTagCell *materialCell = [[MCTagCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                   reuseIdentifier:MCMaterialCellReuseIdentifier];
        if (self.surveyDict) {
            [materialCell.tagsControl.tags removeAllObjects];
            for (NSString *materialName in self.surveyDict[kMCSurveyKeyRecipeMaterials]) {
                [materialCell.tagsControl.tags addObject:materialName];
            }
            [materialCell.tagsControl reloadTagSubviews];
        }
        _materialCell = materialCell;
    }
    return _materialCell;
}

- (MCRateCell *)rateCell {
    if (!_rateCell) {
        MCRateCell *rateCell = [[MCRateCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                 reuseIdentifier:MCRateCellReuseIdentifier];
        rateCell.rateStarView.rateDelegate = self;
        _rateCell = rateCell;
    }
    return _rateCell;
}

- (MCTextCell *)textCell {
    if (!_textCell) {
        MCTextCell *textCell = [[MCTextCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                 reuseIdentifier:MCTextCellReuseIdentifier];
        _textCell = textCell;
    }
    return _textCell;
}

- (MCTableViewCell *)linkCell {
    if (!_linkCell) {
        MCTableViewCell *linkCell = [[MCTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                           reuseIdentifier:MCLinkCellReuseIdentifier];
        linkCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        linkCell.textLabel.textColor = MConfig.appearance.labelTextColor;
        linkCell.textLabel.font = MConfig.appearance.labelTextFont;
        linkCell.textLabel.text = NSLocalizedString(@"View Details", nil);
        _linkCell = linkCell;
    }
    return _linkCell;
}

#pragma mark - Setters

- (void)setHasAnswered:(BOOL)hasAnswered {
    self.rateCell.rateStarView.hasRated = hasAnswered;
}

#pragma mark - Draw

- (void)drawRect:(CGRect)rect {
    if (!self.surveyDict)
    {
        [MConfig.appearance.surveyBorderColor set];
        UIBezierPath *leftPath = [UIBezierPath bezierPath];
        [leftPath moveToPoint:CGPointMake(self.width - kMCSurveyRightMargin - 8.f, self.height / 2 - 6.f)];
        [leftPath addLineToPoint:CGPointMake(self.width - kMCSurveyRightMargin - 8.f, self.height / 2 + 6.f)];
        [leftPath addLineToPoint:CGPointMake(self.width - kMCSurveyRightMargin, self.height / 2)];
        [leftPath closePath];
        [leftPath setLineWidth:1.f];
        [leftPath stroke];
        UIBezierPath *rightPath = [UIBezierPath bezierPath];
        [rightPath moveToPoint:CGPointMake(kMCSurveyLeftMargin + 8.f, self.height / 2 - 6.f)];
        [rightPath addLineToPoint:CGPointMake(kMCSurveyLeftMargin + 8.f, self.height / 2 + 6.f)];
        [rightPath addLineToPoint:CGPointMake(kMCSurveyLeftMargin, self.height / 2)];
        [rightPath closePath];
        [rightPath setLineWidth:1.f];
        [rightPath stroke];
        UIImage *logoImage = [[UIImage imageNamed:@"9Taste"] imageByTintColor:MConfig.appearance.surveyBorderColor];
        [logoImage drawInRect:CGRectMake(self.width / 2 - logoImage.size.width / 2, self.height / 2 - logoImage.size.height / 2, logoImage.size.width, logoImage.size.height)];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == self.tableView) {
        return MCSurveyTableViewSectionNum;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.tableView) {
        return 1;
    }
    return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (tableView == self.tableView) {
        if (section == MCSurveyTableViewSectionRate) {
            return NSLocalizedString(@"Tap To Rate", nil);
        } else if (section == MCSurveyTableViewSectionMaterial) {
            return NSLocalizedString(@"Materials", nil);
        } else if (section == MCSurveyTableViewSectionTag) {
            return NSLocalizedString(@"Tags", nil);
        } else if (section == MCSurveyTableViewSectionDescription) {
            return NSLocalizedString(@"Descriptions", nil);
        } else if (section == MCSurveyTableViewSectionLink) {
            return NSLocalizedString(@"Link", nil);
        }
    }
    return @"";
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    MCInsetsLabel *sectionNameLabel = [[MCInsetsLabel alloc] init];
    sectionNameLabel.text = [self tableView:self.tableView titleForHeaderInSection:section];
    sectionNameLabel.textColor = [UIColor blackColor];
    sectionNameLabel.backgroundColor = [UIColor colorWithWhite:.96f alpha:.9f];
    sectionNameLabel.font = MConfig.appearance.surveySectionHeaderFont;
    sectionNameLabel.edgeInsets = UIEdgeInsetsMake(0, 12.f, 0, 12.f);
    sectionNameLabel.numberOfLines = 1;
    sectionNameLabel.lineBreakMode = NSLineBreakByTruncatingHead;
    [sectionNameLabel sizeToFit];
    return sectionNameLabel;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.tableView) {
        if (indexPath.section == MCSurveyTableViewSectionRate) {
            return 72.f;
        } else if (indexPath.section == MCSurveyTableViewSectionMaterial) {
            return 72.f;
        } else if (indexPath.section == MCSurveyTableViewSectionTag) {
            return 72.f;
        } else if (indexPath.section == MCSurveyTableViewSectionDescription) {
            return 96.f;
        } else if (indexPath.section == MCSurveyTableViewSectionLink) {
            return 44.f;
        }
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.tableView) {
        if (indexPath.section == MCSurveyTableViewSectionRate) {
            return self.rateCell;
        } else if (indexPath.section == MCSurveyTableViewSectionMaterial) {
            return self.materialCell;
        } else if (indexPath.section == MCSurveyTableViewSectionTag) {
            return self.tagCell;
        } else if (indexPath.section == MCSurveyTableViewSectionDescription) {
            return self.textCell;
        } else if (indexPath.section == MCSurveyTableViewSectionLink) {
            return self.linkCell;
        }
    }
    return [UITableViewCell new];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView == self.tableView) {
        if (indexPath.section == MCSurveyTableViewSectionLink) {
            if (_delegate && [_delegate respondsToSelector:@selector(surveyViewDetailDidTapped:)]) {
                [_delegate surveyViewDetailDidTapped:self];
            }
        }
    }
}

#pragma mark - MCRateCellDelegate

- (void)rateViewDidTapped:(MCRateStarView *)view {
    [self.surveyDict setObject:@(view.score - 4) forKey:kMCAnswerKeyRecipeRating];
    if (_delegate && [_delegate respondsToSelector:@selector(surveyViewDidChanged:)]) {
        [_delegate surveyViewDidChanged:self];
    }
}

@end
