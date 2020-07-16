//
//  CEPayManager.m
//  App
//
//  Created by 吴智民 on 2017/10/27.
//  Copyright © 2017年 HuanMingLi. All rights reserved.
//

#import "CEPayManager.h"

@interface CEPayManager()


@end

static CEPayManager * manager = nil;

@implementation CEPayManager

+ (CEPayManager *)sharedManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[CEPayManager alloc] init];
    });
    return manager;
}



/********************微信支付*********************/
/**检查是否安装微信*/
+ (BOOL)isWXAppInstalled
{
    return [WXApi isWXAppInstalled];
}

/**注册微信appId*/
+ (BOOL)wxRegisterAppWithAppId:(NSString *)appId
{
    // 向微信注册
   return [WXApi registerApp:appId];
}

/**处理微信通过URL启动App时传递回来的数据*/
+ (BOOL)wxHandleOpenURL:(NSURL *)url
{
    return [WXApi handleOpenURL:url delegate:[CEPayManager sharedManager]];
}

/**发起微信支付*/
- (void)wxPayWithAppSign:(PaysignModel *)payModel
               respBlock:(CEPayManagerResultBlock)block
{
    self.wxPayResultBlock = block;
    
    if([WXApi isWXAppInstalled]){
        //调起微信支付
        PayReq* req             = [[PayReq alloc] init];
        req.openID              = payModel.appid;
        req.partnerId           = payModel.partnerid;
        req.prepayId            = payModel.prepayid;
        req.nonceStr            = payModel.noncestr;
        req.timeStamp           = payModel.timestamp;
        req.package             = payModel.package;
        req.sign                = payModel.sign;
        [WXApi sendReq:req];
    }else{
        if(self.wxPayResultBlock){
            self.wxPayResultBlock(-3, @"未安装微信");
        }
    }
}


/**发起微信分享图片*/
- (BOOL)wxShareImage:(NSData *)imageData
               Title:(NSString *)title
          ThumbImage:(UIImage *)thumbImage
             InScene:(enum WXScene)scene
           respBlock:(CEPayManagerResultBlock)block
{
    self.wxShareResultBlock = block;
    //在这里做一个表示符
    WXImageObject *object = [WXImageObject object];
    object.imageData = imageData;
        
    WXMediaMessage* message = [[WXMediaMessage alloc]init];
    message.title = title;
    message.mediaObject = object;
    message.thumbData = UIImagePNGRepresentation(thumbImage);
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc]init];
    req.bText = NO;
    req.scene = scene;
    req.message = message;
    
    return [WXApi sendReq:req];
}
/**发起微信分享URL*/
- (BOOL)wxShareUrl:(NSString *)urlString
             Title:(NSString *)title
       Description:(NSString *)description
        ThumbImage:(UIImage *)thumbImage
           InScene:(enum WXScene)scene
         respBlock:(CEPayManagerResultBlock)block
{
    self.wxShareResultBlock = block;
        
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = urlString;
    
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = title;
    message.description = description;
    message.mediaObject = ext;
    message.thumbData = UIImagePNGRepresentation(thumbImage);
    [message setThumbImage:thumbImage];
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.scene = scene;
    req.message = message;
    
    return [WXApi sendReq:req];
}


-(BOOL)wxAuthLogin:(NSString*)authority vc:(UIViewController *)viewController
         respBlock:(CEPayManagerResultBlock)block
{
    self.wxLiginResultBlock = block;
    
    SendAuthReq* req = [[SendAuthReq alloc] init];
    req.scope = authority; // @"post_timeline,sns"
    req.state = @"weixin";
    req.openID = WX_APPID;
    
    return [WXApi sendAuthReq:req
               viewController:viewController
                     delegate:self];
//    static NSString *kAuthScope = @"snsapi_message,snsapi_userinfo,snsapi_friend,snsapi_contact";
//    static NSString *kAuthOpenID = @"0c806938e2413ce73eef92cc3";
//    static NSString *kAuthState = @"xxx";
}

