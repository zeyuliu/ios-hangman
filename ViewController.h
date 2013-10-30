//
//  ViewController.h
//  hangman project
//
//  Created by Andrew Liu on 10/18/13.
//  Copyright (c) 2013 Andrew Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *answerField;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
-(IBAction)pushButton:(id)sender;
-(void)updateImageView:(int) num;
@end
