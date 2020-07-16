//
//  SkSet.m
//  App
//
//  Created by 李焕明 on 16/5/25.
//  Copyright © 2016年 李焕明. All rights reserved.
//

#import "SkSet.h"

@implementation SkConfig
@end

@implementation SkSet

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

@end
