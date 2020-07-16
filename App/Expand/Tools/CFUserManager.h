//
//  CFUserManager.h
//  App
//
//  Created by mac on 2017/11/16.
//  Copyright © 2017年 HuanMingLi. All rights reserved.
//

//  用户管理

#import <Foundation/Foundation.h>

@interface CFUserManager : NSObject

+ (CFUserManager *)sharedManager;

//登录成功返回
//"isLogin": true,
//"isPracticed": false,
@property (nonatomic, copy) NSString *account;  // = 2108;
@property (nonatomic, copy) NSString *branchId; // = 0;
@property (nonatomic, copy) NSString *bumenId; //= 0;
@property (nonatomic, copy) NSString *companyId; //= 1;
@property (nonatomic, copy) NSString *deviceSn;  // = "";
@property (nonatomic, copy) NSString *erpUserRoles; // = 100;
@property (nonatomic, copy) NSString *fullName;  // = test;
@property (nonatomic, copy) NSString *isAdmin;  //= 0;
@property (nonatomic, copy) NSString *isLogin;  // = 1;
@property (nonatomic, copy) NSString *isPracticed;  // = 0;
@property (nonatomic, copy) NSString *isSuper; // 0;
@property (nonatomic, copy) NSString *loginTime; // = "2018-03-14 14:40:43";
@property (nonatomic, copy) NSString *machineSn; // = "";
@property (nonatomic, copy) NSString *photo;  // = "<null>";
@property (nonatomic, copy) NSString *storeId; // = "";
//@property (nonatomic, copy) NSString *storeUserRoles; // =     ();
@property (nonatomic, copy) NSString *token; // = 17dfd2028c024d8596eedfb8989288b2;
@property (nonatomic, copy) NSString *userCode; // = 2108;
@property (nonatomic, copy) NSString *userID;  // = ace1b203e4af4275accccd4451798725;

@end
