//
//  PaySignModel.h
//  Test
//
//  Created by Pro on 2020/4/15.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PaySignModel : NSObject
@property(nonatomic,copy)NSString* appid;
@property(nonatomic,copy)NSString* noncestr;
@property(nonatomic,copy)NSString* package;
@property(nonatomic,copy)NSString* partnerid;
@property(nonatomic,copy)NSString* prepayid;
@property(nonatomic,copy)NSString* sign;
@property(nonatomic,assign)UInt32 timestamp;
@end

NS_ASSUME_NONNULL_END