#pragma mark - WXApiDelegate
- (void)onResp:(BaseResp*)resp
{
    if([resp isKindOfClass:[PayResp class]]){
        switch (resp.errCode){
            case 0:{
                if(self.wxPayResultBlock){
                    self.wxPayResultBlock(0, @"支付成功");
                }
                
                NSLog(@"支付成功");
                break;
            }
            case -1:{
                if(self.wxPayResultBlock){
                    self.wxPayResultBlock(-1, @"支付失败");
                }
                
                NSLog(@"支付失败");
                break;
            }
            case -2:{
                if(self.wxPayResultBlock){
                    self.wxPayResultBlock(-2, @"支付取消");
                }
                
                NSLog(@"支付取消");
                break;
            }
                
            default:{
                if(self.wxPayResultBlock){
                    self.wxPayResultBlock(-99, @"未知错误");
                }
            }
                break;
        }
    }else if ([resp isKindOfClass:[SendMessageToWXResp class]]) {
        NSLog(@"%d",resp.errCode);
        //那么直接处理回调,删掉标识符
        switch (resp.errCode){
            case 0:{
                if(self.wxShareResultBlock){
                    self.wxShareResultBlock(0, @"分享成功");
                }
                
                NSLog(@"支付成功");
                break;
            }
            case -1:{
                if(self.wxShareResultBlock){
                    self.wxShareResultBlock(-1, @"分享失败");
                }
                NSLog(@"分享失败");
                break;
            }
            case -2:{
                if(self.wxShareResultBlock){
                    self.wxShareResultBlock(-2, @"取消分享");
                }
                
                NSLog(@"取消分享");
                break;
            }
                
            default:{
                if(self.wxShareResultBlock){
                    self.wxShareResultBlock(-99, @"未知错误");
                }
            }
                break;
        }
    }else if ([resp isKindOfClass:[SendAuthResp class]]) {
        NSLog(@"微信登陆授权");
        switch (resp.errCode){
            case 0:{
                if(self.wxLiginResultBlock){
                    SendAuthResp *authResp = (SendAuthResp *)resp;
                    self.wxLiginResultBlock(0, authResp.code);
                }
                break;
            }
            case -1:{
                if(self.wxLiginResultBlock){
                    self.wxLiginResultBlock(-1, @"授权失败");
                }
                break;
            }
            case -2:{
                if(self.wxLiginResultBlock){
                    self.wxLiginResultBlock(-2, @"用户取消");
                }
                
                break;
            }
                
            default:{
                if(self.wxLiginResultBlock){
                    self.wxLiginResultBlock(-99, @"未知错误");
                }
            }
                break;
        }
    }
        
        
}

/********************银联支付*********************/

+(BOOL)isUPPaymentAppInstalled
{
//    return [[UPPaymentControl defaultControl] isPaymentAppInstalled];
    return YES;
}


+ (BOOL)unionHandleOpenURL:(NSURL*)url{
    
//    [[UPPaymentControl defaultControl] handlePaymentResult:url completeBlock:^(NSString *code, NSDictionary *data) {
//
//        CEPayManager *payManager = [CEPayManager sharedManager];
//
//        if([code isEqualToString:@"success"]){
//            if(payManager.unionResultBlock){
//                payManager.unionResultBlock(0, @"支付成功");
//            }
//
//        }
//        else if([code isEqualToString:@"fail"]){
//            if(payManager.unionResultBlock){
//                payManager.unionResultBlock(-1, @"支付失败");
//            }
//        }
//        else if([code isEqualToString:@"cancel"]){
//            if(payManager.unionResultBlock){
//                payManager.unionResultBlock(-2, @"支付取消");
//            }
//        }
//        else{
//            if(payManager.unionResultBlock){
//                payManager.unionResultBlock(-99, @"未知错误");
//            }
//        }
//
//    }];
    
    return YES;
}


- (void)unionPayWithSerialNo:(NSString *)serialNo
              viewController:(id)viewController
                   respBlock:(CEPayManagerResultBlock)block{
    self.unionResultBlock = block;
//    [[UPPaymentControl defaultControl] startPay:serialNo
//                                     fromScheme:@"UnionPay"
//                                           mode:@"01"
//                                 viewController:viewController];
}

@end
