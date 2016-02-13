//
//  PWUniformFontObject.m
//  PostWrap
//
//  Created by Kishore Kumar Elanchezhiyan on 2/14/16.
//  Copyright © 2016 Shalini Padmanabhan. All rights reserved.
//

#import "PWUniformFontObject.h"

@implementation PWUniformFontObject

- (NSMutableArray *)splitPosterString:(NSString *)posterString {
    return [NSMutableArray arrayWithObject:posterString];
}
- (NSMutableDictionary *)fontDictForStringArray:(NSArray *)splittedStringArray currentFont:(UIFont *)currentFontApplied desireRect:(CGRect)rect maxY:(CGFloat *)maxY {
    NSString *posterString = splittedStringArray[0];
    int minFont = 5;
    int fontSize = 300;
    CGFloat fontSizeThatFits = 0.0;
    CGSize constraintSize = CGSizeMake(rect.size.width, MAXFLOAT);
    do {
        UIFont *currentFont = [UIFont fontWithName:currentFontApplied.fontName
                                                     size:fontSize];
        CGRect textRect = [posterString boundingRectWithSize:constraintSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:currentFont} context:nil];
        CGSize labelSize = textRect.size;
        if (labelSize.height <= rect.size.height) {
            break;
        }
        else
        {
            fontSize -= 2;
        }
        fontSizeThatFits = fontSize;
    } while (fontSize>minFont);
    *maxY = CGRectGetMaxY(rect);
    return [NSMutableDictionary dictionaryWithObject:[UIFont fontWithName:currentFontApplied.fontName size:fontSizeThatFits] forKey:posterString];
}
@end
