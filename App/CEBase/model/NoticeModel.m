//
//  NoticeModel.m
//  App
//
//  Created by mac on 2017/11/16.
//  Copyright © 2017年 HuanMingLi. All rights reserved.
//

#import "NoticeModel.h"

@implementation NoticeModel


- (instancetype)init:(NSInteger)code msg:(NSString*)message data:(id)data
{
    self = [super init];
    if (self) {
        self.code = code;
        self.data = data;
        self.message = message;
    }
    return self;
}

@end
