//
//  PWAscendingFWObject.m
//  PostWrap
//
//  Created by Kishore Kumar Elanchezhiyan on 2/9/16.
//  Copyright © 2016 Shalini Padmanabhan. All rights reserved.
//

#import "PWAscendingFWObject.h"


@implementation PWAscendingFWObject

- (NSMutableArray *)splitPosterString:(NSString *)posterString {
    NSMutableArray *spaceSplittedArray = [[posterString componentsSeparatedByString:@" "] mutableCopy];
    NSMutableArray *resultsArray = [NSMutableArray array];
    int j;
    int k = 0;
    for (int i = 0;i<spaceSplittedArray.count;i++) {
        NSString *combinedString = nil;
        for (j = i; j <= k+i && j < spaceSplittedArray.count ; j++) {
            if(combinedString)
                combinedString = [NSString stringWithFormat:@"%@ %@",combinedString,spaceSplittedArray[j]];
            else
                combinedString = spaceSplittedArray[j];
            
        }
        i = j-1;
        k++;
        [resultsArray addObject:combinedString];
    }
    return resultsArray;
}
@end
