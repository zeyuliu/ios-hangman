//
//  ViewController.m
//  hangman project
//
//  Created by Andrew Liu on 10/18/13.
//  Copyright (c) 2013 Andrew Liu. All rights reserved.
//

#import "ViewController.h"
#import "HangmanEngine.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *guessedChars;
@property (weak, nonatomic) IBOutlet UILabel *guessedPart;

@end

@implementation ViewController
HangmanEngine* engine;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateImageView: 0];
    engine = [[HangmanEngine alloc] init];
    [[self guessedPart] setFont:[UIFont systemFontOfSize: 11]];
    [[self guessedChars] setFont:[UIFont systemFontOfSize: 11]];
    [self updateGuessedWord];
	// Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)pushButton:(id)sender {
    // If the game is done and they press the button, that means they want to restart
    if ([engine gameDone]) {
        engine = [[HangmanEngine alloc] init];
        [self updateImageView: [[engine lettersIncorrect] count]];
        [self updateGuessedWord];
        [self updateGuessedChars];
        [((UIButton *)sender) setTitle:@"Guess" forState:UIControlStateNormal];
    }
    else {

        if ([_answerField.text length] > 1) {
            return;
        }

        [engine guess: [_answerField.text uppercaseString]];
    
        if ([engine gameDone]) {
            NSLog(@"Game Done");
            if ([[engine lettersIncorrect] count] > 13) {
                // YOU LOST!
            }
            else {
                // YOU WON!
            }
            [((UIButton *)sender) setTitle:@"Restart?" forState:UIControlStateNormal];
        }
        [self updateImageView: [[engine lettersIncorrect] count]];
        [self updateGuessedWord];
        [self updateGuessedChars];
    }
}

-(void) updateGuessedWord {
    _guessedPart.text = [engine guessedPart];
}
-(void) updateGuessedChars {
    _guessedChars.text = [engine guessedChars];
}

-(void) updateImageView: (int) num{
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource: [NSString stringWithFormat:@"Hangman%d",num] ofType: @"gif"]];
    [_imageView setImage:image];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

@end
