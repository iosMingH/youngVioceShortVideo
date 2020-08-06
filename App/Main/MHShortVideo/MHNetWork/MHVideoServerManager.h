//
//  MHVideoServerManager.h
//  App
//
//  Created by dayewang on 2020/8/6.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AlivcQuVideoModel;
@class AlivcShortVideoLiveVideoModel;

NS_ASSUME_NONNULL_BEGIN

// 获取STS  ===========
@interface MHVideoServerManager : NSObject
+ (void)dayeServerGetSTSSuccess:(void(^)(NSString *accessKeyId, NSString *accessKeySecret, NSString *securityToken))success failure:(void (^)(NSString *errorString))failure;


/// 请求推荐的视频列表
/// @param pageNumber 页码
/// @param pageSize 一页多少
/// @param videoStatus 视频状态
/// @param startTime 开始时间
/// @param endTime 结束时间
/// @param success 成功回调
/// @param failure 失败回调
+ (void)dayeServerGetAliShortVideoListWithPageNumber:(NSInteger )pageNumber pageSize:(NSInteger )pageSize videoStatus:(NSString *)videoStatus startTime:(NSString *)startTime endTime:(NSString *)endTime success:(void(^)(NSArray <AlivcQuVideoModel *>*videoList,NSInteger allVideoCount))success failure:(void (^)(NSString *errorString))failure;


/**
 获取图片上传的凭证

 @param tokenString 用户token
 @param title 标题
 @param filePath 图片路径
 @param tags tag-标签
 @param handler 回调
 */

+ (void)dayeGetImageUploadAuthHandler:(void (^)(NSString *_Nullable uploadAddress, NSString *_Nullable uploadAuth, NSString *_Nullable imageURL, NSString *_Nullable imageId))success failure:(void (^)(NSString *errorString))failure;



/**
 获取视频上传的凭证

 @param tokenString 用户token
 @param title 视频标题
 @param filePath 视频路径
 @param coverURL 封面图
 @param desc 描述
 @param tags tag-标签
 @param handler 回调
 */
+ (void)dayeGetVideoUploadAuthWithWithTitle:(NSString *)title
filePath:(NSString *)filePath
coverURL:(NSString * _Nullable)coverURL
    desc:(NSString *_Nullable)desc
    tags:(NSString * _Nullable)tags
 handler:(void (^)(NSString *_Nullable uploadAddress, NSString *_Nullable uploadAuth, NSString *_Nullable videoId))success failure:(void (^)(NSString *errorString))failure;


/**
 刷新视频上传凭证

 @param tokenString 用户凭证
 @param videoId 视频id
 @param handler 回调
 */
+ (void)refreshVideoUploadAuthWithVideoId:(NSString *)videoId
                                handler:(void (^)(NSString *_Nullable uploadAddress, NSString *_Nullable uploadAuth))success failure:(void (^)(NSString *errorString))failure;

@end

NS_ASSUME_NONNULL_END
