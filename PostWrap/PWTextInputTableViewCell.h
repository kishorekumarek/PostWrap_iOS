//
//  PWTextInputTableViewCell.h
//  PostWrap
//
//  Created by Shalini Padmanabhan on 25/11/15.
//  Copyright © 2015 Shalini Padmanabhan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PWTextInputTableViewCellDelegate <NSObject>


@end

@interface PWTextInputTableViewCell : UITableViewCell<UITextViewDelegate>

@property (nonatomic,strong) IBOutlet UIImageView *previewImageView;
@property (nonatomic,strong) IBOutlet UITextView *inputTextView;
@property (nonatomic,strong) NSMutableArray *textInputArray;
@property (nonatomic,weak) id<PWTextInputTableViewCellDelegate> delegate;

@end


