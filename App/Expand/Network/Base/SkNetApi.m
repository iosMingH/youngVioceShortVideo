//
//  SkNetApi.m
//  App
//
//  Created by 李焕明 on 16/5/25.
//  Copyright © 2016年 李焕明. All rights reserved.
//

#import "SkNetApi.h"
#import "AppDelegate.h"
#import "SecurityUtil.h"
#import "GTMBase64.h"
@implementation SkNetApi

+ (AFHTTPSessionManager*) manager
{
    static dispatch_once_t onceToken;
    static AFHTTPSessionManager *manager = nil;
    dispatch_once(&onceToken, ^{
         // 1、创建请求管理者
        manager = [AFHTTPSessionManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/javascript",@"text/html",@"text/plain",nil];
         // 2、数据反序列化（因为在进行请求服务器之前会对参数进行一次参数序列化）
        manager.requestSerializer=[AFHTTPRequestSerializer serializer];
        manager.requestSerializer.timeoutInterval = 10;
        manager.securityPolicy = [self returnCustomSecurityPolicy];
         [self AFNetworkReachabilityManagerStatus];
        
        NSDictionary *appInfo = [[NSBundle mainBundle] infoDictionary];
        NSString *app_Name = [appInfo objectForKey:@"CFBundleDisplayName"];
        NSString *app_Version = [appInfo objectForKey:@"CFBundleShortVersionString"];
        app_Version = [app_Version stringByReplacingOccurrencesOfString:@"." withString:@""];
        NSString *bundleId = BundleID;
        [manager.requestSerializer setValue:app_Name forHTTPHeaderField:@"appName"];
        [manager.requestSerializer setValue:app_Version forHTTPHeaderField:@"appVersionCode"];
        [manager.requestSerializer setValue:bundleId forHTTPHeaderField:@"bundleId"];
        
        
    });
    
    return manager;
}

+ (void)request:(SkNetRequest *)param success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failue
{
    SkNetRequest *request = [[SkNetRequest alloc]init];
    request.method = param.method;
    request.httpMethod = param.httpMethod;
    request.httpUrl = param.httpUrl;
    param.method = nil;//这步一定要操作
    param.httpMethod = nil;//这步一定要操作
    param.httpUrl = nil;//这步一定要操作
    request.params = param.mj_keyValues;
    
    if ( [request.httpMethod isEqualToString:@"GET"] ) {
        [SkNetApi GET_request:request success:success failure:failue];
    }else if ( [request.httpMethod isEqualToString:@"POST"] ) {
        [SkNetApi POST_request:request success:success failure:failue];
    }else if ( [request.httpMethod isEqualToString:@"PUT"] ) {
        [SkNetApi PUT_request:request success:success failure:failue];
    }else if ( [request.httpMethod isEqualToString:@"DELETE"] ) {
        [SkNetApi DELETE_request:request success:success failure:failue];
    }else if ([request.httpMethod isEqualToString:@"POSTFORMDATA"]){
//        [SkNetApi POST_formData_request:request success:success failure:failue];
    }
}


+(AFSecurityPolicy *)returnCustomSecurityPolicy{
    //设置请求头
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"ce" ofType:@"cer"];//证书的路径
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    
    // AFSSLPinningModeCertificate 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone]; //代表无条件信任服务器的证书
    //是否允许无效证书（也就是自建的证书）
    securityPolicy.allowInvalidCertificates = YES;
    
    securityPolicy.validatesDomainName = NO;
    
    securityPolicy.pinnedCertificates = [[NSSet alloc] initWithObjects:certData,nil,nil];
    
    return securityPolicy;
}

+(void)AFNetworkReachabilityManagerStatus {
    AFNetworkReachabilityManager *manger = [AFNetworkReachabilityManager sharedManager];
    //1、监听网络状态的变化
    [manger setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusNotReachable) {
            [MMEditView creatAltViewWithTitle:@"警告" detail:@"无法连接到因特网，请检查数据流量或WiFi是否开启，或是否允许“少音”使用数据流量" arrTitles:@[@"检查设置",@"OK"] block:^(NSUInteger index, UIButton *sender, NSString *stfstring) {
                if (index == 0) {
                    NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                    if([[UIApplication sharedApplication] canOpenURL:url]) {
                        [[UIApplication sharedApplication] openURL:url];
                    }
                }
            }];
        }
    }];
    //2、开启监听网络
    [manger startMonitoring];
}

