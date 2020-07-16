//
//  MHPublishQuViewControl.h
//  App
//
//  Created by Pro on 2020/4/20.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import "AlivcKeyboardManageViewController.h"

@class AliyunMediaConfig;

NS_ASSUME_NONNULL_BEGIN

@interface MHPublishQuViewControl : AlivcBaseViewController

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
