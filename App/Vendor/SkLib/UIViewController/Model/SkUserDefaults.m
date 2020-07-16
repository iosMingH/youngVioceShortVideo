//
//  SkUserDefaults.m
//  App
//
//  Created by 李焕明 on 16/5/27.
//  Copyright © 2016年 李焕明. All rights reserved.
//

#import "SkUserDefaults.h"

@implementation SkUserDefaults

+ (void)writeIsBool:(BOOL)pBool key:(NSString *)pKey
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:[NSNumber numberWithInteger:pBool] forKey:pKey];
    [userDefault synchronize];
}
+ (BOOL)readIsBoolWithKey:(NSString *)pKey
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    return [[userDefault objectForKey:pKey] boolValue];
}

+ (void)writeInterger:(NSInteger)pInteger key:(NSString *)pKey
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:[NSNumber numberWithInteger:pInteger] forKey:pKey];
    [userDefault synchronize];
}
+ (NSInteger)readIntergerWithKey:(NSString *)pKey
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    return [[userDefault objectForKey:pKey] integerValue];
}

+ (void)writeString:(NSString *)pString key:(NSString *)pKey
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:pString forKey: pKey ];
}
+ (NSString *)readStringWithKey:(NSString *)pKey
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    return [userDefault objectForKey: pKey];
}

+ (void)writeArray:(NSArray *)pArray key:(NSString *)pKey
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:pArray forKey: pKey ];
}
+ (NSArray *)readArrayWithKey:(NSString *)pKey
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    return [userDefault objectForKey: pKey];
}

+ (void)writeDate:(NSDate *)pDate
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:pDate forKey: @"date" ];
}
+ (NSDate *)readDate
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    return [userDefault objectForKey: @"date"];
}

+ (void)writeObject:(SkObject *)pObject
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:pObject];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:data forKey: [[pObject class] description] ];
}

+ (SkObject *)readObject:(NSString *)pObjectName
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSData *data = [user objectForKey: pObjectName ];
    return nil==data?nil:[NSKeyedUnarchiver unarchiveObjectWithData:data];
}
+ (SkSet *)readSet
{
    return (SkSet *)[SkUserDefaults readObject:@"SkSet"];
}

+ (SkUser *)readUser
{
    return (SkUser *)[SkUserDefaults readObject:@"SkUser"];
}

+ (SkPublicConfig *)readPublicConfig
{
    return (SkPublicConfig *)[SkUserDefaults readObject:@"SkPublicConfig"];
}

@end
