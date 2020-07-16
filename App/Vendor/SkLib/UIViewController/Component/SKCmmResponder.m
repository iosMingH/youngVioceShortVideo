//
//  SKCmmResponder.m
//  App
//
//  Created by 李焕明 on 16/5/25.
//  Copyright © 2016年 李焕明. All rights reserved.
//

#import "SKCmmResponder.h"
#import "Macro+SK.h"

@implementation SKCmmResponder

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self DATA_init_component];
        [self UI_init_component];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame percentage:(float)per
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _percentage = per;
        [self DATA_init_component];
        [self UI_init_component];
    }
    return self;
}

- (void)setObject:(id)object
{
    if ( _object != object) {
        _object = object;
    }
}

+ (float)cmmHeightWithWidth:(float)pWidth param:(id)param font:(UIFont *)font
{
    return .0f;
}
+ (float)cmmHeightWithWidth:(float)pWidth param:(id)param
{
    return .0f;
}
+ (float)cmmHeightWithWidth:(float)pWidth
{
    return .0f;
}
+ (float)cmmHeightWithParam:(id)param
{
    return .0f;
}
+ (float)cmmHeight
{
    return .0f;
}
#pragma mark - data
- (void)DATA_init_component
{
    
}

#pragma mark - ui
- (void)UI_init_component
{
    [self addTarget:self action:@selector(responderAction:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - action
- (void)responderAction:(id)sender
{
    [self componentAction: _object];
}

- (void)componentAction:(SkCmmObject *)object
{
    //代理模式
    if ( self.delegate != nil && [self.delegate respondsToSelector:@selector(delegate_Component:cmm:)]) {
        [self.delegate delegate_Component: object cmm:self];
    }
    
    [SKCmmResponder componentAction: object];
}

+ (void)componentAction:(SkCmmObject *)object
{
    //是否返回
    if ( object.mSkSate == SkCmmStateBack ) {
        [[NSNotificationCenter defaultCenter] postNotificationName: SK_Notification_DIS_VIEWCONTROLLER object:nil userInfo:nil];
        return;
    }
    
    //是否返回主页
    if ( object.mSkSate == SkCmmStateRoot ) {
        [[NSNotificationCenter defaultCenter] postNotificationName: SK_Notification_HOME_VIEWCONTROLLER object:nil userInfo:nil];
        return;
    }
    
    //跳转对象是否存在
    if ( object.mSkClassName.length <= 0 || object.mSkSate == SkCmmStateNo ) return;
    
    //进入下级页面
    NSMutableDictionary *notification = [NSMutableDictionary dictionary];
    [notification setObject: object forKey: SK_Notification_param ];
    
    NSMutableDictionary *notify = [NSMutableDictionary dictionary];
    [notify setObject: object.mSkClassName forKey: SK_Notification_className ];
    [notify setObject: [NSNumber numberWithBool: object.mSkAnimate ] forKey: SK_Notification_animate ];
    [notify setObject: notification forKey: SK_Notification_notification ];
    [[NSNotificationCenter defaultCenter] postNotificationName: SkCmmStatePush==object.mSkSate?SK_Notification_PUSH_VIEWCONTROLLER:SK_Notification_PRESENT_VIEWCONTROLLER
                                                        object:nil
                                                      userInfo:notify];
}

@end