+ (void)GET_request:(SkNetRequest *)request success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failue
{
    NSString *httpUrl = request.httpUrl.length > 0 ? request.httpUrl:URL_BASIC;
    NSString *URLString = [NSString stringWithFormat:@"%@/%@", httpUrl , request.method];
    NSLog(@"request.params=%@",request.params);
    NSLog(@"urlSTRING=%@",URLString);
    //    SkNetRequest *obj = request.params;
    
    //jessionID ==================
//    NSString *jessionId = [NSString stringWithFormat:@"%@",[FUCacheManager read:COMMON_USER_JSESSIONID]];
//
//    NSString *jsessionIdAll = [NSString stringWithFormat:@"JSESSIONID=%@",jessionId];
//    [[self manager].requestSerializer setValue:jsessionIdAll forHTTPHeaderField:@"Cookie"];
    // =========================
    
//    [FUPROGRESS_HUD loading:@"加载中..."];
    // 3、开始请求
    [[self manager] GET:URLString parameters:request.params progress:^(NSProgress *_Nonnull uploadProgress) {
        // 上传进度
    } success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
        //解析数据
        [FUPROGRESS_HUD complete];
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (success) success(json);
    } failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
        [FUPROGRESS_HUD complete];
        if (failue) failue(error);
        NSLog(@"error=%@",error);
        TOAST([error localizedDescription]);
        
    }];
    
}

+ (void)POST_request:(SkNetRequest *)request success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failue
{
    NSString *httpUrl = request.httpUrl.length > 0 ? request.httpUrl:URL_BASIC;
    NSString *URLString = [NSString stringWithFormat:@"%@/%@", httpUrl , request.method];
    NSLog(@"urlSTRING=%@",URLString);
    
//    NSString *jessionId = [NSString stringWithFormat:@"JSESSIONID=%@",[FUCacheManager read:COMMON_USER_JSESSIONID]];
//    NSLog(@"jessionId=%@",jessionId);
//    if (jessionId) {
//         [manager.requestSerializer setValue:jessionId forHTTPHeaderField:@"Cookie"];
//    }
    
    
    //    // 3、开始请求
//    [FUPROGRESS_HUD loading:@"加载中..."];
    [[self manager] POST:URLString parameters:request.params progress:^(NSProgress *_Nonnull uploadProgress) {
        // 上传进度
    } success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
        //        //解析数据
        NSLog(@"responseObject=%@",responseObject);
        [FUPROGRESS_HUD complete];
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
                   NSDictionary *resultDic = (NSDictionary *)responseObject;
                   if (success) success(resultDic);
               }else{
                  NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                   if (success) success(json);
               }
    } failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
        [FUPROGRESS_HUD complete];
        if (failue) failue(error);
        TOAST([error localizedDescription]);
    }];
}


+ (void)PUT_request:(SkNetRequest *)request success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failue
{
    
}

+ (void)DELETE_request:(SkNetRequest *)request success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failue
{
}

+ (void)POST_formData_request:(SkNetRequest *)param photoArray:(NSMutableArray *)phptoArray success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failue{
    SkNetRequest *request = [[SkNetRequest alloc]init];
    request.method = param.method;
    request.httpMethod = param.httpMethod;
    request.httpUrl = param.httpUrl;
    param.method = nil;//这步一定要操作
    param.httpMethod = nil;//这步一定要操作
    param.httpUrl = nil;//这步一定要操作
    request.params = param.mj_keyValues;
    NSLog(@"request.params=%@",request.params);
    NSString *httpUrl = request.httpUrl.length > 0 ? request.httpUrl:URL_BASIC;
    NSString *URLString = [NSString stringWithFormat:@"%@/%@", httpUrl , request.method];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"image/jpeg", @"image/png",@"application/octet-stream",@"text/json",nil];

    [manager POST:URLString parameters:request.params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        // 上传 多张图片
        for(NSInteger i = 0; i < phptoArray.count; i++) {
            NSData * imageData = UIImageJPEGRepresentation([phptoArray objectAtIndex: i], 0.1);
            // 上传的参数名
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
            [formData appendPartWithFileData:imageData name:str fileName:fileName mimeType:@"image/jpeg"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (success) success(json);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        TOAST([error localizedDescription]);
        if (failue) failue(error);
    }];
}


+(void)reqWxUnionId:(NSString*)openid success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failue
{
    // 检查网络
//    NSString* WECHATAPP_ID = @"wxd74bc18978752573";
//    NSString* WECHATSECRET = @"d35da9adb96e17d2e6e0f6dfccae9120";
    NSString *url = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",WX_APPID,WX_SECRET,openid];
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    // 数据格式
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 数据格式解析
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (success) success(json);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failue) failue(error);
        NSLog(@"error=%@",error);
    }];
}

//获取用户个人信息（UnionID 机制） https://api.weixin.qq.com/sns/userinfo?access_token=ACCESS_TOKEN&openid=OPENID
+(void)reqWxPersonalInfo:(NSString*)openid accessToken:(NSString *)accessToken success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failue{
    NSString *url = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",accessToken,openid];
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    // 数据格式
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 数据格式解析
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (success) success(json);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failue) failue(error);
        NSLog(@"error=%@",error);
    }];
}
@end
