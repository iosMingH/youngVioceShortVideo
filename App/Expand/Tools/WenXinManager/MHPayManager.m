//
//  MHPayManager.m
//  Test
//
//  Created by Pro on 2020/4/15.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import "MHPayManager.h"

@interface MHPayManager()


@end


static MHPayManager * manager = nil;

@implementation MHPayManager

+ (MHPayManager *)sharedManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[MHPayManager alloc] init];
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
    return [WXApi registerApp:appId universalLink:@"https://help.wechat.com/sdksample/abc"];
}

/**处理微信通过URL启动App时传递回来的数据*/
+ (BOOL)wxHandleOpenURL:(NSURL *)url
{
    return [WXApi handleOpenURL:url delegate:[MHPayManager sharedManager]];
}


/**处理微信通过Universal Link启动App时传递的数据*/
+ (BOOL)handleOpenUniversalLink:(NSUserActivity *)universalLink{
    return [WXApi handleOpenUniversalLink:universalLink delegate:[MHPayManager sharedManager]];
}

/**发起微信支付*/
- (void)wxPayWithAppSign:(PaySignModel *)payModel
               respBlock:(MHPayManagerResultBlock)block
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
        [WXApi sendReq:req completion:nil];
    }else{
        if(self.wxPayResultBlock){
            self.wxPayResultBlock(-3, @"未安装微信");
        }
    }
}


/**发起微信分享图片*/
- (void)wxShareImage:(NSData *)imageData
               Title:(NSString *)title
          ThumbImage:(UIImage *)thumbImage
             InScene:(enum WXScene)scene
           respBlock:(MHPayManagerResultBlock)block
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
    
    [WXApi sendReq:req completion:nil];
}
/**发起微信分享URL*/
- (void)wxShareUrl:(NSString *)urlString
             Title:(NSString *)title
       Description:(NSString *)description
        ThumbImage:(UIImage *)thumbImage
           InScene:(enum WXScene)scene
         respBlock:(MHPayManagerResultBlock)block
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
    
    [WXApi sendReq:req completion:nil];
}


//视频类型分享
- (void)wxShareVideoUrl:(NSString *)videoString
        videoLowBandUrl:(NSString *)videoLowBandUrl
             Title:(NSString *)title
       Description:(NSString *)description
        ThumbImage:(UIImage *)thumbImage
           InScene:(enum WXScene)scene
         respBlock:(MHPayManagerResultBlock)block
{

    self.wxShareResultBlock = block;
    WXVideoObject *videoObject = [WXVideoObject object];
    videoObject.videoUrl = videoString;
    videoObject.videoLowBandUrl = videoLowBandUrl;
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = title;
    message.description = description;
    message.thumbData = UIImagePNGRepresentation(thumbImage);
    [message setThumbImage:thumbImage];
    message.mediaObject = videoObject;
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = scene;
    [WXApi sendReq:req completion:nil];
}




-(void)wxAuthLogin:(NSString*)authority vc:(UIViewController *)viewController
         respBlock:(MHPayManagerResultBlock)block
{
    self.wxLiginResultBlock = block;
    
    SendAuthReq* req = [[SendAuthReq alloc] init];
    req.scope = authority; // @"post_timeline,sns"
    req.state = @"weixin";
    req.openID = WXAuthAppID;
    [WXApi sendAuthReq:req viewController:viewController delegate:self completion:nil];
    
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

@end
