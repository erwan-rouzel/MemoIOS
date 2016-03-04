//
//  DateUtils.m
//  Memo
//
//  Created by Erwan Rouzel on 04/03/2016.
//  Copyright © 2016 Erwan Rouzel. All rights reserved.
//

#import "DateUtils.h"

@implementation DateUtils

+ (NSString*) dateUserFriendly:(NSDate*) date{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    
    // Convert date object to a more friendly output format
    [dateFormat setDateFormat:@"EEEE MMMM d, YYYY"];
    NSString *dateString = [dateFormat stringFromDate:date];
    
    return dateString;
}

@end
