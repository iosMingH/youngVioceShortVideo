//
//  VideoNetRequest.m
//  App
//
//  Created by Pro on 2020/4/21.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import "VideoNetRequest.h"

@implementation VideoNetRequest
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.httpUrl = @"";
//        self.ProjectCode = PROJECT_CODE;
    }
    return self;
}
@end

//POST /shaoyin/video/getAliVideoStsAuth 获取STS信息
@implementation SkNetAppGetSTSRequest
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.method = @"video/getAliVideoStsAuth";
    }
    return self;
}

@end

//POST /video/getAliShortVideoList 获取阿里短视频列表
@implementation SkNetAppVideolistRequest
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.method = @"video/getAliShortVideoList";
    }
    return self;
}

@end

//POST  shaoyin/video/deleteAliVideo  删除阿里视频
@implementation SkNetVideoDeleteAliVideoRequest
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.method = @"video/deleteAliVideo";
    }
    return self;
}

@end

//POST  /shaoyin/video/getAliVideoUploadAuth 获取阿里视频上传凭证
@implementation SkNetVideoGetAliVideoUploadAuthRequest
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.method = @"video/getAliVideoUploadAuth";
    }
    return self;
}

@end


//POST /shaoyin/video/getImageUploadAuth  获取图片上传地址和凭证
@implementation SkNetVideoGetImageUploadAuthRequest
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.method = @"video/getImageUploadAuth";
    }
    return self;
}
@end

//POST /shaoyin/video/refreshAliVideoUploadAuth   刷新视频上传凭证
@implementation SkNetVideoRefreshAliVideoUploadAuthRequest
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.method = @"video/refreshAliVideoUploadAuth";
    }
    return self;
}
@end



//Post   /video/api/submitAliVideoPersonAudit  审核视频

@implementation SkNetSubmitAliVideoPersonAuditRequest
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.method = @"video/submitAliVideoPersonAudit";
    }
    return self;
}

@end

//GET /app/user/addUserCollectionList   用户添加喜欢视频
@implementation SkNetAddUserCollectionListRequest
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.method = @"app/user/addUserCollectionList";
    }
    return self;
}
@end

//GET /app/user/delUserCollectionList 用户删除喜欢视频
@implementation SkNetdelUserCollectionListListRequest
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.method = @"app/user/delUserCollectionList";
    }
    return self;
}
@end

