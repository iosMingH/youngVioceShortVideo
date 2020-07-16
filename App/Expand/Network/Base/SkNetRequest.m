//
//  SkNetRequest.m
//  App
//
//  Created by 李焕明 on 16/5/25.
//  Copyright © 2016年 李焕明. All rights reserved.
//

#import "SkNetRequest.h"

@implementation SkNetRequest

- (id)init
{
    self = [super init];
    if (self) {
        self.httpUrl = @"";
        self.method = @"";
        self.httpMethod = @"GET";
    }
    return self;
}
@end

