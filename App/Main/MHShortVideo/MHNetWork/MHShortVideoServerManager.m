//
//  MHShortVideoServerManager.m
//  App
//
//  Created by Pro on 2020/4/9.
//  Copyright © 2020 李焕明. All rights reserved.
//   视频业务server请求的管理类

#import "MHShortVideoServerManager.h"
#import "MHAppserver.h"
#import "NSString+AlivcHelper.h"
#import "AlivcQuVideoModel.h"
#import "AlivcShortVideoLiveVideoModel.h"
#import "AlivcDefine.h"

@implementation MHShortVideoServerManager

#pragma mark - 重复代码抽象 - 供本类调用

/**
 get请求统一处理

 @param urlString get的url
 @param success 成功的结果回调
 @param failure 失败的结果回调
 */
//大叶网=================
+ (void)daye_getWithUrlString:(NSString *)urlString success:(void (^)(id data))success failure:(void (^)(NSString *errDes))failure{
    [MHAppserver getWithUrlString:urlString completionHandler:^(NSString * _Nullable errString, NSDictionary * _Nullable resultDic) {
        if (errString) {
            failure([@"网络错误" localString]);
        }else{
            [MHAppserver daYeJudgmentResultDic:resultDic success:^(id dataObject) {
                NSLog(@"dataObject===%@",dataObject);
                success(dataObject);
            } doFailure:^(NSString * errorStr) {
                failure(errorStr);
            }];
        }
    }];
}

/**
 post请求统一处理

 @param urlString post的url字符串
 @param paramDic 参数
 @param success 成功的结果回调
 @param failure 失败的结果回调
 */
+ (void)p_postWithUrlString:(NSString *)urlString params:(NSDictionary *)paramDic success:(void (^)(id data))success failure:(void (^)(NSString *errDes))failure{
    
  
    [MHAppserver postWithUrlString:urlString parameters:paramDic completionHandler:^(NSString * _Nullable errString, NSDictionary * _Nullable resultDic) {
        if (errString) {
            failure([@"网络错误" localString]);
        }else{
            [MHAppserver daYeJudgmentResultDic:resultDic success:^(id dataObject) {
                success(dataObject);
            } doFailure:^(NSString * errorStr) {
                failure(errorStr);
            }];
        }
    }];
}

/**
 生成get请求的字符串

 @param orininalString 问号之前的原始请求url
 @param paramDic 参数：字符串：字符串 - 请确保这个，否则不要使用本方法快捷生成
 @return 拼接好的getUrl字符串
 */
+ (NSString *)p_creatUrlGetStringWithOriginalUrlString:(NSString *)orininalString param:(NSDictionary *)paramDic{
    __block NSString *resultString = [orininalString stringByAppendingString:@"?"];
    [paramDic enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *obj, BOOL * _Nonnull stop) {
        NSString *itemString = [NSString stringWithFormat:@"%@=%@&",key,obj];
        resultString = [resultString stringByAppendingString:itemString];
    }];
    resultString = [resultString substringToIndex:resultString.length - 1];
    return resultString;
}


//获获取播放的sts校验数据  大叶网=========================
+ (void)dayeServerGetSTSWithToken:(NSString *)token success:(void (^)(NSString * _Nonnull, NSString * _Nonnull, NSString * _Nonnull))success failure:(void (^)(NSString * _Nonnull))failure{
    NSString *urlString = @"/video/getAliVideoStsAuth";
     NSString *allUrlString = [NSString stringWithFormat:@"%@%@?token=%@",URL_BASIC,urlString,token];
    NSLog(@"allUrlString=%@",allUrlString);
    [self daye_getWithUrlString:allUrlString success:^(id data) {

        if ([data isKindOfClass:[NSDictionary class]]) {
            //
            NSDictionary *dataDic = (NSDictionary *)data;
            //AccessKeyId
            NSString *keyIDString = dataDic[@"accessKeyId"];
            //AccessKeySecret
            NSString *accessKeySecret = dataDic[@"accessKeySecret"];
            //SecurityToken
            NSString *securityToken = dataDic[@"securityToken"];
            if (keyIDString && accessKeySecret && securityToken) {
                success(keyIDString,accessKeySecret,securityToken);
                return ;
            }
        }
        failure([@"数据解析错误" localString]);
    } failure:^(NSString *errDes) {
        failure(errDes);
    }];
}
//=========================

