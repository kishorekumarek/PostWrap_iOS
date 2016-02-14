//
//  NSString+BoundingRect.m
//  PostWrap
//
//  Created by Kishore Kumar Elanchezhiyan on 2/9/16.
//  Copyright © 2016 Shalini Padmanabhan. All rights reserved.
//

#import "NSString+BoundingRect.h"

@implementation NSString (BoundingRect)

- (CGFloat)heightForFont:(UIFont *)font {
    CGRect boundingRect = [self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjects:@[font] forKeys:@[NSFontAttributeName]] context:nil];
    return boundingRect.size.height;
}

@end
