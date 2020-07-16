//
//  SkNetRequest.h
//  App
//
//  Created by 李焕明 on 16/5/25.
//  Copyright © 2016年 李焕明. All rights reserved.
//

#import <Foundation/Foundation.h>

//所有网络请求的类都放在此处

@interface SkNetRequest : NSObject
@property (nonatomic, strong) NSString *httpUrl;
@property (nonatomic, strong) NSString *httpMethod;
@property (nonatomic, strong) NSString *method;
@property (nonatomic, strong) id params;
@end

