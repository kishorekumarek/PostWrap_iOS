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
    self.inputTextView.layer.cornerRadius = 2.0;
    self.inputTextView.text = @"Enter your text here";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

//-(void)prepareForReuse{
//
//    [super prepareForReuse];
//    self.inputTextView.text = @"Enter your text here";
//}

-(void)textViewDidEndEditing:(UITextView *)textView{
    
    self.textInputArray = [[NSMutableArray alloc]initWithObjects:textView.text, nil];
    [textView resignFirstResponder];
};

-(void)textViewDidBeginEditing:(UITextView *)textView{
    
    
}

@end
