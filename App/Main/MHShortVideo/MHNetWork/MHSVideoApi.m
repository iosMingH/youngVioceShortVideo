//
//  MHSVideoApi.m
//  App
//
//  Created by Pro on 2020/4/20.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import "MHSVideoApi.h"
#import "AlivcDefine.h"
#import "AlivcMacro.h"

@implementation MHSVideoApi

//大叶网  -------------======== 获取图片凭证

+ (void)dayeGetImageUploadAuthWithToken:(NSString *)tokenString title:(NSString *)title filePath:(NSString *)filePath tags:(NSString *)tags handler:(void (^)(NSString * _Nullable, NSString * _Nullable, NSString * _Nullable, NSString * _Nullable, NSError * _Nullable))handler{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params addEntriesFromDictionary:@{
                                       @"imageType":@"cover",
                                       @"imageExt":filePath.lastPathComponent.pathExtension
                                       }];
    if (title) {
        [params addEntriesFromDictionary:@{@"title":title}];
    }
    if (tags) {
        [params addEntriesFromDictionary:@{@"tags":tags}];
    }
    
    
    NSString *getUrl = @"/app/getImageUploadAuth";
    AlivcOutputProductType type = kAlivcProductType;
    if (type == AlivcOutputProductTypeSmartVideo) {
        getUrl = @"/app/getImageUploadAuth";
        if (tokenString) {
            [params addEntriesFromDictionary:@{@"token":tokenString}];
        }
    }
 
    NSLog(@"============getUrl=%@============",getUrl);
       
         NSLog(@"============params=%@============",params);
    
    [self dayeGetWithPath:getUrl params:params completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
         NSLog(@"============responseObject=%@============",responseObject);
        if (error) {
            handler(nil, nil, nil, nil, error);
        }else {
            NSString *uploadAddress = [responseObject objectForKey:@"uploadAddress"];
            NSString *uploadAuth = [responseObject objectForKey:@"uploadAuth"];
            NSString *imageURL = [responseObject objectForKey:@"imageURL"];
            NSString *imageId = [responseObject objectForKey:@"imageId"];
            handler(uploadAddress, uploadAuth, imageURL, imageId, nil);
        }
    }];
}


//大叶 =================
+ (void)dayeGetVideoUploadAuthWithWithToken:(NSString *)tokenString title:(NSString *)title filePath:(NSString *)filePath coverURL:(NSString *)coverURL desc:(NSString *)desc tags:(NSString *)tags handler:(void (^)(NSString * _Nullable, NSString * _Nullable, NSString * _Nullable, NSError * _Nullable))handler{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params addEntriesFromDictionary:@{
                                       @"title":desc,
                                       @"fileName":filePath.lastPathComponent
                                       }];
    if (coverURL) {
        [params addEntriesFromDictionary:@{@"coverURL":coverURL}];
    }
    if (desc) {
        [params addEntriesFromDictionary:@{@"description":desc}];
    }
    if (tags) {
        [params addEntriesFromDictionary:@{@"tags":tags}];
    }
   
    NSString *getUrl = @"/app/getVideoUploadAuth";
    AlivcOutputProductType type = kAlivcProductType;
    if (type == AlivcOutputProductTypeSmartVideo) {
        getUrl = @"/app/getVideoUploadAuth";
        if (tokenString) {
            [params addEntriesFromDictionary:@{@"token":tokenString}];
        }
    }
    
      NSLog(@"============params=%@============",params);
    
    [self dayeGetWithPath:getUrl params:params completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        
             NSLog(@"============responseObject=%@============",responseObject);
        if (error) {
            handler(nil, nil, nil, error);
        }else {
            NSString *uploadAddress = [responseObject objectForKey:@"uploadAddress"];
            NSString *uploadAuth = [responseObject objectForKey:@"uploadAuth"];
            NSString *videoId = [responseObject objectForKey:@"videoId"];
            NSString *fileId = [responseObject objectForKey:@"id"];
            [FUCacheManager write:COMMON_VIDEO_FILEID value:fileId];
            [FUCacheManager write:COMMON_VIDEO_FILENAME value:filePath.lastPathComponent];
            handler(uploadAddress, uploadAuth, videoId, nil);
        }
    }];
}
// =================

