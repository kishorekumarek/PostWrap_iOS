//
//  PWFitWidthAlgoObject.h
//  PostWrap
//
//  Created by Kishore Kumar Elanchezhiyan on 2/9/16.
//  Copyright © 2016 Shalini Padmanabhan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UIFont+WidthAdditions.h"
#import "NSString+BoundingRect.h"

@protocol PosterDrawingDelegate <NSObject>

@optional
- (void)scaleContextWithRatio:(CGFloat)scaleRatio;
- (void)drawString:(NSString *)string inRect:(CGRect)rect font:(UIFont *)font;

@end

@interface PWFitWidthAlgoObject : NSObject

@property (nonatomic, strong) NSString *textToFit;
@property (nonatomic) CGRect fitRect;
@property (nonatomic, strong) NSMutableAttributedString *resultString;
@property (nonatomic, weak) id<PosterDrawingDelegate> drawingDelegate;

- (instancetype)initWithText:(NSString *)textToFit fitRect:(CGRect)fitRect;

- (NSMutableArray *)splitPosterString:(NSString *)posterString;
- (NSMutableDictionary *)fontDictForStringArray:(NSArray *)splittedStringArray currentFont:(UIFont *)currentFontApplied desireRect:(CGRect)rect maxY:(CGFloat *)maxY;
- (void)drawStringArray:(NSArray *)splittedStringArray  maxYoFString:(CGFloat)maxY rect:(CGRect)rect fontsDict:(NSMutableDictionary *)fontsDict;
@end
