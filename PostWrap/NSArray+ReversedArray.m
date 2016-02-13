//
//  NSArray+ReversedArray.m
//  PostWrap
//
//  Created by Kishore Kumar Elanchezhiyan on 2/14/16.
//  Copyright © 2016 Shalini Padmanabhan. All rights reserved.
//

#import "NSArray+ReversedArray.h"

@implementation NSArray (ReversedArray)
- (NSMutableArray *)reverseArray {
    NSMutableArray *reversedArray = [NSMutableArray array];
    for (int i = (int)self.count-1; i>=0; i--) {
        [reversedArray addObject:self[i]];
    }
    return reversedArray;
}

@end
