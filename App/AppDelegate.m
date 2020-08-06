//
//  AppDelegate.m
//  App
//
//  Created by Pro on 2020/1/5.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import "AppDelegate.h"
#import "Reachability.h"
#import "CEMainTabbarController.h"
#import "WXApiManager.h"
#import "HomeTabViewController.h"
#import "MHSettingViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self ViewController_init];
    [self.window makeKeyAndVisible];
    
           //向微信注册,发起支付必须注册
    [WXApi registerApp:WXAuthAppID universalLink:@"https://help.wechat.com/sdksample/"];
   
//     [WXApi registerApp:WXAuthAppID universalLink:@"https://mp.dayezhifu.com/"];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
  
    
    #ifndef __IPHONE_11_0
    #define __IPHONE_11_0 110000
    #endif
    #if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_11_0
    // if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"11.0")) {
    if (@available(iOS 11.0, *)) {
    UIScrollView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    UITableView.appearance.estimatedRowHeight = 0;
    UITableView.appearance.estimatedSectionFooterHeight = 0;
    UITableView.appearance.estimatedSectionHeaderHeight = 0;
    } else {
    // Fallback on earlier versions
    }
    #endif
    
    return YES;
}


#pragma mark --
- (void)ViewController_init
{
//
//    CEMainTabbarController* tab = [[CEMainTabbarController alloc]init];
//    self.window.rootViewController = tab;
    
//    if ([SkUserDefaults readIsBoolWithKey:KEY_BOOL_LOGIN]) {
//
//        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:[[NSClassFromString(@"HomeTabViewController") alloc]init]];
//             [self.window setRootViewController:nav];
//    }else{
//        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:[[NSClassFromString(@"MHLoginViewController") alloc]init]];
//             [self.window setRootViewController:nav];
//    }

    MHDrawViewController *drawVc = [self loadNavigationController];
   [self.window setRootViewController:drawVc];
}


- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
//    return  [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
     return [MHPayManager wxHandleOpenURL:url];
}

//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
////    return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
//    return [MHPayManager wxHandleOpenURL:url];
//}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler{
    return [MHPayManager handleOpenUniversalLink:userActivity];
}

#pragma mark - 导航控制器/TabBar控制器
- (MHDrawViewController *)loadNavigationController
{
    // 左侧抽屉
//    UIViewController *leftVC = [UIViewController new];
    // 右侧抽屉
    MHSettingViewController *rightVC = [MHSettingViewController new];

    HomeTabViewController *tabBarVC = [HomeTabViewController new];
    MHDrawViewController *drawVC = [[MHDrawViewController alloc] initWithRootVC:tabBarVC leftVC:nil rightVC:rightVC];
    return drawVC;
}
@end
