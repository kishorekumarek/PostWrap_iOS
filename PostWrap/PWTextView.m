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
#import "UIFont+WidthAdditions.h"
#import "PWAscendingFWObject.h"
#import "PWDescendingFWObject.h"
#import "PWAscAndDescCombinedFWObject.h"
#import "NSString+BoundingRect.h"
#import "PWUniformFontObject.h"
int fontSizeThatFits;

float oldX, oldY;
BOOL dragging;
BOOL scaling;

CGRect currentTextRect;

@interface PWTextView()

@property(nonatomic,strong) UIView *textView;
@property (nonatomic,strong) PWFitWidthAlgoObject *fitWidthObject;

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

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
   
    self.layer.borderWidth = 1.0;
    self.layer.borderColor = [UIColor yellowColor].CGColor;
    
    return self;
}
-(void)createAscAlgoObject {
    self.fitWidthObject = [[PWAscendingFWObject alloc] initWithText:self.posterText fitRect:self.frame];
    [self.fitWidthObject setDrawingDelegate:self];
}
-(void)createDescAlgoObject {
    self.fitWidthObject = [[PWDescendingFWObject alloc] initWithText:self.posterText fitRect:self.frame];
    [self.fitWidthObject setDrawingDelegate:self];
}
- (void)createAscAndDescCombinedObject {
    self.fitWidthObject = [[PWAscAndDescCombinedFWObject alloc] initWithText:self.posterText fitRect:self.frame];
    [self.fitWidthObject setDrawingDelegate:self];
}
- (void)createUniformFontAlgoObject {
    self.fitWidthObject = [[PWUniformFontObject alloc] initWithText:self.posterText fitRect:self.frame];
    [self.fitWidthObject setDrawingDelegate:self];
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    UIFont *currentFontApplied = [UIFont fontWithName:self.random.currentFontName size:12];
    NSMutableArray *splittedStringArray = [self.fitWidthObject splitPosterString:self.posterText];
    CGRect drawRect = rect;
    CGFloat maxY = CGRectGetMinY(drawRect) ;
    NSMutableDictionary *fontsDict = [self.fitWidthObject fontDictForStringArray:splittedStringArray currentFont:currentFontApplied desireRect:drawRect maxY:&maxY];
    [self.fitWidthObject drawStringArray:splittedStringArray maxYoFString:maxY rect:rect fontsDict:fontsDict];
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

#pragma mark - Poster Drawing Delegate Methods
- (void)scaleContextWithRatio:(CGFloat)scaleRatio {
    CGContextScaleCTM(UIGraphicsGetCurrentContext(), scaleRatio, scaleRatio);
}
- (void)drawString:(NSString *)string inRect:(CGRect)rect font:(UIFont *)font {
       [string drawWithRect:rect
                 options:NSStringDrawingUsesLineFragmentOrigin
              attributes:@{
                           NSFontAttributeName : font,
                           NSForegroundColorAttributeName :self.random.currentTextColor,
                           }
                 context:nil];
   
}
//    ownImgview.image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();

@end
