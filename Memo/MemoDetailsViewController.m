//
//  MemoDetailsViewController.m
//  Memo
//
//  Created by Erwan Rouzel on 04/03/2016.
//  Copyright © 2016 Erwan Rouzel. All rights reserved.
//

#import "MemoDetailsViewController.h"
#import "DateUtils.h"

@interface MemoDetailsViewController ()

@end

@implementation MemoDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLabel.text = [self.memo valueForKey:@"title"];
    self.dateLabel.text = [DateUtils dateUserFriendly:[self.memo valueForKey:@"date"]];
    self.contentLabel.text = [self.memo valueForKey:@"content"];
}

@end
