//
//  PaysignModel.h
//  App
//
//  Created by 吴智民 on 2017/10/25.
//  Copyright © 2017年 HuanMingLi. All rights reserved.
//  支付签名模型

#import <Foundation/Foundation.h>

@interface PaysignModel : NSObject

@property(nonatomic,copy)NSString* appid;
@property(nonatomic,copy)NSString* noncestr;
@property(nonatomic,copy)NSString* package;
@property(nonatomic,copy)NSString* partnerid;
@property(nonatomic,copy)NSString* prepayid;
@property(nonatomic,copy)NSString* sign;
@property(nonatomic,assign)UInt32 timestamp;

//appid = wxd74bc18978752573;
//noncestr = 1633a03df4cb4221ac8e003a6b9ed4c0;
//package = "Sign=WXPay";
//partnerid = 1488016032;
//prepayid = wx20171025103010a3753c958c0783538606;
//sign = 806031EE98C1B22E809D0E6965B9F5CC;
//timestamp = 1508898610638;

@end
