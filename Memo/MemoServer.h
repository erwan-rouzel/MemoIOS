//
//  MemoServer.h
//  MyMemo
//
//  Created by Yoann Gini on 19/02/2016.
//  Copyright © 2016 Yoann Gini. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kMemoServerNotificationNewContentAvailable @"kMemoServerNotificationNewContentAvailable"

@interface MemoServer : NSObject

+ (instancetype)sharedInstance;

- (void)recordMemoWithTitle:(NSString*)title date:(NSDate*)date content:(NSString*)content andCompletionHandler:(void (^)(NSError* error))completionHandler;

- (void)loadAllMemoWithCompletionHandler:(void (^)(NSArray *memos, NSError *error))completionHandler;

@end
