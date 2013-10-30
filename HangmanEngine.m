//
//  HangmanEngine.m
//  hangman project
//
//  Created by Andrew Liu on 10/18/13.
//  Copyright (c) 2013 Andrew Liu. All rights reserved.
//

#import "HangmanEngine.h"
#import "HangmanWords.h"
@interface HangmanEngine ()
{
}
@end

@implementation HangmanEngine
{


}



-(id) init{
    self = [super init];
    if (self){
        HangmanWords *wordGrabber = [[HangmanWords alloc] init];
        _lettersIncorrect = [[NSMutableSet alloc] init];
        _lettersGuessed = [[NSMutableSet alloc] init];
        _lettersCorrect = [[NSMutableArray alloc] init];
        _guessWord = [wordGrabber getWord];
        _gameDone = FALSE;
        
        for (int i=0; i < [_guessWord length];	i++) {
            NSString* character = [_guessWord substringWithRange: NSMakeRange(i, 1)];;
            // if it is an empty space, we want to include it.
            if ([character isEqualToString:@" "]) {
                [_lettersCorrect addObject: @" "];
            }
            else {
                [_lettersCorrect addObject: @""];
            }
        }
        // Print out the lettersCorrect array

        NSLog(_guessWord);
        NSLog(@"%@",_lettersCorrect);
    }
    return self;
}

-(void)updateCorrect:(NSString *) guess{
    int remaining = 0;
    for (int i=0; i < [_guessWord length];	i++) {
        NSString* character = [_guessWord substringWithRange: NSMakeRange(i, 1)];;
        // if it is equal to our guess, we should add it
        if ([[_lettersCorrect objectAtIndex:i] isEqualToString: @""])
        {
            remaining++;
        }
        if ([character isEqualToString: guess]) {
            [_lettersCorrect replaceObjectAtIndex:i withObject:guess];
            NSLog(@"Updated correct array");
            NSLog(@"%@",_lettersCorrect);
            remaining--;
        }
    }
    if (remaining == 0) {
        _gameDone = YES;
    }
    else {
        _gameDone = NO;
    }
}

-(BOOL)guess:(NSString *)character{
    if (_gameDone == YES) {
        return NO;
    }
    [_lettersGuessed addObject:character];
    if ([_guessWord rangeOfString:character].location != NSNotFound) {
        NSLog(@"Yes");
        // If it is correct, we want to update our guesses
        [self updateCorrect: character];
        [_lettersGuessed addObject:character];
        return YES;
    }
    else {
        NSLog(@"No");
        [_lettersIncorrect addObject:character];
        if ([_lettersIncorrect count] > 13) {
            NSLog(@"You died");
            _gameDone = YES;
        }
        return NO;
    }
}

-(NSString*)guessedPart {
    NSString *guessed = @"Word: ";
    for (int i=0; i < [_lettersCorrect count];	i++) {
        NSString* character = [_lettersCorrect objectAtIndex:i];
        if ([character isEqualToString:@""]) {
            character = @" _";
        }
        else if ([character isEqualToString:@" "]) {
            character = @"  ";
        }
        else {
            character = [@" " stringByAppendingString:character];
        }
        guessed = [guessed stringByAppendingString:character];
    }
    NSLog(guessed);
    return guessed;
    
}

-(NSString*)guessedChars {
    NSString *guessed = @"Guessed Characters:";
    for (NSString* character in _lettersGuessed) {
        guessed = [guessed stringByAppendingString:@" "];
        guessed = [guessed stringByAppendingString:character];
    }
    NSLog(guessed);
    return guessed;
    
}
@end
