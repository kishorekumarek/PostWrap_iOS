//
//  PWEditView.h
//  PostWrap
//
//  Created by Murali Krishnan Govindarajulu on 12/12/15.
//  Copyright © 2015 Shalini Padmanabhan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Randomness.h"

@interface PWEditView : UIView

@property(nonatomic,strong)Randomness *randomObject;
@property(nonatomic,strong)NSString *posterText;
@property (nonatomic,assign) BOOL drawBorder;
//
//
//-(void)drawBorderForRect;

@end
