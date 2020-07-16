//
//  FUCacheManager.h
//  App
//
//  Created by mac on 2017/11/16.
//  Copyright © 2017年 HuanMingLi. All rights reserved.
//

//  缓存工具类

#import <Foundation/Foundation.h>
static NSString * COMMON_USER_BUSINESSID = @"businessId";//商户ID
static NSString * COMMON_USER_ACCOUNT = @"account";//用户电话
static NSString * COMMON_USER_PASSWORD = @"passWord";//用户密码
static NSString * COMMON_USER_TOKEN = @"token";//用户密码
static NSString * COMMON_USER_STOREID = @"storeId";//选择的门店ID
static NSString * COMMON_USER_STORENAME = @"storeName";//选择的门店名称
static NSString * COMMON_USER_USERNAME = @"userName";//用户名称
static NSString * COMMON_USER_USERPHOTO= @"userPhoto";//用户头像
static NSString * COMMON_USER_JSESSIONID = @"JSESSIONID";

static NSString * COMMON_VIDEO_FILENAME = @"VIDEOFILENAME";
static NSString * COMMON_VIDEO_FILEID = @"VIDEOFILEID";
@interface FUCacheManager : NSObject


/**
 读取数据
 
 @param key <#key description#>
 @return <#return value description#>
 */
+(id)read:(NSString*)key;

/**
 写数据
 
 @param key <#key description#>
 @param val <#val description#>
 @return <#return value description#>
 */
+(BOOL)write:(NSString*)key value:(id)val;

/**
 删除数据
 
 @param key <#key description#>
 @return <#return value description#>
 */
+(BOOL)remove:(NSString*)key;

@end
