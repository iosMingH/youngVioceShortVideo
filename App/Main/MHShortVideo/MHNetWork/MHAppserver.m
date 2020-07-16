//
//  MHAppserver.m
//  App
//
//  Created by Pro on 2020/4/9.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import "MHAppserver.h"
#import <AFNetworking/AFNetworking.h>
#import "NSString+AlivcHelper.h"
#import "AlivcDefine.h"

@implementation MHAppserver

+ (AFHTTPSessionManager*) manager
{
    static dispatch_once_t onceToken;
    static AFHTTPSessionManager *manager = nil;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/javascript",@"text/html",@"text/plain",nil];
        manager.requestSerializer=[AFHTTPRequestSerializer serializer];
        manager.requestSerializer.timeoutInterval = 10;
        manager.securityPolicy = [AFSecurityPolicy defaultPolicy];
        manager.securityPolicy.allowInvalidCertificates = YES;
        manager.securityPolicy.validatesDomainName = NO;
        
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

+ (void)getWithUrlString:(NSString *)urlString completionHandler:(void (^)(NSString * _Nullable, NSDictionary * _Nullable))handle{
    [self getWithUrlString:urlString parameters:@{} completionHandler:handle];
}

+ (void)getWithUrlString:(NSString *)urlString
              parameters:(id)parameters
       completionHandler:(void (^)(NSString *__nullable errString,NSDictionary *_Nullable resultDic))handle{
   
    NSMutableString * string ;
    NSDictionary *paraDic = [NSDictionary dictionaryWithDictionary:parameters];
    if (paraDic && paraDic.count >0 ) {
        
        string = [[NSMutableString alloc]initWithString:[self p_creatUrlGetStringWithOriginalUrlString:urlString param:paraDic]];
    }else {
        string= [NSMutableString stringWithString:urlString];
    }
    NSLog(@"string====%@",string);
    [[self manager] GET:string parameters:@{} progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject=%@",responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *resultDic = (NSDictionary *)responseObject;
            handle(nil,resultDic);
        }else{
            handle(@"数据格式异常",nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        handle(error.description,nil);
    }];
}


+ (void)postWithUrlString:(NSString *)urlString parameters:(NSDictionary *)parametersDic completionHandler:(void (^)(NSString * _Nullable, NSDictionary * _Nullable))handle{
    
    NSMutableDictionary *mutableParaDic = [[NSMutableDictionary alloc]initWithDictionary:parametersDic];
    
    [[self manager] POST:urlString parameters:mutableParaDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *resultDic = (NSDictionary *)responseObject;
            handle(nil,resultDic);
        }else{
            handle(@"数据格式异常",nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        handle(error.description,nil);
    }];
}

/**
统一处理返回的结果字典

@param resultDic 结果字典
@param success 结果字典表明请求成功，那么解析出数据字典让别人使用
@param failure 失败
*/

//大叶网-------------
+ (void)daYeJudgmentResultDic:(NSDictionary *)resultDic success:(void (^)(id dataObject))success doFailure:(void (^)(NSString *))failure{
    BOOL isSucess = resultDic;
    if (isSucess) {
        id dataObject = resultDic[@"data"];
        success(dataObject);
    }else{
        NSString *messageString = resultDic[@"msg"];
        failure(messageString);
    }
}

/**
 生成get请求的字符串
 
 @param orininalString 问号之前的原始请求url
 @param paramDic 参数：字符串：字符串 - 请确保这个，否则不要使用本方法快捷生成
 @return 拼接好的getUrl字符串
 */
+ (NSString *)p_creatUrlGetStringWithOriginalUrlString:(NSString *)orininalString param:(NSDictionary *)paramDic{
    __block NSString *resultString = [orininalString stringByAppendingString:@"?"];
    [paramDic enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *obj, BOOL * _Nonnull stop) {
        NSString *itemString = [NSString stringWithFormat:@"%@=%@&",key,obj];
        resultString = [resultString stringByAppendingString:itemString];
    }];
    resultString = [resultString substringToIndex:resultString.length - 1];
    return resultString;
}

@end
