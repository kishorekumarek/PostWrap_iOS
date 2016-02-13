//
//  UIFont+WidthAdditions.m
//  PostWrap
//
//  Created by Kishore Kumar Elanchezhiyan on 2/9/16.
//  Copyright © 2016 Shalini Padmanabhan. All rights reserved.
//

#import "UIFont+WidthAdditions.h"
#define KIdealFontSize 1000

@implementation UIFont (WidthAdditions)

- (UIFont *)fontforWidth:(CGFloat)width String:(NSString *)stringToFit {
   
    CGFloat widthForIdealFontSize = [self widthForIdealFontSizeWithString:stringToFit];
    CGFloat requiredFontSize = KIdealFontSize/widthForIdealFontSize*width;
    
    return [UIFont fontWithName:self.fontName size:requiredFontSize];
}

- (CGFloat)widthForIdealFontSizeWithString:(NSString *)inputString {
    CGRect boundingRect = [inputString boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingTruncatesLastVisibleLine attributes:[NSDictionary dictionaryWithObjects:@[[UIFont fontWithName:self.fontName size:KIdealFontSize]] forKeys:@[NSFontAttributeName]] context:nil];
   return boundingRect.size.width;
}

@end
