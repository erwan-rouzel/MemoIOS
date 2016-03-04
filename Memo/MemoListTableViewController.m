//
//  FirstViewController.m
//  Memo
//
//  Created by Erwan Rouzel on 04/03/2016.
//  Copyright © 2016 Erwan Rouzel. All rights reserved.
//

#import "MemoListTableViewController.h"
#import "MemoDetailsViewController.h"

@interface MemoListTableViewController ()

@end

@implementation MemoListTableViewController

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // We pass informations to the details view controller
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    MemoDetailsViewController *viewController = [segue destinationViewController];
    viewController.memo = [self.memos objectAtIndex:indexPath.row];
}

@end
