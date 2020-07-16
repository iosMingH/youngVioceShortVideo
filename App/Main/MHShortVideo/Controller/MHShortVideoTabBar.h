//
//  MHShortVideoTabBar.h
//  App
//
//  Created by Pro on 2020/6/19.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import <UIKit/UIKit.h>

//进入弹层状态的通知
static NSString *AlivcNotificationQuPlay_EnterMask = @"AlivcNotificationQuPlay_EnterMask";
//退出弹层状态的通知
static NSString *AlivcNotificationQuPlay_QutiMask = @"AlivcNotificationQuPlay_QutiMask";

@class MHShortVideoTabBar;

NS_ASSUME_NONNULL_BEGIN

@interface MHShortVideoTabBar : UITabBar
/**
 中间凸起的按钮
 */
@property (nonatomic, strong) UIButton *centerBtn;

@end

NS_ASSUME_NONNULL_END
