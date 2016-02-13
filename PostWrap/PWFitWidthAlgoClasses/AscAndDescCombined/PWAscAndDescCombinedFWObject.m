//
//  PWAscAndDescCombinedFWObject.m
//  PostWrap
//
//  Created by Kishore Kumar Elanchezhiyan on 2/14/16.
//  Copyright © 2016 Shalini Padmanabhan. All rights reserved.
//

#import "PWAscAndDescCombinedFWObject.h"
#import "PWAscendingFWObject.h"
#import "PWDescendingFWObject.h"

@interface PWAscAndDescCombinedFWObject()

@property (nonatomic, strong) PWAscendingFWObject *ascAlgoObject;
@property (nonatomic, strong) PWDescendingFWObject *descAlgoObject;

@end

@implementation PWAscAndDescCombinedFWObject

-(instancetype)initWithText:(NSString *)textToFit fitRect:(CGRect)fitRect {
    
    self = [super initWithText:textToFit fitRect:fitRect];
    self.ascAlgoObject = [[PWAscendingFWObject alloc] initWithText:textToFit fitRect:fitRect];
    self.descAlgoObject = [[PWDescendingFWObject alloc] initWithText:textToFit fitRect:fitRect];
    return self;
    
}
- (NSMutableArray *)splitPosterString:(NSString *)posterString {
    NSMutableArray *spaceSplittedArray = [[posterString componentsSeparatedByString:@" "] mutableCopy];
    
    int ascLastIndex = (int)spaceSplittedArray.count/2 ;
    NSArray *ascArray = [spaceSplittedArray subarrayWithRange:NSMakeRange(0, ascLastIndex)];
    NSArray *descArray = [spaceSplittedArray subarrayWithRange:NSMakeRange(ascLastIndex, spaceSplittedArray.count - ascLastIndex)];
    NSArray *ascResultArray = [self.ascAlgoObject splitPosterString:[ascArray componentsJoinedByString:@" "]];
    NSArray *descResultArray = [self.descAlgoObject splitPosterString:[descArray componentsJoinedByString:@" "]];
    
    NSArray *resultArray = [ascResultArray arrayByAddingObjectsFromArray:descResultArray];
    return [resultArray mutableCopy];
}
@end
