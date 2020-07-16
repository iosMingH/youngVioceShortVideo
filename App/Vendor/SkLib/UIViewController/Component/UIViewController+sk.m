//
//  UIViewController+sk.h
//  App
//
//  Created by 李焕明 on 16/5/26.
//  Copyright © 2016年 李焕明. All rights reserved.
//

#import "UIViewController+SK.h"
#import "Macro+SK.h"
#import <objc/runtime.h>

@implementation UIViewController (SK)

//定义常量 必须是C语言字符串
static char *AopNotificationKey = "AopNotificationKey";

-(void)setNotification:(NSDictionary *)notification{
    objc_setAssociatedObject(self, AopNotificationKey, notification, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(NSDictionary *)notification{
    return objc_getAssociatedObject(self, AopNotificationKey);
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        // When swizzling a class method, use the following:
        //         Class class = object_getClass((id)self);
        swizzleMethod(class, @selector(viewDidLoad), @selector(aop_viewDidLoad));
        swizzleMethod(class, @selector(viewDidAppear:), @selector(aop_viewDidAppear:));
        swizzleMethod(class, @selector(viewWillAppear:), @selector(aop_viewWillAppear:));
        swizzleMethod(class, @selector(viewWillDisappear:), @selector(aop_viewWillDisappear:));
    });
}

void swizzleMethod(Class class, SEL originalSelector, SEL swizzledSelector)   {
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    BOOL didAddMethod =
    class_addMethod(class,
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}
- (void)aop_viewDidAppear:(BOOL)animated {
    [self aop_viewDidAppear:animated];
}

-(void)aop_viewWillAppear:(BOOL)animated {
    [self aop_viewWillAppear:animated];
    
    //推送服务
    [self NC_add];
}
-(void)aop_viewWillDisappear:(BOOL)animated {
    [self aop_viewWillDisappear:animated];
    
    //推送服务
    [self NC_remove];
}
- (void)aop_viewDidLoad {
    [self aop_viewDidLoad];
    
    if ([self isKindOfClass:[UINavigationController class]]) {
//                UINavigationController *nav = (UINavigationController *)self;
//                nav.navigationBar.translucent = NO;
//                nav.navigationBar.barTintColor = SK_COLOR_BASE_NAV;
//                nav.navigationBar.tintColor = SK_COLOR_TINT;
//                NSDictionary *titleAtt = @{NSForegroundColorAttributeName: SK_COLOR_TINT };
//                [[UINavigationBar appearance] setTitleTextAttributes:titleAtt];
//                [[UIBarButtonItem appearance]
//                 setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
//                 forBarMetrics:UIBarMetricsDefault];
    }
    
    //    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
}

#pragma mark - set
//- (void)setTitle:(NSString *)title
//{
//    UILabel *titleLabel = [[UILabel alloc]initWithFrame: CGRectMake(0, 0, 100, kkNew64)];
//    titleLabel.backgroundColor = [UIColor clearColor];
//    titleLabel.text = title;
//    titleLabel.textAlignment = NSTextAlignmentCenter;
//    titleLabel.textColor = SK_COLOR_BASE_TEXT_NAV;
//    titleLabel.font = [UIFont systemFontOfSize: 20.f];
//    self.navigationItem.titleView = titleLabel;
//}

#pragma mark - Button action
- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:^(void){}];
}
- (void)doubleAction
{
    //    NSLog(@"子类继承实现....");
    //    NSLog(@"%@双击~~~~", [NSString stringWithFormat:@"%@", [self class] ] );
}
#pragma mark - NotificationCenter
- (void)NC_add
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(skBasePushNotification:) name:SK_Notification_PUSH_VIEWCONTROLLER object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(skBasePresentNotification:) name:SK_Notification_PRESENT_VIEWCONTROLLER object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(skBaseDisNotification:) name:SK_Notification_DIS_VIEWCONTROLLER object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(skBaseHomeNotification:) name:SK_Notification_HOME_VIEWCONTROLLER object:nil];
}
- (void)NC_remove
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SK_Notification_PUSH_VIEWCONTROLLER object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SK_Notification_PRESENT_VIEWCONTROLLER object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SK_Notification_DIS_VIEWCONTROLLER object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SK_Notification_HOME_VIEWCONTROLLER object:nil];
}

- (void)NC_safe
{
    
}

#pragma mark - Base Notification
- (void)skBasePushNotification:(NSNotification *)notify
{
    [self NC_safe];
    
    NSDictionary *info = notify.userInfo ? notify.userInfo : notify.object;
    
    //获取类名
    NSString *className = [info objectForKey: SK_Notification_className ];
    BOOL isAnimate = [[info objectForKey: SK_Notification_animate ] boolValue];
    NSDictionary *notification = [info objectForKey: SK_Notification_notification ];
    Class class = NSClassFromString( className );
    id pClass = [[class alloc]init];
    [pClass performSelector:@selector(setNotification:) withObject: notification ];
    [pClass setHidesBottomBarWhenPushed:YES];//需要隐藏时候开启
    
    //#warning  test
    [self.navigationController pushViewController:pClass animated:isAnimate];
    //    [self.parentViewController.navigationController pushViewController:pClass animated:isAnimate];
}

- (void)skBasePresentNotification:(NSNotification *)notify
{
    [self NC_safe];
    
    NSDictionary *info = notify.userInfo ? notify.userInfo : notify.object;
    //获取类名
    NSString *className = [info objectForKey: SK_Notification_className ];
    BOOL isAnimate = [[info objectForKey: SK_Notification_animate ] boolValue];
    
    NSDictionary *notification = [info objectForKey: SK_Notification_notification ];
    Class class = NSClassFromString( className );
    id pClass = [[class alloc]init];
    [pClass performSelector:@selector(setNotification:) withObject: notification ];
    [self presentViewController:pClass animated:isAnimate completion:^(void){}];
}

- (void)skBaseDisNotification:(NSNotification *)notify
{
    [self backAction];
}

- (void)skBaseHomeNotification:(NSNotification *)notify
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end