//推荐的视频列表  大叶网==================
+ (void)dayeServerGetRecommendVideoListWithToken:(NSString *)token pageIndex:(NSInteger)index pageSize:(NSInteger)count lastEndVideoId:(NSString *)videoId success:(void (^)(NSArray<AlivcQuVideoModel *> * _Nonnull,NSInteger))success failure:(void (^)(NSString * _Nonnull))failure{
//    NSString *urlString = @"/app/videolist";
    NSString *urlString = @"/video/getAliShortVideoList";
    [self dayeServerVideoListWithUrlString:urlString token:token pageIndex:index pageSize:count lastEndVideoId:videoId success:success failure:failure];
}


//发布视频  大叶网==================
+ (void)dayeServerVideoPublishWithDic:(NSDictionary *)paramDic success:(void (^)(void))success failure:(void (^)(NSString * _Nonnull))failure{
    NSString *urlString = @"/app/user/userAddVideoGo";
    NSString *allUrlString = [NSString stringWithFormat:@"%@%@",URL_BASIC,urlString];
    [self p_postWithUrlString:allUrlString params:paramDic success:^(id data) {
        success();
    } failure:^(NSString *errDes) {
        failure(errDes);
    }];
//     NSString *resultUrlString = [self p_creatUrlGetStringWithOriginalUrlString:allUrlString param:paramDic];
//    NSLog(@"resultUrlString=%@",resultUrlString);
//    [self daye_getWithUrlString:resultUrlString success:^(id data) {
//        NSLog(@"=============data============%@",data);
//        success();
//    } failure:^(NSString *errDes) {
//         failure(errDes);
//    }];
}

//个人中心的视频列表
+ (void)dayeServerGetPersonalVideoListWithToken:(NSString *)token pageIndex:(NSInteger)index pageSize:(NSInteger)count lastEndVideoId:(NSString *)videoId success:(void (^)(NSArray<AlivcQuVideoModel *> * _Nullable,NSInteger))success failure:(void (^)(NSString * _Nonnull))failure{
    if (!token) {
        failure(@"登录失败");
        return;
    }
    NSString *urlString = @"/app/user/getUserVideoList";
    [self dayeServerVideoListWithUrlString:urlString token:token pageIndex:index pageSize:count lastEndVideoId:videoId success:success failure:failure];
}



