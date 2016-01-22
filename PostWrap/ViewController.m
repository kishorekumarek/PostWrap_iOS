//
//  ViewController.m
//  PostWrap
//
//  Created by Shalini Padmanabhan on 25/11/15.
//  Copyright © 2015 Shalini Padmanabhan. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "PWTextInputTableViewCell.h"
#import "PWEditViewController.h"

@interface ViewController ()


@property(nonatomic,strong) UITapGestureRecognizer *tapGestureRecognizer;
@property (strong, nonatomic) IBOutlet UITextView *contentTextView;
@property (strong, nonatomic) IBOutlet UIImageView *contentImageView;
@property (nonatomic,strong) PWTextInputTableViewCell *textInputTableViewCell;
@property (strong, nonatomic) IBOutlet UIButton *createPosterbtn;
@property (nonatomic,strong) UIImage *cellImage;
@end

static NSString *cellID = @"PWTextInputTableViewCell";


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageViewtapped:)];
    self.tapGestureRecognizer.delegate = self;
    self.cellImage = [UIImage imageNamed:@"Camera_icon.png"];
    self.contentImageView.image=self.cellImage;
    [self.contentImageView addGestureRecognizer:self.tapGestureRecognizer];
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.contentTextView.layer.cornerRadius = 5.0;
    self.contentImageView.layer.cornerRadius = 10.0;
    self.createPosterbtn.layer.cornerRadius = 5.0;
    // Do any additional setup after loading the view, typically from a nib.
}



-(void)imageViewtapped:(UITapGestureRecognizer*)sender {
    
    UIAlertAction *actionCamera = nil;
    UIAlertAction *actionGallery = nil;
    UIAlertAction *actionCancel = nil;
    
    // create action sheet
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"Select" message:nil
                                          preferredStyle:UIAlertControllerStyleActionSheet];
    
    // camera Button
    actionCamera = [UIAlertAction
                    actionWithTitle:NSLocalizedString(@"Take Photo", nil)
                    style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                        
                        // Delete
                        // [self deleteFileAtCurrentIndexPath];
                    }];
    
    // Gallery Button
    actionGallery = [UIAlertAction
                    actionWithTitle:NSLocalizedString(@"Choose from Gallery", nil)
                    style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                        [self openGallery];
                        
                    }];
    
    // Cancel Button
    
    actionCancel  = [UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
        
        
    }];
    
    // Add actions
    [alertController addAction:actionCamera];
    [alertController addAction:actionGallery];
    [alertController addAction:actionCancel];
    [self presentViewController:alertController animated:YES completion:nil];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)openCamera{
    
}


-(void)openGallery{
    
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    [picker setSourceType:(UIImagePickerControllerSourceTypePhotoLibrary)];
    [self presentViewController:picker animated:YES completion:Nil];

}


//UIImagePicker controller delegates

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
    self.cellImage = image;
    
}


- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"showEditScreen"])
    {
        PWEditViewController *editViewController = segue.destinationViewController;
        editViewController.bgImage = self.cellImage;
        editViewController.textArray = [[NSMutableArray alloc]initWithObjects:self.contentTextView.text, nil];
    } }

@end
