//
//  SCPopTool.h
//  App
//
//  Created by mac on 2018/4/27.
//  Copyright © 2018年 HuanMingLi. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  关闭按钮的位置
 */
typedef NS_ENUM(NSInteger, ScButtonPositionType) {
    /**
     *  无
     */
    ScButtonPositionTypeNone = 0,
    /**
     *  左上角
     */
    ScButtonPositionTypeLeft = 1 << 0,
    /**
     *  右上角
     */
    ScButtonPositionTypeRight = 2 << 0
};
/**
 *  蒙板的背景色
 */
typedef NS_ENUM(NSInteger, ScShadeBackgroundType) {
    /**
     *  渐变色
     */
    ScShadeBackgroundTypeGradient = 0,
    /**
     *  固定色
     */
    ScShadeBackgroundTypeSolid = 1 << 0
};

typedef void(^completeBlock)(void);

@interface SCPopTool : NSObject
@property (strong, nonatomic) UIColor *popBackgroudColor;//弹出视图的背景色
@property (assign, nonatomic) BOOL tapOutsideToDismiss;//点击蒙板是否弹出视图消失
@property (assign, nonatomic) ScButtonPositionType closeButtonType;//关闭按钮的类型
@property (assign, nonatomic) ScShadeBackgroundType shadeBackgroundType;//蒙板的背景色

/**
 *  创建一个实例
 *
 *  @return CHWPopTool
 */
+ (SCPopTool *)sharedInstance;
- (void)showWithMainView:(UIView *)mainView PresentView:(UIView *)presentView animated:(BOOL)animated;
/**
 *  关闭弹出视图
 *
 *  @param complete complete block
 */
- (void)close;
@end
