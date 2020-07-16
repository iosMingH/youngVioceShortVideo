//
//  SkUser.h
//  App
//
//  Created by 李焕明 on 16/5/25.
//  Copyright © 2016年 李焕明. All rights reserved.
//

#import "SkObject.h"

@interface SkUser : SkObject<NSCoding>
@property (nonatomic, copy) NSString *memberId;
@end
