//
//  CEPayManager.h
//  App
//
//  Created by 吴智民 on 2017/10/27.
//  Copyright © 2017年 HuanMingLi. All rights reserved.
//  支付管理类

#import <Foundation/Foundation.h>
// 银联
//#import "UPPaymentControl.h"
// 微信
#import "PaysignModel.h"
#import "WXApiManager.h"
#import "WXApiRequestHandler.h"


/**
 resultCode:
 0    -    支付成功
 -1   -    支付失败
 -2   -    支付取消
 -3   -    未安装App(适用于微信)
 -4   -    设备或系统不支持，或者用户未绑卡(适用于ApplePay)
 -99  -    未知错误
 */
typedef void (^CEPayManagerResultBlock) (NSInteger resultCode, NSString * resultMsg);

@interface CEPayManager : NSObject<WXApiDelegate>


+ (CEPayManager *)sharedManager;

/***********************************************/
/********************微信支付*********************/
/***********************************************/

/**微信支付结果回调*/
@property (strong, nonatomic)CEPayManagerResultBlock wxPayResultBlock;

/**微信分享结果回调*/
@property (strong, nonatomic)CEPayManagerResultBlock wxShareResultBlock;

/**微信登陆结果回调*/
@property (strong, nonatomic)CEPayManagerResultBlock wxLiginResultBlock;

/**检查是否安装微信*/
+ (BOOL)isWXAppInstalled;

/**注册微信appId*/
+ (BOOL)wxRegisterAppWithAppId:(NSString *)appId;

/**处理微信通过URL启动App时传递回来的数据*/
+ (BOOL)wxHandleOpenURL:(NSURL *)url;

/**发起微信支付*/
- (void)wxPayWithAppSign:(PaysignModel *)payModel
               respBlock:(CEPayManagerResultBlock)block;

/**发起微信登陆*/
-(BOOL)wxAuthLogin:(NSString*)authority
                vc:(UIViewController *)viewController
         respBlock:(CEPayManagerResultBlock)block;

/**发起微信分享图片*/
- (BOOL)wxShareImage:(NSData *)imageData
               Title:(NSString *)title
          ThumbImage:(UIImage *)thumbImage
             InScene:(enum WXScene)scene
           respBlock:(CEPayManagerResultBlock)block;
/**发起微信分享URL*/
- (BOOL)wxShareUrl:(NSString *)urlString
             Title:(NSString *)title
       Description:(NSString *)description
        ThumbImage:(UIImage *)thumbImage
           InScene:(enum WXScene)scene
         respBlock:(CEPayManagerResultBlock)block;

/***********************************************/
/********************银联支付*********************/
/***********************************************/

/**银联支付结果回调*/
@property (nonatomic, strong)CEPayManagerResultBlock unionResultBlock;


/** 是否安装银联app */
+(BOOL)isUPPaymentAppInstalled;

/**处理银联通过URL启动App时传递回来的数据*/
+ (BOOL)unionHandleOpenURL:(NSURL*)url;

/**发起银联支付*/
- (void)unionPayWithSerialNo:(NSString *)serialNo
              viewController:(id)viewController
                   respBlock:(CEPayManagerResultBlock)block;


@end
