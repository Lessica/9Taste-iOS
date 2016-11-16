//
// Created by Zheng on 16/11/2016.
// Copyright (c) 2016 Zheng. All rights reserved.
//

#import "MCTextFieldView.h"

@implementation MCTextFieldView

- (void)setup {
    [super setup];

    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.textField];
}

- (MCTextField *)textField {
    if (!_textField)
    {
        MCTextField *textField = [[MCTextField alloc] initWithFrame:self.bounds];
        textField.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _textField = textField;
    }
    return _textField;
}

- (void)drawRect:(CGRect)rect {
    if (self.highlighted)
    {
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        CGContextSetLineCap(ctx, kCGLineCapSquare);
        CGContextSetLineWidth(ctx, 3.0);
        CGContextSetStrokeColorWithColor(ctx,
                [MConfig.appearance.tintColor colorWithAlphaComponent:.4f].CGColor);
        CGContextMoveToPoint(ctx, 0, self.height);
        CGContextAddLineToPoint(ctx, self.width, self.height);
        CGContextStrokePath(ctx);
    } else {
        NSDictionary *placeholderAttributes =
                [self.textField.attributedPlaceholder attributesAtIndex:0 effectiveRange:NULL];
        UIColor *placeholderColor = placeholderAttributes[NSForegroundColorAttributeName];
        if (!placeholderColor) {
            placeholderColor = [UIColor colorWithWhite:.3f alpha:1.f];
        }
        placeholderColor = [placeholderColor colorWithAlphaComponent:.4f];
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        CGContextSetLineCap(ctx, kCGLineCapSquare);
        CGContextSetLineWidth(ctx, 2.0);
        CGContextSetStrokeColorWithColor(ctx, placeholderColor.CGColor);
        CGContextMoveToPoint(ctx, 0, self.height);
        CGContextAddLineToPoint(ctx, self.width, self.height);
        CGContextStrokePath(ctx);
    }
}

#pragma mark - Highlight

- (void)setHighlighted:(BOOL)highlighted {
    _highlighted = highlighted;
    [self setNeedsDisplay];
}

#pragma mark - Animation

- (void)shake {
    UIView *viewToShake = self;
    CGFloat t = 2.0;
    CGAffineTransform translateRight = CGAffineTransformTranslate(CGAffineTransformIdentity, t, 0.0);
    CGAffineTransform translateLeft = CGAffineTransformTranslate(CGAffineTransformIdentity, -t, 0.0);
    
    viewToShake.transform = translateLeft;
    
    [UIView animateWithDuration:0.07 delay:0.0 options:UIViewAnimationOptionAutoreverse | UIViewAnimationOptionRepeat animations:^{
        [UIView setAnimationRepeatCount:2.0];
        viewToShake.transform = translateRight;
    } completion:^(BOOL finished) {
        if (finished) {
            [UIView animateWithDuration:0.05 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                viewToShake.transform = CGAffineTransformIdentity;
            } completion:NULL];
        }
    }];
}

#pragma mark - Verify

- (BOOL)verify {
    if (!self.verifyBlock) {
        return YES;
    }
    NSString *verifyResult = self.verifyBlock(self.textField.text);
    if (verifyResult) {
        self.verifyResult = verifyResult;
        [self shake];
    }
    return (verifyResult == nil);
}

@end
