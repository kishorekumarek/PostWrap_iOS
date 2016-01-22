//
//  PWTextView.m
//  PostWrap
//
//  Created by Shalini Padmanabhan on 17/12/15.
//  Copyright © 2015 Shalini Padmanabhan. All rights reserved.
//

#import "PWTextView.h"

#import <CoreGraphics/CoreGraphics.h>
#import <QuartzCore/QuartzCore.h>


int fontSizeThatFits;

float oldX, oldY;
BOOL dragging;
BOOL scaling;

CGRect currentTextRect;

@interface PWTextView()

@property(nonatomic,strong) UIView *textView;

@end

CGRect lowerMiddle;
CGRect lowerLeft;
CGRect lowerRight;


UIButton *lowerMiddleButton ;
UIButton *middleRightButton ;
UIButton *middleLeftButton;
UIButton *upperMiddleButton;

UIButton *lowerLeftButton;
UIButton *lowerRightButton;
UIButton *uppperLeftButton;
UIButton *upperRightButton;


@implementation PWTextView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
 //   self.posterText = @"Welcome to PostWrap";
    
        
    CGRect currentTextRect = CGRectMake(50, /* x */ 50, /* y */
                                        self.bounds.size.width - 100, /* width */
                                        self.bounds.size.height - 100);
    
    
    
    [self sizeThatFitsRect:currentTextRect];
    
    NSLog(@"%@ text color in textview",self.random.currentTextColor);
   
    UIFont *helveticaBold = [UIFont fontWithName:self.random.currentFontName
                                            size:fontSizeThatFits];
    //have to fix
    
    [self.posterText drawWithRect:currentTextRect
                          options:NSStringDrawingUsesLineFragmentOrigin
                       attributes:@{
                                    NSFontAttributeName : helveticaBold,
                                    NSForegroundColorAttributeName :self.random.currentTextColor
                                    }
                          context:nil];
    
    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(scalePiece:)];
    [pinchGesture setDelegate:self];
    [self addGestureRecognizer:pinchGesture];
    
    if (self.drawBorder) {
        
        CGContextRef context = UIGraphicsGetCurrentContext();
//        CGContextSetLineWidth(context, 2);
//        CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
//        CGContextStrokeRect(context, currentTextRect);
        
    
        // (1) Draw the bounding box.
        CGContextSetLineWidth(context, 1.0);
        CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
      //  CGContextAddRect(context, CGRectInset(self.bounds, 5.0, 5.0));
      //  CGContextStrokePath(context);
        CGContextStrokeRect(context, currentTextRect);

        
        // (2) Calculate the bounding boxes for each of the anchor points.
        CGRect upperLeft = CGRectMake(currentTextRect.origin.x - 15.0, currentTextRect.origin.y-15.0, 15.0, 15.0);
        uppperLeftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        uppperLeftButton.frame = upperLeft;
        uppperLeftButton.backgroundColor = [UIColor brownColor];
        [self addSubview:uppperLeftButton];
        [uppperLeftButton addTarget:self action:@selector(rectMoved:withEvent:) forControlEvents:UIControlEventTouchDragInside];
        [uppperLeftButton setTitle:@"uppperLeftButton" forState:UIControlStateNormal];
        

        CGRect upperRight = CGRectMake(currentTextRect.size.width + currentTextRect.origin.x, currentTextRect.origin.y - 15.0, 15.0, 15.0);
        upperRightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        upperRightButton.frame = upperRight;
        upperRightButton.backgroundColor = [UIColor brownColor];
        [self addSubview:upperRightButton];
        [upperRightButton addTarget:self action:@selector(rectMoved:withEvent:) forControlEvents:UIControlEventTouchDragInside];
        [upperRightButton setTitle:@"upperRightButton" forState:UIControlStateNormal];
        
       
        
         lowerLeft = CGRectMake(currentTextRect.origin.x - 15.0, currentTextRect.size.height + currentTextRect.origin.y, 15.0, 15.0);
        lowerLeftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        lowerLeftButton.frame = lowerLeft;
        lowerLeftButton.backgroundColor = [UIColor brownColor];
        [self addSubview:lowerLeftButton];
        [lowerLeftButton addTarget:self action:@selector(rectMoved:withEvent:) forControlEvents:UIControlEventTouchDragInside];
        [lowerLeftButton setTitle:@"lowerLeftButton" forState:UIControlStateNormal];

        
        
        
        lowerRight = CGRectMake(currentTextRect.size.width + currentTextRect.origin.x, currentTextRect.size.height + currentTextRect.origin.y, 15.0, 15.0);
        lowerRightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        lowerRightButton.frame = lowerRight;
        lowerRightButton.backgroundColor = [UIColor brownColor];
        [self addSubview:lowerRightButton];
        [lowerRightButton addTarget:self action:@selector(rectMoved:withEvent:) forControlEvents:UIControlEventTouchDragInside];
        [lowerRightButton setTitle:@"lowerRightButton" forState:UIControlStateNormal];

        
        
        
        CGRect upperMiddle = CGRectMake(currentTextRect.origin.x + currentTextRect.size.width/2, currentTextRect.origin.y - 15.0, 15.0, 15.0);
        upperMiddleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        upperMiddleButton.frame = upperMiddle;
        upperMiddleButton.backgroundColor = [UIColor brownColor];
        [self addSubview:upperMiddleButton];
        [upperMiddleButton addTarget:self action:@selector(rectMoved:withEvent:) forControlEvents:UIControlEventTouchDragInside];
        [upperMiddleButton setTitle:@"upperMiddleButton" forState:UIControlStateNormal];

        
        
        lowerMiddle = CGRectMake(currentTextRect.origin.x + currentTextRect.size.width/2, currentTextRect.origin.y + currentTextRect.size.height, 15.0, 15.0);
        
         lowerMiddleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        lowerMiddleButton.frame = lowerMiddle;
        lowerMiddleButton.backgroundColor = [UIColor yellowColor];
        [self addSubview:lowerMiddleButton];
        [lowerMiddleButton addTarget:self action:@selector(rectMoved:withEvent:) forControlEvents:UIControlEventTouchDragInside];
        [lowerMiddleButton setTitle:@"lowerMiddleButton" forState:UIControlStateNormal];

        CGRect middleLeft = CGRectMake(currentTextRect.origin.x - 15.0, currentTextRect.origin.y  + currentTextRect.size.height/2, 15.0, 15.0);
         middleLeftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        middleLeftButton.frame = middleLeft;
        middleLeftButton.backgroundColor = [UIColor redColor];
        [self addSubview:middleLeftButton];
        [middleLeftButton addTarget:self action:@selector(rectMoved:withEvent:) forControlEvents:UIControlEventTouchDragInside];
        [middleLeftButton setTitle:@"middleLeftButton" forState:UIControlStateNormal];

        
        
        CGRect middleRight = CGRectMake(currentTextRect.origin.x+currentTextRect.size.width, currentTextRect.origin.y + currentTextRect.size.height/2, 15.0, 15.0);
        
        middleRightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        middleRightButton.frame = middleRight;
        middleRightButton.backgroundColor = [UIColor greenColor];
        [self addSubview:middleRightButton];
        [middleRightButton addTarget:self action:@selector(rectMoved:withEvent:) forControlEvents:UIControlEventTouchDragInside];
        [middleRightButton setTitle:@"middleRightButton" forState:UIControlStateNormal];
        
        
        
        
        
        // (3) Create the gradient to paint the anchor points.
        CGFloat colors [] = {
            0.4, 0.8, 1.0, 1.0,
            0.0, 0.0, 1.0, 1.0
        };
        CGColorSpaceRef baseSpace = CGColorSpaceCreateDeviceRGB();
        CGGradientRef gradient = CGGradientCreateWithColorComponents(baseSpace, colors, NULL, 2);
        CGColorSpaceRelease(baseSpace), baseSpace = NULL;
        
        // (4) Set up the stroke for drawing the border of each of the anchor points.
        CGContextSetLineWidth(context, 1);
        CGContextSetShadow(context, CGSizeMake(0.5, 0.5), 1);
        CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
        
        // (5) Fill each anchor point using the gradient, then stroke the border.
        CGRect allPoints[8] = { upperLeft, upperRight, lowerRight, lowerLeft, upperMiddle, lowerMiddle, middleLeft, middleRight };
        for (NSInteger i = 0; i < 8; i++) {
            CGRect currPoint = allPoints[i];
            CGContextSaveGState(context);
            CGContextAddEllipseInRect(context, currPoint);
            CGContextClip(context);
            CGPoint startPoint = CGPointMake(CGRectGetMidX(currPoint), CGRectGetMinY(currPoint));
            CGPoint endPoint = CGPointMake(CGRectGetMidX(currPoint), CGRectGetMaxY(currPoint));
            CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
            CGContextRestoreGState(context);
            CGContextStrokeEllipseInRect(context, CGRectInset(currPoint, 1, 1));
        }
        CGGradientRelease(gradient), gradient = NULL;
        
        CGContextRestoreGState(context);
        
        if (scaling)
            
            
            CGContextMoveToPoint(context, lowerMiddleButton.center.x, lowerMiddleButton.center.y);
            CGContextAddLineToPoint(context, lowerLeftButton.center.x, lowerLeftButton.center.y);
            CGContextAddLineToPoint(context, middleLeftButton.center.x, middleLeftButton.center.y);
            CGContextAddLineToPoint(context, uppperLeftButton.center.x, uppperLeftButton.center.y);
            CGContextAddLineToPoint(context, upperMiddleButton.center.x, upperMiddleButton.center.y);
            CGContextAddLineToPoint(context, upperRightButton.center.x, upperRightButton.center.y);
            CGContextAddLineToPoint(context, middleRightButton.center.x, middleRightButton.center.y);
            CGContextAddLineToPoint(context, lowerRightButton.center.x, lowerRightButton.center.y);
        
        
            CGContextStrokePath(context);

    }
    
    
}

