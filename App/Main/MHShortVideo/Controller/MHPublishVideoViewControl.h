//
//  MHPublishVideoViewControl.h
//  App
//
//  Created by dayewang on 2020/7/27.
//  Copyright © 2020 李焕明. All rights reserved.
//


@class AliyunMediaConfig;

NS_ASSUME_NONNULL_BEGIN


@interface MHPublishVideoViewControl : CEBaseController
@property (strong, nonatomic) UIImage *coverImage;

/**
 短视频路径
 */
@property (nonatomic, strong) NSString *taskPath;

/**
 合成信息配置
 */
@property (nonatomic, strong) AliyunMediaConfig *config;
@end

NS_ASSUME_NONNULL_END
