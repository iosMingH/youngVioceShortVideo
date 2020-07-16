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


+ (void)GET_request:(SkNetRequest *)request success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failue
{
    // 1、创建请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 2、数据反序列化（因为在进行请求服务器之前会对参数进行一次参数序列化）
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 5;
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    NSString *httpUrl = request.httpUrl.length > 0 ? request.httpUrl:URL_BASIC;
    NSString *URLString = [NSString stringWithFormat:@"%@/%@", httpUrl , request.method];
    NSLog(@"request.params=%@",request.params);
    NSLog(@"urlSTRING=%@",URLString);
    //    SkNetRequest *obj = request.params;
    
    //jessionID ==================
    NSString *jessionId = [NSString stringWithFormat:@"%@",[FUCacheManager read:COMMON_USER_JSESSIONID]];

    NSString *jsessionIdAll = [NSString stringWithFormat:@"JSESSIONID=%@",jessionId];
    [manager.requestSerializer setValue:jsessionIdAll forHTTPHeaderField:@"Cookie"];
    // =========================
    
    [FUPROGRESS_HUD loading:@"加载中..."];
    // 3、开始请求
    [manager GET:URLString parameters:request.params progress:^(NSProgress *_Nonnull uploadProgress) {
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
    // 1、创建请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 2、数据反序列化（因为在进行请求服务器之前会对参数进行一次参数序列化）
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 5;
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];   // text/plian
    NSString *httpUrl = request.httpUrl.length > 0 ? request.httpUrl:URL_BASIC;
    NSString *URLString = [NSString stringWithFormat:@"%@/%@", httpUrl , request.method];
    NSLog(@"urlSTRING=%@",URLString);
    
//    NSString *jessionId = [NSString stringWithFormat:@"JSESSIONID=%@",[FUCacheManager read:COMMON_USER_JSESSIONID]];
//    NSLog(@"jessionId=%@",jessionId);
//    if (jessionId) {
//         [manager.requestSerializer setValue:jessionId forHTTPHeaderField:@"Cookie"];
//    }
    
    
    //    // 3、开始请求
    [FUPROGRESS_HUD loading:@"加载中..."];
    [manager POST:URLString parameters:request.params progress:^(NSProgress *_Nonnull uploadProgress) {
        // 上传进度
    } success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
        //        //解析数据
        [FUPROGRESS_HUD complete];
                NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (success) success(json);
        
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
