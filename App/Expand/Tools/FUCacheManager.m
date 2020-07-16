//
//  FUCacheManager.m
//  App
//
//  Created by mac on 2017/11/16.
//  Copyright © 2017年 HuanMingLi. All rights reserved.
//


#import "FUCacheManager.h"

@implementation FUCacheManager


/**
 读取数据
 
 @param key <#key description#>
 @return <#return value description#>
 */
+(id)read:(NSString*)key
{
    return [[NSUserDefaults standardUserDefaults]objectForKey:key];
}

/**
 写数据
 
 @param key <#key description#>
 @param val <#val description#>
 @return <#return value description#>
 */
+(BOOL)write:(NSString*)key value:(id)val
{
    [[NSUserDefaults standardUserDefaults] setObject:val forKey:key];
    [[NSUserDefaults standardUserDefaults]synchronize];
    return YES;
}

//删除数据
+(BOOL)remove:(NSString *)key
{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:key];
    [defaults synchronize];
    return YES;
}

@end
