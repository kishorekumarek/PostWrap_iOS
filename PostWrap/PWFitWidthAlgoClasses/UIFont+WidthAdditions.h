//
//  UIFont+WidthAdditions.h
//  PostWrap
//
//  Created by Kishore Kumar Elanchezhiyan on 2/9/16.
//  Copyright © 2016 Shalini Padmanabhan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (WidthAdditions)

- (UIFont *)fontforWidth:(CGFloat)width String:(NSString *)stringToFit;

@end
