//
//  MHShortVideoServerManager.h
//  App
//
//  Created by Pro on 2020/4/9.
//  Copyright © 2020 李焕明. All rights reserved.
//   视频业务server请求的管理类

#import <Foundation/Foundation.h>

@class AlivcQuVideoModel;
@class AlivcShortVideoLiveVideoModel;

NS_ASSUME_NONNULL_BEGIN

@interface MHShortVideoServerManager : NSObject

//大叶 获取STS  ===========

+ (void)dayeServerGetSTSWithToken:(NSString *)token success:(void(^)(NSString *accessKeyId, NSString *accessKeySecret, NSString *securityToken))success failure:(void (^)(NSString *errorString))failure;


//请求推荐的视频列表      大叶网=================

+ (void)dayeServerGetRecommendVideoListWithToken:(NSString *)token pageIndex:(NSInteger )index pageSize:(NSInteger)count lastEndVideoId:(NSString *__nullable)videoId success:(void(^)(NSArray <AlivcQuVideoModel *>*videoList,NSInteger allVideoCount))success failure:(void (^)(NSString *errorString))failure;


/**
 发布一个视频

 @param paramDic 视频模型类
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)dayeServerVideoPublishWithDic:(NSDictionary *)paramDic success:(void(^)(void))success failure:(void (^)(NSString *errorString))failure;


/**
 请求个人的视频列表
 
 @param token 用户token
 @param index 起始页
 @param count 页面条数
 @param videoId 本次查询的视频id所在的位置为起点，不包含此视频id，有值的时候index不起作用,此id是ID，数据库递增的标识
 @param success 成功
 @param failure 失败
 */
+ (void)dayeServerGetPersonalVideoListWithToken:(NSString *)token pageIndex:(NSInteger )index pageSize:(NSInteger)count lastEndVideoId:(NSString *__nullable)videoId success:(void(^)(NSArray <AlivcQuVideoModel *>* __nullable videoList,NSInteger allVideoCount))success failure:(void (^)(NSString *errorString))failure;

/**
 删除个人视频

 @param token token
 @param videId 视频id
 @param userId 用户id
 @param success 成功
 @param failure 失败
 */
+ (void)dayeServerDeletePersonalVideoWithToken:(NSString *)token videoId:(NSString *)videId userId:(NSString *)userId success:(void(^)(void))success failure:(void (^)(NSString *errorString))failure;


/**
GET /app/user/addUserCollectionList用户添加喜欢视频

 @param token token
 @param videId 视频id
 @param success 成功
 @param failure 失败
 */
+ (void)dayeAddUserCollectionListWithToken:(NSString *)token videoId:(NSString *)videId  success:(void(^)(void))success failure:(void (^)(NSString *errorString))failure;


/**
GET /app/user/delUserCollectionList用户删除喜欢视频

 @param token token
 @param videId 视频id
 @param success 成功
 @param failure 失败
 */
+ (void)dayeDelUserCollectionListWithToken:(NSString *)token videoId:(NSString *)videId  success:(void(^)(void))success failure:(void (^)(NSString *errorString))failure;

@end

NS_ASSUME_NONNULL_END
