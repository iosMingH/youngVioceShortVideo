//
//  NSDictionary+DeleteAllNullValue.m
//  App
//
//  Created by mac on 2018/3/13.
//  Copyright © 2018年 HuanMingLi. All rights reserved.
//

#import "NSDictionary+DeleteAllNullValue.h"

@implementation NSDictionary (DeleteAllNullValue)
- (NSDictionary *)deleteAllNullValue{
    
    NSMutableDictionary *mutableDic = [[NSMutableDictionary alloc] init];
    for (NSString *keyStr in self.allKeys) {
        if ([[self objectForKey:keyStr] isEqual:[NSNull null]]) {
            [mutableDic setObject:@"" forKey:keyStr];
        }
        else{
            [mutableDic setObject:[self objectForKey:keyStr] forKey:keyStr];
        }
    }
    return mutableDic;
    
}
@end
