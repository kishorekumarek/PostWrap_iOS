//
//  PWTextView.h
//  PostWrap
//
//  Created by Shalini Padmanabhan on 17/12/15.
//  Copyright © 2015 Shalini Padmanabhan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Randomness.h"
#import "PWFitWidthAlgoClasses/PWFitWidthAlgoObject.h"

@interface PWTextView : UIView <UIGestureRecognizerDelegate,PosterDrawingDelegate>

@property(nonatomic,strong)Randomness *random;
@property(nonatomic,strong)NSString *posterText;
@property (nonatomic,assign) BOOL drawBorder;

- (IBAction) imageMoved:(id) sender withEvent:(UIEvent *) event;

-(void)drawBorderForRect;
- (void)createAscAlgoObject;
-(void)createDescAlgoObject;
- (void)createAscAndDescCombinedObject;
- (void)createUniformFontAlgoObject;
@end
