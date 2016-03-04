//
//  SecondViewController.m
//  Memo
//
//  Created by Erwan Rouzel on 04/03/2016.
//  Copyright © 2016 Erwan Rouzel. All rights reserved.
//

#import "MemoCreateTableViewController.h"
#import "MemoServer.h"

@interface MemoCreateTableViewController ()

@end

@implementation MemoCreateTableViewController

- (IBAction)saveClicked:(id)sender {
    NSString *memoTitle = [[self.titleAndContentTextView.text componentsSeparatedByString:@"\n"] firstObject];
    NSString *memoContent =  [self.titleAndContentTextView.text substringFromIndex:memoTitle.length];
    NSDate *memoDate = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
    
    // We test if at least memo is having a title
    // If yes, we create the memo and update the view
    // Else we display an alert message to user
    if(memoTitle.length > 0) {
        [[MemoServer sharedInstance] recordMemoWithTitle:memoTitle date:memoDate content:memoContent andCompletionHandler:^(NSError *error) {
            if(!error) {
                [self refresh];
            } else {
                NSLog(@"Error while posting message: %@", error);
            }
        }];
    } else {
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"Info"
                                      message:@"Your memo should have at least a title!"
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 //Nothing to do here... just let user go back to enter memo
                             }];
        
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
    }
}
@end
