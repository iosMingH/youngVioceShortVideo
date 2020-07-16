//
//  FUProgressHUD.h
//  App
//
//  Created by mac on 2017/11/16.
//  Copyright © 2017年 HuanMingLi. All rights reserved.
//


#import <Foundation/Foundation.h>
// 单例
#define FUPROGRESS_HUD [FUProgressHUD Instance]

@interface FUProgressHUD : NSObject

+(instancetype) Instance;


/**
 警告
 */
-(void)info:(NSString*)message;
/**
 成功
 */
-(void)success:(NSString*)message;
/**
 错误
 */
-(void)error:(NSString*)message;

-(void)loading:(NSString*)message;

- (void)show;

-(void)complete;

@end
