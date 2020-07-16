//
//  MHPayManager.h
//  Test
//
//  Created by Pro on 2020/4/15.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import <Foundation/Foundation.h>
// 微信
#import "PaySignModel.h"
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
typedef void (^MHPayManagerResultBlock) (NSInteger resultCode, NSString * resultMsg);

NS_ASSUME_NONNULL_BEGIN

@interface MHPayManager : NSObject<WXApiDelegate>

+ (MHPayManager *)sharedManager;

/***********************************************/
/********************微信支付*********************/
/***********************************************/

/**微信支付结果回调*/
@property (strong, nonatomic)MHPayManagerResultBlock wxPayResultBlock;

/**微信分享结果回调*/
@property (strong, nonatomic)MHPayManagerResultBlock wxShareResultBlock;

/**微信登陆结果回调*/
@property (strong, nonatomic)MHPayManagerResultBlock wxLiginResultBlock;

/**检查是否安装微信*/
+ (BOOL)isWXAppInstalled;

/**注册微信appId*/
+ (BOOL)wxRegisterAppWithAppId:(NSString *)appId;

/**处理微信通过URL启动App时传递回来的数据*/
+ (BOOL)wxHandleOpenURL:(NSURL *)url;

/**处理微信通过Universal Link启动App时传递的数据*/
+ (BOOL)handleOpenUniversalLink:(NSUserActivity *)universalLink;

/**发起微信支付*/
- (void)wxPayWithAppSign:(PaySignModel *)payModel
               respBlock:(MHPayManagerResultBlock)block;

/**发起微信登陆*/
-(void)wxAuthLogin:(NSString*)authority
                vc:(UIViewController *)viewController
         respBlock:(MHPayManagerResultBlock)block;

/**发起微信分享图片*/
- (void)wxShareImage:(NSData *)imageData
               Title:(NSString *)title
          ThumbImage:(UIImage *)thumbImage
             InScene:(enum WXScene)scene
           respBlock:(MHPayManagerResultBlock)block;

//视频类型分享
- (void)wxShareVideoUrl:(NSString *)videoString
        videoLowBandUrl:(NSString *)videoLowBandUrl
             Title:(NSString *)title
       Description:(NSString *)description
        ThumbImage:(UIImage *)thumbImage
           InScene:(enum WXScene)scene
              respBlock:(MHPayManagerResultBlock)block;

/**发起微信分享URL*/
- (void)wxShareUrl:(NSString *)urlString
             Title:(NSString *)title
       Description:(NSString *)description
        ThumbImage:(UIImage *)thumbImage
           InScene:(enum WXScene)scene
         respBlock:(MHPayManagerResultBlock)block;


@end

NS_ASSUME_NONNULL_END
