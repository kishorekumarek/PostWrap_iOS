//
//  PWTextInputTableViewCell.m
//  PostWrap
//
//  Created by Shalini Padmanabhan on 25/11/15.
//  Copyright © 2015 Shalini Padmanabhan. All rights reserved.
//

#import "PWTextInputTableViewCell.h"

@implementation PWTextInputTableViewCell


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)textViewDidEndEditing:(UITextView *)textView{
    
    self.textInputArray = [[NSMutableArray alloc]initWithObjects:textView.text, nil];
    [textView resignFirstResponder];
};

@end
