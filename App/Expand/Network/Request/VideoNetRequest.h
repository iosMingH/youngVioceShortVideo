//
//  VideoNetRequest.h
//  App
//
//  Created by Pro on 2020/4/21.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import "SkNetRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface VideoNetRequest : SkNetRequest

@end

NS_ASSUME_NONNULL_END

//POST /shaoyin/video/getAliVideoStsAuth 获取STS信息
@interface SkNetAppGetSTSRequest : VideoNetRequest

@end

//POST /shaoyin/video/getAliShortVideoList 获取阿里短视频列表
@interface SkNetAppVideolistRequest : VideoNetRequest
@property (nonatomic, strong) NSString *pageSize;
@property (nonatomic, strong) NSString *pageNumber;
@property (nonatomic, strong) NSString *videoStatus;
@property (nonatomic, strong) NSString *startTime;
@property (nonatomic, strong) NSString *endTime;
@end

//POST  shaoyin/video/deleteAliVideo  删除阿里视频
@interface SkNetVideoDeleteAliVideoRequest : VideoNetRequest
@property (nonatomic, strong) NSString *videoIds;
@end

//POST  /shaoyin/video/getAliVideoUploadAuth 获取阿里视频上传凭证
@interface SkNetVideoGetAliVideoUploadAuthRequest : VideoNetRequest
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *fileName;
@property (nonatomic, strong) NSString *coverUrl;
@end

//POST /shaoyin/video/getImageUploadAuth  获取图片上传地址和凭证
@interface SkNetVideoGetImageUploadAuthRequest : VideoNetRequest

@end

//POST /shaoyin/video/refreshAliVideoUploadAuth   刷新视频上传凭证
@interface SkNetVideoRefreshAliVideoUploadAuthRequest : VideoNetRequest
@property (nonatomic, strong) NSString *videoId;
@end

//Post/video/api/submitAliVideoPersonAudit  审核视频
@interface SkNetSubmitAliVideoPersonAuditRequest : VideoNetRequest
@property (nonatomic, strong) NSString *videoStatus;
@property (nonatomic, strong) NSString *videoId;
@end

//GET /app/user/addUserCollectionList   用户添加喜欢视频
@interface SkNetAddUserCollectionListRequest : VideoNetRequest
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *vid;
@end

//GET /app/user/delUserCollectionList 用户删除喜欢视频
@interface SkNetdelUserCollectionListListRequest : VideoNetRequest
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *id;
@end
