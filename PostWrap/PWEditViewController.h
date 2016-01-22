//
//  PWEditViewController.h
//  PostWrap
//
//  Created by Shalini Padmanabhan on 27/11/15.
//  Copyright © 2015 Shalini Padmanabhan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PWEditViewController : UIViewController<UIScrollViewDelegate,UIGestureRecognizerDelegate>

@property (nonatomic,strong) NSMutableArray *textArray;
@property (nonatomic,strong) UIImage *bgImage;

-(id)initWithTextArray:(NSMutableArray *)textArray andImage:(UIImage *)image;

@end
