//
//  SkCmmObject.m
//  App
//
//  Created by 李焕明 on 16/5/25.
//  Copyright © 2016年 李焕明. All rights reserved.
//

#import "SkCmmObject.h"

@implementation SkCmmObject

+ (instancetype)sharedInstance
{
    NSString *className = [NSString stringWithFormat:@"%@", [self class] ];
    Class class = NSClassFromString( className );
    static dispatch_once_t once;
    static id singleton;
    dispatch_once(&once, ^ {
        singleton = [[class alloc] init];
    });
    return singleton;
}

- (id)init
{
    self = [super init];
    if (self) {
        _mSkAnimate = YES;//默认动画开启
        //        _mSkClassName = @"WebContentViewController";
    }
    return self;
}

@end
