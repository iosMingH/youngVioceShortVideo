//
//  SkNetApi.h
//  App
//
//  Created by 李焕明 on 16/5/25.
//  Copyright © 2016年 李焕明. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "MJExtension.h"
#import "SkNetRequest.h"
#import "SkNetResponse.h"
#import "SkUser.h"

// api host   对应外网地址：http://27.154.234.10:52913/swagger/ui/index#/


@interface SkNetApi : NSObject
+ (void)request:(SkNetRequest *)param success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failue;

//
+ (void)POST_formData_request:(SkNetRequest *)param photoArray:(NSMutableArray *)phptoArray success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failue;

/** 获取unionId **/
+(void)reqWxUnionId:(NSString*)openid success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failue;

//获取用户个人信息（UnionID 机制） https://api.weixin.qq.com/sns/userinfo?access_token=ACCESS_TOKEN&openid=OPENID
+(void)reqWxPersonalInfo:(NSString*)openid accessToken:(NSString *)accessToken success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failue;

@end
