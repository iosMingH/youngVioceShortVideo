//
//  SkPublicConfig.h
//  App
//
//  Created by 李焕明 on 16/5/25.
//  Copyright © 2016年 李焕明. All rights reserved.
//

#import "SkObject.h"

@interface SkPublicConfig : SkObject<NSCoding>

@property (nonatomic, strong) NSNumber      *number;
@property (nonatomic, strong) NSString      *string;
@property (nonatomic, strong) NSDate        *date;
@property (nonatomic, strong) NSArray       *array;
@property (nonatomic, strong) NSDictionary  *dictionary;

@end
