//
//  DateManager.h
//  Virtual Private Network
//
//  Created by mac on 2018/3/19.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateManager : NSObject
+(instancetype)shareInstance;
+(NSString *)stringFromDate:(NSDate *)date;
+(NSString *)stringToDayFromDate:(NSDate *)date;

+(BOOL)firstString:(NSString *)firstString andSecondString:(NSString*)secondString;
@end
