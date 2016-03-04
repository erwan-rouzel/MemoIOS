//
//  SecondViewController.h
//  Memo
//
//  Created by Erwan Rouzel on 04/03/2016.
//  Copyright © 2016 Erwan Rouzel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonTableViewController.h"

@interface MemoCreateTableViewController : CommonTableViewController
- (IBAction)saveClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *titleAndContentTextView;

@end

