//
//  MemoServer.m
//  MyMemo
//
//  Created by Yoann Gini on 19/02/2016.
//  Copyright © 2016 Yoann Gini. All rights reserved.
//

#import "MemoServer.h"
#import <libkern/OSAtomic.h>

@interface MemoServer () {
    OSSpinLock _lock;
}

@property NSMutableArray *memos;

@end

@implementation MemoServer

+ (instancetype)sharedInstance {
    static id sharedInstanceMemoServer = nil;
    static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedInstanceMemoServer = [self new];
	});
    return sharedInstanceMemoServer;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _lock = OS_SPINLOCK_INIT;
        _memos = [[NSMutableArray alloc] initWithArray:@[
                                                         @{@"title": @"Hello World", @"date": [[NSDate alloc] initWithTimeIntervalSince1970:3269873], @"content": @"A message from the past"},
                                                         ]];
    }
    return self;
}

- (void)recordMemoWithTitle:(NSString*)title date:(NSDate*)date content:(NSString*)content andCompletionHandler:(void (^)(NSError* error))completionHandler {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        OSSpinLockLock(&_lock);
        
        [self.memos addObject:@{@"title": title, @"date": date, @"content": content}];
        
        OSSpinLockUnlock(&_lock);
        
        completionHandler(nil);
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kMemoServerNotificationNewContentAvailable object:self];
        
    });
}

- (void)loadAllMemoWithCompletionHandler:(void (^)(NSArray *memos, NSError *error))completionHandler {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSArray *memoCopy = nil;
        
        OSSpinLockLock(&_lock);
        
        memoCopy = [self.memos copy];
        
        OSSpinLockUnlock(&_lock);
        
        completionHandler(memoCopy, nil);
        
    });
}

@end
