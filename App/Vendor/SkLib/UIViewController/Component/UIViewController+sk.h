//
//  UIViewController+sk.h
//  App
//
//  Created by 李焕明 on 16/5/26.
//  Copyright © 2016年 李焕明. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (SK)
#warning  运行时 改变一下方法 做一些切面编程比如 统计 等等

//广播使用
@property (nonatomic, strong) NSDictionary *notification;
//通用事件
- (void)backAction;
- (void)doubleAction;

//通知事件
- (void)NC_add;
- (void)NC_remove;
- (void)NC_safe;

@end
