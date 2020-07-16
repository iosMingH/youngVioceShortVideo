//
//  MHShortVideoUploadManager.h
//  App
//
//  Created by Pro on 2020/4/20.
//  Copyright © 2020 李焕明. All rights reserved.
//  上传管理器

#import <Foundation/Foundation.h>
#import <AliyunVideoSDKPro/AliyunPublishManager.h>

NS_ASSUME_NONNULL_BEGIN


@class AliyunUploadSVideoInfo;
@class MHShortVideoUploadManager;

typedef NS_ENUM(NSInteger,AlivcUploadStatus){
    AlivcUploadStatusSuccess = 0,
    AlivcUploadStatusUploading,
    AlivcUploadStatusFailure,
    AlivcUploadStatusCancel,
    AlivcUploadStatusPause
};

@protocol MHShortVideoUploadManagerDelegate <NSObject>

@required
/**
 上传状态回调

 @param manager manager
 @param newStatus 新的状态
 */
- (void)uploadManager:(MHShortVideoUploadManager *)manager uploadStatusChangedTo:(AlivcUploadStatus )newStatus;

/**
 上传进度回调

 @param manager manager
 @param progress 0-1
 */
- (void)uploadManager:(MHShortVideoUploadManager *)manager updateProgress:(CGFloat )progress;

@optional

/**
 上传完成回调

 @param manager manager
 @param vid 视频id
 @param imageUrl 封面url
 */
- (void)uploadManager:(MHShortVideoUploadManager *)manager succesWithVid:(NSString *)vid coverImageUrl:(NSString *)imageUrl;

@end
@interface MHShortVideoUploadManager : NSObject

/**
 单例 - 主要为了使用方便和模块间的低耦合

 @return 实例
 */
+ (instancetype)shared;

/**
 本次上传发生事情的回调代理
 */
@property (nonatomic, weak) id<MHShortVideoUploadManagerDelegate> managerDelegate;

/**
 设置上传信息
 
 @param imagePath 图片地址
 @param videoInfo 视频信息
 @param videoPath 视频路径
 */
- (void)setCoverImagePath:(NSString *)imagePath videoInfo:(AliyunUploadSVideoInfo *)videoInfo videoPath:(NSString *)videoPath;

/**
 开始上传
 */
- (void)startUpload;

/**
 上传 - 自带sts

 @param keyId keyId
 @param keySecret keySecret
 @param token token
 @return 成功或者失败
 */
//- (BOOL)startUploadWithKey:(NSString *)keyId secres:(NSString *)keySecret token:(NSString *)token;


/**
 暂停上传

 @return 是否成功
 */
- (int)pauseUpload;

/**
 继续上传

 @return 是否成功
 */
- (int)resumeUpload;

/**
 取消上传
 */
- (void)cancelUpload;


- (AlivcUploadStatus)currentStatus;

- (NSString *)coverImagePath;

@end



NS_ASSUME_NONNULL_END
