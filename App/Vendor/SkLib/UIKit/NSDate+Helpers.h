//
//  NSDate+Helpers.m
//  App
//
//  Created by 李焕明 on 16/6/4.
//  Copyright © 2016年 李焕明. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Helpers)

- (NSString *)getFormatYearMonthDay;
- (NSString *)getFormatYearMonth;
- (int )getWeekOfYear;
- (NSDate *)dateAfterDay:(int)day;
- (NSDate *)dateafterMonth:(int)month;
- (NSUInteger)getDay;
- (NSUInteger)getMonth;
- (NSUInteger)getYear;
- (int )getHour;
- (int)getMinute;
- (int )getHour:(NSDate *)date;
- (int)getMinute:(NSDate *)date;
- (NSUInteger)daysAgo;
- (NSUInteger)daysAgoAgainstMidnight;
- (NSString *)stringDaysAgo;
- (NSString *)stringDaysAgoAgainstMidnight:(BOOL)flag;
- (NSUInteger)weekday ;
+ (NSDate *)dateFromString:(NSString *)string;
+ (NSDate *)dateFromString:(NSString *)string withFormat:(NSString *)format;
+ (NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)format;
+ (NSString *)stringFromDate:(NSDate *)date;
+ (NSString *)stringForDisplayFromDate:(NSDate *)date prefixed:(BOOL)prefixed ;
+ (NSString *)stringForDisplayFromDate:(NSDate *)date;
- (NSString *)stringWithFormat:(NSString *)format;
- (NSString *)string;
- (NSString *)stringWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle;
- (NSDate *)beginningOfWeek;
- (NSDate *)beginningOfDay;
- (NSDate *)beginningOfMonth;
- (NSDate *)endOfMonth;
- (NSDate *)endOfWeek;
+ (NSString *)dateFormatString;
+ (NSString *)timeFormatString;
+ (NSString *)timestampFormatString;
+ (NSString *)dbFormatString;

//比较日期大小 没达到指定日期，返回-1，刚好是这一时间，返回0，否则返回1
+ (int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay;

//NSString转NSDate
+ (NSDate *)dateFromOtherString:(NSString *)string;

@end
