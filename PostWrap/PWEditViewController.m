//
//  PWEditViewController.m
//  PostWrap
//
//  Created by Shalini Padmanabhan on 27/11/15.
//  Copyright © 2015 Shalini Padmanabhan. All rights reserved.
//

#import "PWEditViewController.h"
#import <CoreGraphics/CoreGraphics.h>
#import <CoreText/CoreText.h>
#import "PWEditView.h"
#import "Randomness.h"
#import "PWTextView.h"
#define ARC4RANDOM_MAX      0x100000000

@interface PWEditViewController ()



@property (nonatomic,strong) IBOutlet UIImageView *bgImageView;
@property (nonatomic,strong) IBOutlet UILabel *textLabel;
@property (nonatomic,strong) IBOutlet UIScrollView *posterScrollView;
@property (nonatomic,strong) IBOutlet PWEditView *containerView;
@property (nonatomic,strong) PWTextView *textView;
@property (nonatomic,strong) IBOutlet UIPageControl *pageControl;

@property (nonatomic,strong) NSString *string;
@property (nonatomic,strong) NSMutableArray *tenArray;
@property (nonatomic,strong) NSMutableArray *fontArray;
@property (nonatomic,assign) int swipeCounter;
@property (nonatomic,assign) int currentIndex;

@property (nonatomic,strong)  UISwipeGestureRecognizer *leftGesturerecognizer;
@property (nonatomic,strong)  UISwipeGestureRecognizer *rightGesturerecognizer;

@end

@implementation PWEditViewController

//static int SwipeCounter;

//NSUInteger currentIndex;

-(id)initWithTextArray:(NSMutableArray *)textArray andImage:(UIImage *)image{
    
    self = [super init];

//    if (self) {
//        
        self.textArray = [NSMutableArray arrayWithArray:textArray];
        self.bgImage = image;
    self.tenArray = [[NSMutableArray alloc]init];
//
    
//    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
 //   self.containerView = [[PWEditView alloc]init];
    
    self.string =  @"Welcome to PostWrap";
    [self createFontArray];
    self.tenArray = [[NSMutableArray alloc]init];
    Randomness *firstObj = [self addNewRandomObject];
    
    [self.tenArray addObject:firstObj];
    self.textView.random = firstObj;

    self.containerView.randomObject=firstObj;
    self.swipeCounter=0;
    self.currentIndex=0;
    
    self.containerView.backgroundColor = self.containerView.randomObject.currentColor;
    self.containerView.posterText = self.textArray[0];

    [self addGestureToView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addGestureToView
{
    self.leftGesturerecognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(changeBG:)];
    [self.containerView addGestureRecognizer:self.leftGesturerecognizer];
    self.leftGesturerecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    self.leftGesturerecognizer.delegate = self;
    self.containerView.userInteractionEnabled=YES;
    
     self.rightGesturerecognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(moveBackward:)];
    [self.containerView addGestureRecognizer:self.rightGesturerecognizer];
    self.rightGesturerecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    self.rightGesturerecognizer.delegate = self;

}

-(void)changeBG:(UISwipeGestureRecognizer *)leftSwipeGestureRecognizer{

        if (self.swipeCounter==self.currentIndex)
        {
            if (self.tenArray.count == 10) {
                
                [self.tenArray removeObjectAtIndex:0];
                [self.tenArray addObject:[self addNewRandomObject]];
                
            }
            else
            {
                [self.tenArray addObject:[self addNewRandomObject]];
                self.swipeCounter++;
                self.currentIndex++;
            }
        }
        else
        {
            self.currentIndex++;
        }
    
    self.containerView.randomObject = [self.tenArray objectAtIndex:self.currentIndex];
//    self.textView.random = [self.tenArray objectAtIndex:self.currentIndex];
    self.pageControl.currentPage = self.currentIndex;
    self.containerView.backgroundColor = self.containerView.randomObject.currentColor;
    
}

-(void)moveBackward:(UISwipeGestureRecognizer *)rightSwipeGestureRecognizer{
    
    
    if (self.currentIndex == 0) {
        return;
    }
    else{
        self.currentIndex--;
    }
    self.containerView.randomObject = [self.tenArray objectAtIndex:self.currentIndex];
    self.pageControl.currentPage = self.currentIndex;
    self.containerView.backgroundColor = self.containerView.randomObject.currentColor;

}

-(UIColor *)pickRandomColor{
    
    NSInteger aRedValue = arc4random()%255;
    NSInteger aGreenValue = arc4random()%255;
    NSInteger aBlueValue = arc4random()%255;
    
//    double hue = ((double)arc4random() / ARC4RANDOM_MAX);
//    double saturation = ((double)arc4random() / ARC4RANDOM_MAX);
//    double brightness = ((double)arc4random() / ARC4RANDOM_MAX);
    
    UIColor *randColor = [UIColor colorWithRed:aRedValue/255.0f green:aGreenValue/255.0f blue:aBlueValue/255.0f alpha:1.0f];
//    UIColor *randUpdated = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1.0];
    return randColor;
}
-(NSString*)pickRandomFont
{
    NSUInteger randomIndex = arc4random()%[self.fontArray count];
    return self.fontArray[randomIndex];
    
}

-(UIColor *)getContrastColorForColor:(UIColor *)currentColor
{
    CGFloat hue, saturation, brightness, alpha ;
    BOOL ok = [ currentColor getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha ] ;
    if ( !ok ) {
        // handle error
    }
    brightness = 1-brightness;
    
    return [ UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:alpha ] ;
}

-(void)createFontArray
{
    self.fontArray = [[NSMutableArray alloc]init];
    for (NSString *familyName in [UIFont familyNames])
    { NSLog(@"Font Family = %@", familyName);
        for (NSString *fontName in
             [UIFont fontNamesForFamilyName:familyName])
        {
            [self.fontArray addObject:fontName];
        }
    }
}

-(Randomness *)addNewRandomObject
{
    Randomness *newRand = [[Randomness alloc]init];
    newRand.currentColor=[self pickRandomColor];
    newRand.currentFontName=[self pickRandomFont];
    newRand.currentTextColor=[self getContrastColorForColor:newRand.currentColor];
    return newRand;
}

-(IBAction)enterEditMode:(id)sender{
    
    //Remove swipe gesture in edit mode
    
    [self.containerView removeGestureRecognizer:self.leftGesturerecognizer];
    [self.containerView removeGestureRecognizer:self.rightGesturerecognizer];
    
    
    self.containerView.drawBorder = YES;

    
   // self.textView.random = self.containerView.randomObject;
    
    self.textView.backgroundColor = [UIColor clearColor];

    [self.containerView setNeedsDisplay];
   // [self.textView drawBorderForRect];
    
}

@end
