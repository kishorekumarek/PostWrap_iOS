//
//  StringDrawer.m
//  PostWrap
//
//  Created by Shalini Padmanabhan on 15/12/15.
//  Copyright © 2015 Shalini Padmanabhan. All rights reserved.
//

#import "StringDrawer.h"

@interface StringDrawer()
@property (nonatomic, copy) NSAttributedString* text;
@end

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


@implementation StringDrawer

- (instancetype) initWithFrame: (CGRect) frame {
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor yellowColor];
    return self;
}

- (void) draw: (NSAttributedString*) text {
    self.text = text;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    [self.text drawInRect:rect];
}

@end


