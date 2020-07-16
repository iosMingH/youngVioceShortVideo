//
//  UserNetRequest.m
//  WddDcc
//
//  Created by 李焕明 on 16/9/6.
//  Copyright © 2016年 李焕明. All rights reserved.
//

#import "UserNetRequest.h"

@implementation UserNetRequest
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.httpUrl = @"";
//        self.ProjectCode = PROJECT_CODE;
    }
    return self;
}
@end


@implementation SkNetLoginRequest
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.method = @"base/login";
        
    }
    return self;
}
@end

@implementation SkNetCollectRequest
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.method = @"collect";
        
    }
    return self;
}
@end

//pPOST / 解密
@implementation SkNetDecryptRequest
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.method = @"getEncrypt";
        self.httpMethod = @"POST";
        
    }
    return self;
}
@end


//POST / 解密
@implementation SkNetencryptRequest
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.method = @"putEncrypt";
        self.httpMethod = @"POST";
        
    }
    return self;
}
@end



//获取验证码 POST
@implementation SkNetGetSortMsgCodeRequest
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.method = @"base/getSortMsgCode";
        self.httpMethod = @"POST";
        
    }
    return self;
}
@end


//注册 POST
@implementation SkNetRegisterRequest
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.method = @"base/register";
        self.httpMethod = @"POST";
        
    }
    return self;
}
@end
