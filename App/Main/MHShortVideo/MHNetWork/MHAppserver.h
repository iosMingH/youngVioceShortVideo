//
//  MHAppserver.h
//  App
//
//  Created by Pro on 2020/4/9.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MHAppserver : NSObject

/**
 get请求的封装
 本应用所有的get请求最终都通过这个方法发起
 @param urlString 请求字符串
 @param handle 请求结果的处理代码块 errString不为空，则代表请求出错
 */
+ (void)getWithUrlString:(NSString *)urlString completionHandler:(void (^)(NSString *__nullable errString,NSDictionary *_Nullable resultDic))handle;


+ (void)getWithUrlString:(NSString *)urlString
              parameters:(id)parameters
       completionHandler:(void (^)(NSString *__nullable errString,NSDictionary *_Nullable resultDic))handle;
/**
 post请求的封装
 本应用所有的get请求最终都通过这个方法发起
 @param urlString 请求字符串
 @param parametersDic 参数
 @param handle 请求结果的处理代码块 errString不为空，则代表请求出错
 */
+ (void)postWithUrlString:(NSString *)urlString parameters:(NSDictionary *)parametersDic completionHandler:(void (^)(NSString *__nullable errString,NSDictionary *_Nullable resultDic))handle;

/**
统一处理返回的结果字典

@param resultDic 结果字典
@param success 结果字典表明请求成功，那么解析出数据字典让别人使用
@param failure 失败
*/

//大叶  =========
+ (void)daYeJudgmentResultDic:(NSDictionary *)resultDic success:(void (^)(id dataObject))success doFailure:(void (^)(NSString *))failure;


@end

NS_ASSUME_NONNULL_END
