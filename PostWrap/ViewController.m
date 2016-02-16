//
//  ViewController.m
//  PostWrap
//
//  Created by Shalini Padmanabhan on 25/11/15.
//  Copyright © 2015 Shalini Padmanabhan. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "PWEditViewController.h"

@interface ViewController ()


@property(nonatomic,strong) UITapGestureRecognizer *tapGestureRecognizer;
@property (strong, nonatomic) IBOutlet UITextView *contentTextView;
@property (strong, nonatomic) IBOutlet UIImageView *contentImageView;
@property (strong, nonatomic) IBOutlet UIButton *createPosterbtn;
@property (nonatomic,strong) UIImage *cellImage;
@property (nonatomic,strong) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *inputArray;

@property (nonatomic,strong) PWTextInputTableViewCell *textInputTableViewCell;

@end



@implementation ViewController

int rowCount = 1;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageViewtapped:)];
    self.tapGestureRecognizer.delegate = self;
    // self.cellImage = [UIImage imageNamed:@"Camera_icon.png"];
    //  self.contentImageView.image=self.cellImage;
    [self.contentImageView addGestureRecognizer:self.tapGestureRecognizer];
    //  self.automaticallyAdjustsScrollViewInsets=NO;
    self.contentTextView.layer.cornerRadius = 5.0;
    self.contentImageView.layer.cornerRadius = 10.0;
    self.createPosterbtn.layer.cornerRadius = 5.0;
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.tableView registerNib:[UINib nibWithNibName:@"PWTextInputTableViewCell" bundle:nil] forCellReuseIdentifier:@"PWTextInputTableViewCell"];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.inputArray = [[NSMutableArray alloc]init];
    self.tableView.allowsSelection = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    
}

// UITableView Delegates

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PWTextInputTableViewCell *textInputTableViewCell = nil;
    textInputTableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
    textInputTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"PWTextInputTableViewCell"];
    textInputTableViewCell.delegate = self;
    textInputTableViewCell.inputTextView.delegate = self;
    textInputTableViewCell.backgroundColor = [UIColor clearColor];
    textInputTableViewCell.inputTextView.tag = indexPath.row;
    // textInputTableViewCell.inputTextView.text = @"Enter your text here";
    return textInputTableViewCell;
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return rowCount;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    return 50.0;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        rowCount --;
        //    [self.inputArray removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    [self.tableView reloadData];
}


-(void)textViewDidBeginEditing:(UITextView *)textView{
    
    
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    
    //   NSString * textToAdd =
    
    [self.inputArray removeObject:textView.text];
    
}


-(IBAction)addButtonPressed:(id)sender{
    
    NSLog(@"%@ text",self.textInputTableViewCell.inputTextView.text);
    
    
    if (rowCount < 3) {
        rowCount++;
        [self.tableView beginUpdates];
        
        NSArray *paths = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:rowCount-1 inSection:0]];
        
        //    [self.tableView insertRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView insertRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationFade];
        //
        [self.tableView endUpdates];
        //  self.textInputTableViewCell.inputTextView.text = nil;
        [self.tableView reloadData];
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:rowCount -1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
    
    //    for (int i=0 ; i<rowCount; i++){
    //        [self.inputArray addObject:self.textInputTableViewCell.inputTextView.text];
    //    }
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
    self.contentImageView.image = image;
    
}


- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"showEditScreen"])
    {
        PWEditViewController *editViewController = segue.destinationViewController;
        editViewController.bgImage = self.contentImageView.image;
        editViewController.textArray = [[NSMutableArray alloc]initWithObjects:self.contentTextView.text, nil];
    } }

@end
