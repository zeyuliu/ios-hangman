//
//  HangmanEngine.h
//  hangman project
//
//  Created by Andrew Liu on 10/18/13.
//  Copyright (c) 2013 Andrew Liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HangmanEngine : NSObject
{
}
@property NSString* guessWord;
@property BOOL gameDone;
@property NSMutableSet *lettersIncorrect;
@property NSMutableSet *lettersGuessed;
@property NSMutableArray *lettersCorrect;
-(BOOL)guess:(NSString *)character;
-(NSString*)guessedPart;
-(NSString*)guessedChars;
@end
