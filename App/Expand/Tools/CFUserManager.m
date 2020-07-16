//
//  CFUserManager.m
//  App
//
//  Created by mac on 2017/11/16.
//  Copyright © 2017年 HuanMingLi. All rights reserved.
//
#import "CFUserManager.h"

static CFUserManager * manager = nil;

@implementation CFUserManager

+ (CFUserManager *)sharedManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[CFUserManager alloc] init];
    });
    return manager;
}

@end
