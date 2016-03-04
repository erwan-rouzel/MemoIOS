//
//  CommonListViewController.m
//  Memo
//
//  Created by Erwan Rouzel on 04/03/2016.
//  Copyright © 2016 Erwan Rouzel. All rights reserved.
//

#import "CommonTableViewController.h"
#import "MemoServer.h"
#import "MemoDetailsViewController.h"
#import "DateUtils.h"

@interface CommonTableViewController ()

@end

@implementation CommonTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [[MemoServer sharedInstance] loadAllMemoWithCompletionHandler:^(NSArray *memos, NSError *error) {
        if(! error) {
            self.memos = memos;
        } else {
            NSLog(@"Error while loading memos: %@", error);
        }
    }];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    [self refresh];
}

- (void) viewDidAppear:(BOOL)animated {
    [self refresh];
}

#pragma mark - Table view data source

- (void)refresh {
    [[MemoServer sharedInstance] loadAllMemoWithCompletionHandler:^(NSArray *memos, NSError *error) {
        if(! error) {
            self.memos = memos;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.refreshControl endRefreshing];
                [self.tableView reloadData];
            });
        } else {
            NSLog(@"Error while loading memos: %@", error);
        }
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _memos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"stdcell" forIndexPath:indexPath];
    
    // Configure the cell with title and date...
    NSString *title = [[self.memos objectAtIndex:indexPath.row] valueForKey:@"title"];
    NSDate *date = [[self.memos objectAtIndex:indexPath.row] valueForKey:@"date"];
    
    cell.textLabel.text = title;
    cell.detailTextLabel.text = [DateUtils dateUserFriendly:date];
    
    return cell;
}

@end
