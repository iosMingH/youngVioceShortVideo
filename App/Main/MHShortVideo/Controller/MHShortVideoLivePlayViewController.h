//
//  MHShortVideoLivePlayViewController.h
//  App
//
//  Created by Pro on 2020/3/26.
//  Copyright © 2020 李焕明. All rights reserved.
//
#import "AlivcBaseViewController.h"
@class AlivcQuVideoModel;

NS_ASSUME_NONNULL_BEGIN

static NSString *MHNotificationDeleveVideoSuccess = @"MHDeleveVideoSuccess";


@interface MHShortVideoLivePlayViewController : AlivcBaseViewController


/**
 用于个人中心初始化播放控制器
 与首页的区别是数据源：推荐视频 VS 个人发布的视频
 @param videoList 视频列表
 @param startPlayIndex 开始播放的位置
 @return 播放控制器
 */
-(instancetype)initWithVideoList:(NSArray <AlivcQuVideoModel *>*)videoList
                  startPlayIndex:(NSInteger )startPlayIndex;

@end

NS_ASSUME_NONNULL_END