+ (void)refreshVideoUploadAuthWithToken:(NSString *)tokenString videoId:(NSString *)videoId handler:(void (^)(NSString * _Nullable, NSString * _Nullable, NSError * _Nullable))handler{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (videoId) {
        [params addEntriesFromDictionary:@{@"videoId":videoId}];
    }
    
    
    NSString *getUrl = @"/demo/refreshVideoUploadAuth";
    AlivcOutputProductType type = kAlivcProductType;
    if (type == AlivcOutputProductTypeSmartVideo) {
        getUrl = @"/vod/refreshVideoUploadAuth";
        if (tokenString) {
            [params addEntriesFromDictionary:@{@"token":tokenString}];
        }
    }
    
    NSLog(@"============getUrl=%@============",getUrl);
       
         NSLog(@"============params=%@============",params);
    [self getWithPath:getUrl params:params completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
         NSLog(@"============responseObject=%@============",responseObject);
        if (error) {
            handler(nil, nil, error);
        }else {
            NSString *uploadAddress = [responseObject objectForKey:@"uploadAddress"];
            NSString *uploadAuth = [responseObject objectForKey:@"uploadAuth"];
            handler(uploadAddress, uploadAuth, nil);
        }
    }];
}




#pragma mark - Private Method

+ (void)getWithPath:(NSString *)path params:(NSDictionary *)params completionHandler:(void (^)(NSURLResponse *response, id responseObject,  NSError * error))completionHandler {
    
#warning 尊敬的客户，此Server服务只用于demo演示使用，我们不建议您将此演示接口用作线上环境，请自行搭建自己的Server服务，如何集成自己的Server服务详见文档：https://help.aliyun.com/document_detail/108783.html?spm=a2c4g.11186623.6.1075.a70a3a4895Qysq。
    NSMutableDictionary *mutableParaDic = [[NSMutableDictionary alloc]initWithDictionary:params];
    
    NSString *paramsString = [self getParamsString:mutableParaDic];
    NSString *urlString = [NSString
                    stringWithFormat:@"%@%@?%@", kAlivcQuUrlString, path, paramsString];
    NSLog(@"============urlString=%@============",urlString);
    NSURLSessionConfiguration *sessionConfiguration =
    [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *session =
    [NSURLSession sessionWithConfiguration:sessionConfiguration];
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest addValue:@"application/json"
      forHTTPHeaderField:@"Content-Type"];
    [urlRequest addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    NSDictionary *appInfo = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Name = [appInfo objectForKey:@"CFBundleDisplayName"];
    NSString *app_Version = [appInfo objectForKey:@"CFBundleShortVersionString"];
    app_Version = [app_Version stringByReplacingOccurrencesOfString:@"." withString:@""];
    NSString *bundleId =[NSBundle mainBundle].bundleIdentifier;
    
    [urlRequest setValue:app_Name forHTTPHeaderField:@"appName"];
    [urlRequest setValue:app_Version forHTTPHeaderField:@"appVersionCode"];
    [urlRequest setValue:bundleId forHTTPHeaderField:@"bundleId"];
    
    NSURLSessionDataTask *task =
    [session dataTaskWithRequest:urlRequest
               completionHandler:^(NSData *_Nullable data,
                                   NSURLResponse *_Nullable response,
                                   NSError *_Nullable error) {
                   if (error) {
                       if (completionHandler) {
                           completionHandler(response, nil, error);
                       }
                       return;
                   }
                   
                   if (data == nil) {
                       NSError *emptyError =
                       [[NSError alloc] initWithDomain:@"AliyunSVideoApi"
                                                  code:-10000
                                              userInfo:nil];
                       if (completionHandler) {
                           completionHandler(response, nil, emptyError);
                       }
                       return;
                   }
                   
                   id jsonObj = [NSJSONSerialization
                                 JSONObjectWithData:data
                                 options:NSJSONReadingAllowFragments
                                 error:&error];
                   if (error) {
                       completionHandler(response, nil, error);
                       return;
                   }
                   
                   NSInteger code = [[jsonObj objectForKey:@"code"] integerValue];
                   if (code != 200) {
                       NSError *error = [NSError errorWithDomain:@"AliyunSVideoApi" code:code userInfo:jsonObj];
                       if (completionHandler) {
                           completionHandler(response, nil, error);
                       }
                       return;
                   }
                   
                   if (completionHandler) {
                       completionHandler(response, [jsonObj objectForKey:@"data"], nil);
                   }
                   
               }];
    
    [task resume];
    
    
}

+ (void)dayeGetWithPath:(NSString *)path params:(NSDictionary *)params completionHandler:(void (^)(NSURLResponse *response, id responseObject,  NSError * error))completionHandler {
    
#warning 尊敬的客户，此Server服务只用于demo演示使用，我们不建议您将此演示接口用作线上环境，请自行搭建自己的Server服务，如何集成自己的Server服务详见文档：https://help.aliyun.com/document_detail/108783.html?spm=a2c4g.11186623.6.1075.a70a3a4895Qysq。
    NSMutableDictionary *mutableParaDic = [[NSMutableDictionary alloc]initWithDictionary:params];
    
    NSString *paramsString = [self getParamsString:mutableParaDic];
    NSString *urlString = [NSString
                    stringWithFormat:@"%@%@?%@", URL_BASIC, path, paramsString];
    NSLog(@"============urlString=%@============",urlString);
    NSURLSessionConfiguration *sessionConfiguration =
    [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *session =
    [NSURLSession sessionWithConfiguration:sessionConfiguration];
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest addValue:@"application/json"
      forHTTPHeaderField:@"Content-Type"];
    [urlRequest addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    NSDictionary *appInfo = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Name = [appInfo objectForKey:@"CFBundleDisplayName"];
    NSString *app_Version = [appInfo objectForKey:@"CFBundleShortVersionString"];
    app_Version = [app_Version stringByReplacingOccurrencesOfString:@"." withString:@""];
    NSString *bundleId =[NSBundle mainBundle].bundleIdentifier;
    
    [urlRequest setValue:app_Name forHTTPHeaderField:@"appName"];
    [urlRequest setValue:app_Version forHTTPHeaderField:@"appVersionCode"];
    [urlRequest setValue:bundleId forHTTPHeaderField:@"bundleId"];
    
    NSURLSessionDataTask *task =
    [session dataTaskWithRequest:urlRequest
               completionHandler:^(NSData *_Nullable data,
                                   NSURLResponse *_Nullable response,
                                   NSError *_Nullable error) {
        NSLog(@"==============data=%@===============",data);
                   if (error) {
                       if (completionHandler) {
                           completionHandler(response, nil, error);
                       }
                       return;
                   }
                   
                   if (data == nil) {
                       NSError *emptyError =
                       [[NSError alloc] initWithDomain:@"AliyunSVideoApi"
                                                  code:-10000
                                              userInfo:nil];
                       if (completionHandler) {
                           completionHandler(response, nil, emptyError);
                       }
                       return;
                   }
                   
                   id jsonObj = [NSJSONSerialization
                                 JSONObjectWithData:data
                                 options:NSJSONReadingAllowFragments
                                 error:&error];
                   if (error) {
                       completionHandler(response, nil, error);
                       return;
                   }
                   
                   NSInteger code = [[jsonObj objectForKey:@"code"] integerValue];
                   if (code != 1) {
                       NSError *error = [NSError errorWithDomain:@"AliyunSVideoApi" code:code userInfo:jsonObj];
                       if (completionHandler) {
                           completionHandler(response, nil, error);
                       }
                       return;
                   }
                   
                   if (completionHandler) {
                       completionHandler(response, [jsonObj objectForKey:@"data"], nil);
                   }
                   
               }];
    
    [task resume];
    
    
}


+ (NSString *)getParamsString:(NSDictionary *)params {
    NSMutableArray *parts = [NSMutableArray array];
    for (id key in params.allKeys) {
        id value = [params objectForKey:key];
        NSString *part = [NSString stringWithFormat:@"%@=%@", [self percentEncode:key], [self percentEncode:value]];
        [parts addObject: part];
    }
    
    NSArray<NSString *> *sortedArray = [parts sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    NSString *string = [sortedArray componentsJoinedByString:@"&"];
    return string;
}

+ (NSString *)percentEncode:(id)object {
    NSString *string = [NSString stringWithFormat:@"%@", object];
    
    NSString * const kAFCharactersGeneralDelimitersToEncode = @":#[]@?/"; // does not include "?" or "/" due to RFC 3986 - Section 3.4
    NSString * const kAFCharactersSubDelimitersToEncode = @"!$&'()*+,;=";
    NSMutableCharacterSet * allowedCharacterSet = [[NSCharacterSet URLQueryAllowedCharacterSet] mutableCopy];
    [allowedCharacterSet removeCharactersInString:[kAFCharactersGeneralDelimitersToEncode stringByAppendingString:kAFCharactersSubDelimitersToEncode]];
    
    
    NSString *percentstring = [string stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacterSet];
    NSString * plusReplaced = [percentstring stringByReplacingOccurrencesOfString:@"+" withString:@"%20"];
    NSString * starReplaced = [plusReplaced stringByReplacingOccurrencesOfString:@"*" withString:@"%2A"];
    NSString * waveReplaced = [starReplaced stringByReplacingOccurrencesOfString:@"%7E" withString:@"~"];
    return waveReplaced;
}
@end
