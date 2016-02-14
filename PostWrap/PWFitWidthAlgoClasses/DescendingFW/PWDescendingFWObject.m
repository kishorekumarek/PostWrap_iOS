//
//  PWDescendingFWObject.m
//  PostWrap
//
//  Created by Kishore Kumar Elanchezhiyan on 2/14/16.
//  Copyright © 2016 Shalini Padmanabhan. All rights reserved.
//

#import "PWDescendingFWObject.h"
#import "NSArray+ReversedArray.h"
@implementation PWDescendingFWObject
- (NSMutableArray *)splitPosterString:(NSString *)posterString {
    NSMutableArray *spaceSplittedArray = [[posterString componentsSeparatedByString:@" "] mutableCopy];
    spaceSplittedArray = [spaceSplittedArray reverseArray];
    NSMutableArray *resultsArray = [NSMutableArray array];
    int j;
    int k = 0;
    for (int i = 0;i<spaceSplittedArray.count;i++) {
        NSString *combinedString = nil;
        for (j = i; j <= k+i && j < spaceSplittedArray.count ; j++) {
            if(combinedString)
                combinedString = [NSString stringWithFormat:@"%@ %@",spaceSplittedArray[j],combinedString];
            else
                combinedString = spaceSplittedArray[j];
            
        }
        i = j-1;
        k++;
        [resultsArray addObject:combinedString];
    }
    resultsArray = [resultsArray reverseArray];
    return resultsArray;
}
@end
