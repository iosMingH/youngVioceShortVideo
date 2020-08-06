//
//  MHVideoServerManager.m
//  App
//
//  Created by dayewang on 2020/8/6.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import "MHVideoServerManager.h"
#import "NSString+AlivcHelper.h"
#import "AlivcQuVideoModel.h"
#import "AlivcShortVideoLiveVideoModel.h"
#import "AlivcDefine.h"

@implementation MHVideoServerManager
// 获取STS  ===========
+ (void)dayeServerGetSTSSuccess:(void(^)(NSString *accessKeyId, NSString *accessKeySecret, NSString *securityToken))success failure:(void (^)(NSString *errorString))failure{
    
    SkNetAppGetSTSRequest *request = [[SkNetAppGetSTSRequest alloc]init];
    
    [SkNetApi request:request success:^(NSDictionary *pDic) {
         SkNetResponse *response = [SkNetResponse mj_objectWithKeyValues:pDic];
         if (response.code == 0) {
            //AccessKeyId
           NSString *keyIDString = response.data[@"accessKeyId"];
           //AccessKeySecret
           NSString *accessKeySecret = response.data[@"accessKeySecret"];
           //SecurityToken
           NSString *securityToken = response.data[@"securityToken"];
           if (keyIDString && accessKeySecret && securityToken) {
               success(keyIDString,accessKeySecret,securityToken);
               return ;
           }
        }else{
            TOAST(response.msg);
        }
    } failure:^(NSError *pError) {
        if (failure) {
            failure([pError localizedFailureReason]);
        }
    }];
    
}


//请求推荐的视频列表      大叶网=================
+ (void)dayeServerGetAliShortVideoListWithPageNumber:(NSInteger )pageNumber pageSize:(NSInteger )pageSize videoStatus:(NSString *)videoStatus startTime:(NSString *)startTime endTime:(NSString *)endTime success:(void(^)(NSArray <AlivcQuVideoModel *>*videoList,NSInteger allVideoCount))success failure:(void (^)(NSString *errorString))failure{
    
    SkNetAppVideolistRequest *request = [[SkNetAppVideolistRequest alloc]init];
    request.pageNumber = LSString(@"%ld",pageNumber);
    request.pageSize = LSString(@"%ld",pageSize);
    request.videoStatus = videoStatus;
    request.startTime = startTime;
    request.endTime = endTime;
    
    [SkNetApi request:request success:^(NSDictionary *pDic) {
        NSLog(@"pDic=%@",pDic);
         SkNetResponse *response = [SkNetResponse mj_objectWithKeyValues:pDic];
         if (response.code == 0) {
             NSDictionary *dataDic = response.data;
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
        }else{
            TOAST(response.msg);
        }
    } failure:^(NSError *pError) {
        if (failure) {
            failure([pError localizedFailureReason]);
        }
    }];
}


/**
 获取图片上传的凭证
 @param title 标题
 @param filePath 图片路径
 @param tags tag-标签
 @param handler 回调
 */

+ (void)dayeGetImageUploadAuthHandler:(void (^)(NSString *_Nullable uploadAddress, NSString *_Nullable uploadAuth, NSString *_Nullable imageURL, NSString *_Nullable imageId))success failure:(void (^)(NSString *errorString))failure{

    SkNetVideoGetImageUploadAuthRequest *request = [[SkNetVideoGetImageUploadAuthRequest alloc]init];
     [SkNetApi request:request success:^(NSDictionary *pDic) {
            SkNetResponse *response = [SkNetResponse mj_objectWithKeyValues:pDic];
            if (response.code == 0) {
                NSString *uploadAddress = [response.data objectForKey:@"uploadAddress"];
               NSString *uploadAuth = [response.data objectForKey:@"uploadAuth"];
               NSString *imageURL = [response.data objectForKey:@"imageURL"];
               NSString *imageId = [response.data objectForKey:@"imageId"];
               success(uploadAddress, uploadAuth, imageURL, imageId);
           }else{
               TOAST(response.msg);
           }
       } failure:^(NSError *pError) {
          failure([pError localizedFailureReason]);
       }];

}

/**
 获取视频上传的凭证
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
handler:(void (^)(NSString *_Nullable uploadAddress, NSString *_Nullable uploadAuth, NSString *_Nullable videoId))success failure:(void (^)(NSString *errorString))failure{

    SkNetVideoGetAliVideoUploadAuthRequest *request = [[SkNetVideoGetAliVideoUploadAuthRequest alloc]init];
    request.title = desc;
    request.fileName = filePath.lastPathComponent;
    request.coverUrl = coverURL;
    [SkNetApi request:request success:^(NSDictionary *pDic) {
        NSLog(@"pDic=%@",pDic);
        SkNetResponse *response = [SkNetResponse mj_objectWithKeyValues:pDic];
       if (response.code == 0) {
           NSString *uploadAddress = [response.data objectForKey:@"uploadAddress"];
           NSString *uploadAuth = [response.data objectForKey:@"uploadAuth"];
           NSString *videoId = [response.data objectForKey:@"videoId"];
          [FUCacheManager write:COMMON_VIDEO_FILENAME value:filePath.lastPathComponent];
            success(uploadAddress, uploadAuth, videoId);
      }else{
          TOAST(response.msg);
      }
    } failure:^(NSError *pError) {
        failure([pError localizedFailureReason]);
    }];
}

/**
 刷新视频上传凭证

 @param videoId 视频id
 @param handler 回调
 */
+ (void)refreshVideoUploadAuthWithVideoId:(NSString *)videoId
handler:(void (^)(NSString *_Nullable uploadAddress, NSString *_Nullable uploadAuth))success failure:(void (^)(NSString *errorString))failure{
    SkNetVideoRefreshAliVideoUploadAuthRequest *request = [[SkNetVideoRefreshAliVideoUploadAuthRequest alloc]init];
    request.videoId = videoId;
      [SkNetApi request:request success:^(NSDictionary *pDic) {
          NSLog(@"pDic=%@",pDic);
          SkNetResponse *response = [SkNetResponse mj_objectWithKeyValues:pDic];
         if (response.code == 0) {
             NSString *uploadAddress = [response.data objectForKey:@"uploadAddress"];
             NSString *uploadAuth = [response.data objectForKey:@"uploadAuth"];
              success(uploadAddress, uploadAuth);
        }else{
            TOAST(response.msg);
        }
      } failure:^(NSError *pError) {
          failure([pError localizedFailureReason]);
      }];
}

@end
