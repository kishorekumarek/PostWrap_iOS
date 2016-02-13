//
//  PWFitWidthAlgoObject.m
//  PostWrap
//
//  Created by Kishore Kumar Elanchezhiyan on 2/9/16.
//  Copyright © 2016 Shalini Padmanabhan. All rights reserved.
//

#import "PWFitWidthAlgoObject.h"

@implementation PWFitWidthAlgoObject

- (instancetype)initWithText:(NSString *)textToFit fitRect:(CGRect)fitRect {
    self = [super init];
    
    self.textToFit = textToFit;
    self.fitRect = fitRect;
    
    return self;
}
- (void)processSplittedArray:(NSArray *)splittedArray {
//    int noOfLines = splittedArray.count;
    
}
- (NSMutableDictionary *)fontDictForStringArray:(NSArray *)splittedStringArray currentFont:(UIFont *)currentFontApplied desireRect:(CGRect)rect maxY:(CGFloat *)maxY {
    
    NSMutableDictionary *fontsDict = [NSMutableDictionary dictionary];
    CGFloat heightForString = 0.0;
    for (int i = 0; i < splittedStringArray.count; i++) {
        NSString *string =  splittedStringArray[i];
        CGFloat fontSizeThatFits = [currentFontApplied fontforWidth:rect.size.width String:string].pointSize;
        UIFont *font = [UIFont fontWithName:currentFontApplied.fontName
                                       size:fontSizeThatFits];
        [fontsDict setObject:font forKey:string];
        heightForString =  [string heightForFont:font];
        *maxY += heightForString;
    }
    return fontsDict;
}
- (void)drawStringArray:(NSArray *)splittedStringArray  maxYoFString:(CGFloat)maxY rect:(CGRect)rect fontsDict:(NSMutableDictionary *)fontsDict {
    if(maxY > CGRectGetHeight(rect))
        [self.drawingDelegate scaleContextWithRatio:CGRectGetHeight(rect)/maxY];
    CGRect drawRect = rect;
    CGFloat heightForString = 0.0;
    for (int i = 0; i < splittedStringArray.count; i++) {
        NSString *string =  splittedStringArray[i];
        UIFont *font = [fontsDict objectForKey:string];
        heightForString =  [string heightForFont:font];
        [self.drawingDelegate drawString:string inRect:drawRect font:font];
        drawRect.origin.y += heightForString;
    }
    
}


@end
