//
//  UserNetRequest.h
//  WddDcc
//
//  Created by 李焕明 on 16/9/6.
//  Copyright © 2016年 李焕明. All rights reserved.
//

#import "SkNetRequest.h"
@interface UserNetRequest : SkNetRequest
@property (nonatomic, strong) NSString *ProjectCode;
@end

//get / 登录
@interface SkNetLoginRequest : UserNetRequest
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *password;
@end

//get / 登录
@interface SkNetCollectRequest : UserNetRequest
@property (nonatomic, strong) NSString *token;
@end

//pPOST / 解密
@interface SkNetDecryptRequest : UserNetRequest

@end


//POST / 解密
@interface SkNetencryptRequest : UserNetRequest
@property (nonatomic, copy) NSString *source;
@property (nonatomic, copy) NSString *encryptStr;
@end


//获取验证码 POST
@interface SkNetGetSortMsgCodeRequest : UserNetRequest
@property (nonatomic, copy) NSString *mobileNo;
@end

//注册 POST
@interface SkNetRegisterRequest : UserNetRequest
@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *code;
@end

