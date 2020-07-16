//
//  SkObject.h
//  App
//
//  Created by 李焕明 on 16/5/25.
//  Copyright © 2016年 李焕明. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SkObject : NSObject<NSCoding>

+ (instancetype)sharedInstance;
- (void)copyWithOtherObject:(SkObject *)pObject;

- (void)encodeWithCoder:(NSCoder *)aCoder;
- (id)initWithCoder:(NSCoder *)aDecoder;

@end
