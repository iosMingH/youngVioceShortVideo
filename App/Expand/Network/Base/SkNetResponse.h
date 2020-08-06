//
//  SkNetResponse.h
//  App
//
//  Created by 李焕明 on 16/5/26.
//  Copyright © 2016年 李焕明. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SkCmmObject.h"

//所有网络返回的类都放置到此处

@interface SkNetResponse : SkCmmObject
@property (nonatomic, assign) NSInteger code;//返回码
@property (nonatomic, strong) NSString *msg;
@property (nonatomic, strong) NSDictionary *data;
@end


