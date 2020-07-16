//
//  NoticeModel.h
//  App
//
//  Created by mac on 2017/11/16.
//  Copyright © 2017年 HuanMingLi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NoticeModel : NSObject

- (instancetype)init:(NSInteger)code msg:(NSString*)message data:(id)data;

@property(nonatomic,assign)NSInteger code;

@property(nonatomic,copy)NSString* message;

@property(nonatomic,strong)id data;

@end
