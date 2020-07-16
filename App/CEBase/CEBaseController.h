//
//  CEBaseController.h
//  App
//
//  Created by mac on 2017/11/16.
//  Copyright © 2017年 HuanMingLi. All rights reserved.
//
//  控制器基类
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef void(^CEBaseControllerBlock) (id response);

@interface CEBaseController : UIViewController
@property (nonatomic ,copy) CEBaseControllerBlock Block;//回传
@property (nonatomic ,strong) id UserInfo; //传参

/**
 是否隐藏navbar  yes隐藏
 */
@property(nonatomic,assign)BOOL isNavbarShow;


-(void)loadData;
-(void)initView;
-(void)initLayout;

-(instancetype)init:(id)parameter;
-(void)initData:(id)parameter;


/** 通知事件 **/
-(void)addNotificationWith:(SEL)selector name:(NSString *)sbuff;
-(void)eventNotice:(NSNotification *)info;
-(void)delNotificationWith:(NSString *)name;
-(UIButton *)addLeftButtonImage:(NSString*)path Action:(SEL)action;
-(UIButton *)addNavLeftBtn:(NSString*)str image:(NSString*)name action:(SEL)action;
/** 添加按钮 **/
-(UIButton *)addRightButtonImage:(NSString*)path Action:(SEL)action;
-(UIButton *)addNavRightBtnTitle:(NSString*)str action:(SEL)action;
-(void)addNavRightBtn:(NSString*)str image:(NSString*)name action:(SEL)action;
/** 界面返回 **/
-(void)popCurrentNormalViewAction:(BOOL)action;
-(void)popCurrentToRootViewAction:(BOOL)action;
-(void)dismissCurrentModalWithAction:(BOOL)action;

/** 界面跳转 **/
-(void)onPushViewController:(UIViewController*)vc animated:(BOOL)animate;

@end

