//
//  DateManager.m
//  Virtual Private Network
//
//  Created by mac on 2018/3/19.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "DateManager.h"

@implementation DateManager
static DateManager *_datamanager=nil;
+(instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _datamanager=[[self alloc]init];
    });
    return _datamanager;
}

+(NSString *)stringFromDate:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}
+(NSString *)stringToDayFromDate:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}

+(BOOL)firstString:(NSString *)firstString andSecondString:(NSString*)secondString{
    int result=[firstString compare:secondString];
    if(result==NSOrderedDescending)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

@end