//查询视频列表  d大叶网 ======================
+ (void)dayeServerVideoListWithUrlString:(NSString *)urlString token:(NSString *)token pageIndex:(NSInteger)index pageSize:(NSInteger)count lastEndVideoId:(NSString *)videoId success:(void (^)(NSArray<AlivcQuVideoModel *> * _Nonnull,NSInteger))success failure:(void (^)(NSString * _Nonnull))failure{
    
    NSString *allUrlString = [NSString stringWithFormat:@"%@%@",URL_BASIC,urlString];
    NSString *indexString = [NSString stringWithFormat:@"%ld",(long)index];
    NSString *countString = [NSString stringWithFormat:@"%ld",(long)count];
    
//    NSDictionary *paramDic = @{@"token":token,@"pageNumber":indexString,@"pageSize":countString};
     NSDictionary *paramDic = @{@"videoStatus":@"Normal",@"pageNumber":indexString,@"pageSize":countString};
    
//    NSDictionary *paramDic = @{@"token":token,@"pageNumber":indexString};
    
    NSMutableDictionary *mDic = [[NSMutableDictionary alloc]initWithDictionary:paramDic];
    if (videoId) {
        [mDic setObject:videoId forKey:@"id"];
    }
    
    NSString *resultUrlString = [self p_creatUrlGetStringWithOriginalUrlString:allUrlString param:mDic];
    [self daye_getWithUrlString:resultUrlString success:^(id data) {
        NSLog(@"data=%@",data);
        if ([data isKindOfClass:[NSDictionary class]]) {
            //
            NSDictionary *dataDic = (NSDictionary *)data;
            NSArray *dics = dataDic[@"list"];
            NSInteger totalCount = [dataDic[@"total"]integerValue];
            if (dics.count) {
                NSMutableArray *tempMArray = [[NSMutableArray alloc]initWithCapacity:dics.count];
                [dics enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if ([obj isKindOfClass:[NSDictionary class]]) {
                        AlivcQuVideoModel *model = [[AlivcQuVideoModel alloc]initWithDic:(NSDictionary *)obj];
                        [tempMArray insertObject:model atIndex:idx];
                    }
                }];
                NSArray *resultArray = [[NSArray alloc]initWithArray:tempMArray];
                success(resultArray,totalCount);
                return ;
            }else{
                success([NSArray array],0);
                return ;
            }
        }
        failure([@"数据解析错误" localString]);
    } failure:^(NSString *errDes) {
        failure(errDes);
    }];
}
//============================

//删除个人视频
+ (void)dayeServerDeletePersonalVideoWithToken:(NSString *)token videoId:(NSString *)videId userId:(NSString *)userId success:(void (^)(void))success failure:(void (^)(NSString * _Nonnull))failure{
//    NSString *urlString = @"/app/user/userDelVideo";
     NSString *urlString = @"/video/deleteAliVideo";
    NSString *allUrlString = [NSString stringWithFormat:@"%@%@",URL_BASIC,urlString];
     NSDictionary *paramDic = @{@"videoIds":videId};
    NSString *resultUrlString = [self p_creatUrlGetStringWithOriginalUrlString:allUrlString param:paramDic];
        NSLog(@"resultUrlString=%@",resultUrlString);
    [self daye_getWithUrlString:resultUrlString success:^(id data) {
        success();
    } failure:^(NSString *errDes) {
         failure(errDes);
    }];
}

//GET /app/user/addUserCollectionList用户添加喜欢视频
+ (void)dayeAddUserCollectionListWithToken:(NSString *)token videoId:(NSString *)videId success:(void (^)(void))success failure:(void (^)(NSString * _Nonnull))failure{
    NSString *urlString = @"/app/user/addUserCollectionList";
    NSString *allUrlString = [NSString stringWithFormat:@"%@%@",URL_BASIC,urlString];
     NSDictionary *paramDic = @{@"token":token,@"vid":videId};
    NSString *resultUrlString = [self p_creatUrlGetStringWithOriginalUrlString:allUrlString param:paramDic];
    [self daye_getWithUrlString:resultUrlString success:^(id data) {
        NSLog(@"data=%@",data);
             success();
    } failure:^(NSString *errDes) {
         failure(errDes);
    }];
}

//GET /app/user/delUserCollectionList用户删除喜欢视频
+ (void)dayeDelUserCollectionListWithToken:(NSString *)token videoId:(NSString *)videId success:(void (^)(void))success failure:(void (^)(NSString * _Nonnull))failure{
    NSString *urlString = @"/app/user/delUserCollectionList";
    NSString *allUrlString = [NSString stringWithFormat:@"%@%@",URL_BASIC,urlString];
     NSDictionary *paramDic = @{@"token":token,@"vid":videId};
    NSString *resultUrlString = [self p_creatUrlGetStringWithOriginalUrlString:allUrlString param:paramDic];
    [self daye_getWithUrlString:resultUrlString success:^(id data) {
        success();
    } failure:^(NSString *errDes) {
         failure(errDes);
    }];
}

@end
