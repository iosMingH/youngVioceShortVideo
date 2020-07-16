//
//  CENavigationDelegate.m
//  App
//
//  Created by mac on 2017/11/16.
//  Copyright © 2017年 HuanMingLi. All rights reserved.
//

#import "CENavigationDelegate.h"

@implementation CENavigationDelegate
// 创建静态对象 防止外部访问
static CENavigationDelegate *_instance;
+(instancetype) Instance
{// 也可以使用一次性代码
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:NULL] init] ;
    }) ;
    return _instance ;
}

-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
//     [navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nabbar_nc"] forBarMetrics:UIBarMetricsDefault];
//        navigationController.navigationBar.barTintColor = [UIColor blackColor];
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
    
    //    / if rootViewController, set delegate nil /
    if (navigationController.viewControllers.count == 1) {
        navigationController.interactivePopGestureRecognizer.enabled = NO;
        navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
}

@end
