//
//  CommonListViewController.h
//  Memo
//
//  Created by Erwan Rouzel on 04/03/2016.
//  Copyright © 2016 Erwan Rouzel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommonTableViewController : UITableViewController
@property NSArray *memos;
- (void)refresh;
@end
