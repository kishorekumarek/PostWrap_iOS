//
//  PWEditView.m
//  PostWrap
//
//  Created by Murali Krishnan Govindarajulu on 12/12/15.
//  Copyright © 2015 Shalini Padmanabhan. All rights reserved.
//

#import "PWEditView.h"
#import <CoreGraphics/CoreGraphics.h>
#import <QuartzCore/QuartzCore.h>
#import "PWTextView.h"

//int fontSizeThatFits;
//
//float oldX, oldY;
//BOOL dragging;

//CGRect currentTextRect;

@interface PWEditView()

@property(nonatomic,strong) PWTextView *textView;

@end

@implementation PWEditView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

//-(id)init{
//    
////    self = [super init];
////    
////    NSLog(@"%@ text color",self.randomObject.currentTextColor);
////    
////    if (self) {
////        CGRect currentTextRect = CGRectMake(50, /* x */ 50, /* y */
////                                            self.bounds.size.width - 100, /* width */
////                                            self.bounds.size.height - 100);
////        
////        
////        self.textView = [[PWTextView alloc]initWithFrame:currentTextRect];
////        
////        [self addSubview:self.textView];
////    }
////    
////    return self;
//    
//}

- (void)drawRect:(CGRect)rect {
    
    NSLog(@"%@ text color in editview",self.randomObject.currentTextColor);

    
    CGRect currentTextRect = CGRectMake(50, /* x */ 50, /* y */
                                        self.bounds.size.width - 100, /* width */
                                        self.bounds.size.height - 100);

    
    if (self.textView) {
        [self.textView removeFromSuperview];
    }
    self.textView = [[PWTextView alloc]initWithFrame:currentTextRect];
    
    self.textView.random = self.randomObject;
    self.textView.drawBorder = self.drawBorder;
    self.textView.posterText = self.posterText;

    static int i = 0;
    i++;
    if(i % 5 == 0) {
        [self.textView createAscAlgoObject];

    }else if (i % 4 == 0) {
        [self.textView createDescAlgoObject];

    }else if (i % 3 == 0) {
        [self.textView createAscAndDescCombinedObject];
    }else {
        [self.textView createUniformFontAlgoObject];

    }
    self.textView.backgroundColor = [UIColor clearColor];
    
    [self addSubview:self.textView];
    
//
//
//    
//    [self sizeThatFitsRect:currentTextRect];
//    UIFont *helveticaBold = [UIFont fontWithName:self.randomObject.currentFontName
//                                            size:fontSizeThatFits];
//    
//    [self.posterText drawWithRect:currentTextRect
//                   options:NSStringDrawingUsesLineFragmentOrigin
//                attributes:@{
//                             NSFontAttributeName : helveticaBold,
//                             NSForegroundColorAttributeName : self.randomObject.currentTextColor
//                             }
//                   context:nil];
//    
//    if (self.drawBorder) {
//        CGContextRef context = UIGraphicsGetCurrentContext();
//      CGContextSetLineWidth(context, 2);
//        CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
//        CGContextStrokeRect(context, currentTextRect);
//    }

}

//-(void)sizeThatFitsRect:(CGRect)rect
//{
//
//    int minFont = 5;
//    int fontSize = 300;
//    CGSize constraintSize = CGSizeMake(rect.size.width, MAXFLOAT);
//    do {
//        UIFont *currentFontApplied = [UIFont fontWithName:self.randomObject.currentFontName
//                                        size:fontSize];
//       CGRect textRect = [self.posterText boundingRectWithSize:constraintSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:currentFontApplied} context:nil];
//       
//     //   NSLog(@"text rect size %f %f %f %f",textRect.origin.x,textRect.origin.y,textRect.size.width,textRect.size.height);
//        
//        CGSize labelSize = textRect.size;
//        if (labelSize.height <= rect.size.height) {
//            break;
//        }
//        else
//        {
//            fontSize -= 2;
//        }
//        fontSizeThatFits = fontSize;
//    } while (fontSize>minFont);
//}
//
//
//-(void)drawBorderForRect{
//    
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetLineWidth(context, 2);
//    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
//    CGContextStrokeRect(context, currentTextRect);
//    
//}
//
//
//-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    
//    [self.textView setBackgroundColor:[UIColor redColor]];
//    NSLog(@"touches began");
//
//    UITouch *touch = [[event allTouches] anyObject];
//    CGPoint location = [touch locationInView:self];
//    
//    self.center = location;
//   // cloud.center = location;
//}
//
//-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
//    [self touchesBegan:touches withEvent:event];
//}

@end
