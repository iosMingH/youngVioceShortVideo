//
//  XSMiOSAuthorization.h
//  Code Block
//
//  Created by 史博 on 17/2/27.
//  Copyright © 2017年 史博. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XSMiOSAuthorization : NSObject


/**
 相册权限
 */
+(void)judgePHAuthorizationStatusWithSuccess:(void(^)())success fail:(void(^)())fail;

/**
 相机权限
 */
+(void)judgeCameraAuthorizationStatusWithSuccess:(void(^)())success fail:(void(^)())fail;

/**
 麦克风权限
 */
+(void)judgeMicrophoneAuthorizationStatusWithSuccess:(void(^)())success fail:(void(^)())fail;

/**
 定位权限
 */
+(void)judgeLocationAuthorizationStatusWithSuccess:(void(^)())success fail:(void(^)())fail;

/**
 本地通知权限
 */
+(void)judgeNotificationStatusWithSuccess:(void(^)())success fail:(void(^)())fail;

/**
 网络权限 -- AFNetworking
 */
+(void)judge_AFNetworking_NetworkConnectionStatusWithSuccess:(void(^)())success fail:(void(^)())fail;

/**
 网络权限 -- Reachability
 */
//+(void)judge_Reachability_NetworkConnectionStatusWithSuccess:(void(^)())success fail:(void(^)())fail;

/**
 通讯录权限
 */
+(void)judgeContactStoreAuthorizationStatusWithSuccess:(void(^)())success fail:(void(^)())fail;


/**
 日历权限
 */
+(void)judgeCalenderAuthorizationStatusWithSuccess:(void(^)())success fail:(void(^)())fail;

/**
 备忘录权限
 */
+(void)judgeReminderAuthorizationStatusWithSuccess:(void(^)())success fail:(void(^)())fail;

/**
 语音识别权限
 */
+(void)judgeSFSpeechRecognizerAuthorizationStatusWithSuccess:(void(^)())success fail:(void(^)())fail;

/**
 健康权限
 */
//+(void)judgeHeathAuthorizationStatusWithSuccess:(void(^)())Success fail:(void(^)(NSError * ))Fail;

/**
 蓝牙权限
 */
//+(void)judgeBluetoothAuthoribzationStatusWithSuccess:(void(^)())success fail:(void(^)())fail;



/**
 打开权限设置

 @param url <#url description#>
 */
+(void)OpenAuthSettingUrl:(NSString*)url;



@end
