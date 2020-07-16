//
//  SCFileTool.h
//  App
//
//  Created by mac on 2018/4/13.
//  Copyright © 2018年 HuanMingLi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCFileTool : NSObject
/**
 删除文件夹所有文件
 
 @param directoryPath 文件夹路径
 */
+ (void)removeDirectoryPath:(NSString *)directoryPath;

/**
 获取文件夹尺寸
 
 @param directoryPath 文件夹路径
 @param completion 文件夹尺寸
 */
+ (void)getFileSize:(NSString *)directoryPath completion:(void(^)(NSInteger totalSize))completion;
@end
