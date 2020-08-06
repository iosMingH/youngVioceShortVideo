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

//GET /app/GetSTS 获取STS信息 
@interface SkNetAppGetSTSRequest : VideoNetRequest
@property (nonatomic, strong) NSString *token;
@end

//GET /app/videolist 推荐视频列表
@interface SkNetAppVideolistRequest : VideoNetRequest
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *pageNumber;
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