-(void)sizeThatFitsRect:(CGRect)rect
{
    
    int minFont = 5;
    int fontSize = 300;
    CGSize constraintSize = CGSizeMake(rect.size.width, MAXFLOAT);
    do {
        UIFont *currentFontApplied = [UIFont fontWithName:self.random.currentFontName
                                                     size:fontSize];
        CGRect textRect = [self.posterText boundingRectWithSize:constraintSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:currentFontApplied} context:nil];
        
        //   NSLog(@"text rect size %f %f %f %f",textRect.origin.x,textRect.origin.y,textRect.size.width,textRect.size.height);
        
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
}


-(void)drawBorderForRect{
    
    CGRect borderRect = CGRectMake(50, /* x */ 50, /* y */
                                        self.bounds.size.width - 100, /* width */
                                        self.bounds.size.height - 100);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self setNeedsDisplay];

    CGContextSetLineWidth(context, 2);
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextStrokeRect(context, borderRect);
    self.drawBorder = NO;
    
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchLocation = [touch locationInView:self];
    
    if (CGRectContainsPoint(self.frame, touchLocation)) {
        
        dragging = YES;
        oldX = touchLocation.x;
        oldY = touchLocation.y;
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchLocation = [touch locationInView:self];
    
    if (dragging) {
        
        CGRect frame = self.frame;
        frame.origin.x = self.frame.origin.x + touchLocation.x - oldX;
        frame.origin.y =  self.frame.origin.y + touchLocation.y - oldY;
        self.frame = frame;
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    dragging = NO;
}

//Mark Anchor Points

-(void)markAnchorPoints{
    
    
}


- (IBAction) rectMoved:(id) sender withEvent:(UIEvent *) event
{
    
    NSLog(@"dfgd");
    
    scaling = YES;
    self.drawBorder = NO;
 //   [self setNeedsDisplay];
 
//    NSLog(@"hitting");
//    
//    
    CGPoint point = [[[event allTouches] anyObject] locationInView:self];
    UIButton *selected = (UIButton *)sender;
    selected.center = point;
    
    
    lowerRightButton.frame = CGRectMake(lowerRightButton.frame.origin.x,CGRectGetMinY(selected.frame),lowerRightButton.frame.size.width, lowerRightButton.frame.size.height);
    
    lowerLeftButton.frame = CGRectMake(lowerLeftButton.frame.origin.x,CGRectGetMinY(selected.frame),lowerLeftButton.frame.size.width, lowerLeftButton.frame.size.height);
    
    
    [self setNeedsDisplay];
    
//
//    //NSString *title=[sender currentTitle];
//    
// //  UIGraphicsBeginImageContext(self.frame.size);
//    
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
//  //  [self setNeedsDisplay];
//    CGContextSetLineCap(ctx, kCGLineCapRound);
//    CGContextSetLineWidth(ctx, 3.0);
//    
//    
//    CGContextSetStrokeColorWithColor(ctx, [UIColor orangeColor].CGColor);
////    CGContextSetRGBStrokeColor(ctx, 1, 0, 0, 1 );
//    CGContextBeginPath(ctx);
//    
//    NSLog(@"button center %f %f",lowerMiddleButton.center.x,lowerMiddleButton.center.y);
//    CGContextMoveToPoint(ctx, lowerMiddleButton.center.x, lowerMiddleButton.center.y);
//    CGContextAddLineToPoint(ctx, middleLeftButton.center.x, middleLeftButton.center.y);
//    CGContextAddLineToPoint(ctx, middleRightButton.center.x, middleRightButton.center.y);
//    CGContextAddLineToPoint(ctx, upperMiddleButton.center.x, upperMiddleButton.center.y);
//
//    
//    
//    CGContextStrokePath(ctx);
}

//    ownImgview.image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();

@end
