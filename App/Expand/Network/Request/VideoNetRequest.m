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

//GET /app/GetSTS 获取STS信息
@implementation SkNetAppGetSTSRequest
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.method = @"app/GetSTS";
    }
    return self;
}

@end

//GET /app/videolist 推荐视频列表
@implementation SkNetAppVideolistRequest
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.method = @"app/videolist";
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
        self.method = @"video/api/submitAliVideoPersonAudit";
        self.httpMethod = @"POST";
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

