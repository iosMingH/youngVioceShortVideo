//
//  SKApplicationMacro.h
//  App
//
//  Created by 李焕明 on 16/5/25.
//  Copyright © 2016年 李焕明. All rights reserved.
//

#ifndef SKApplicationMacro_h
#define SKApplicationMacro_h

// 判断是否是ipad
#define isPad ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
// 判断iPhone4系列
#define kiPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
// 判断iPhone5系列
#define kiPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
// 判断iPhone6系列
#define kiPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iphone6+系列
#define kiPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
// 判断iPhoneX
#define IS_IPHONE_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
// 判断iPHoneXr
#define IS_IPHONE_Xr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
// 判断iPhoneXs
#define IS_IPHONE_Xs ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
// 判断iPhoneXs Max
#define IS_IPHONE_Xs_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)

//判断是否iphone11系列
#define IS_IPHONE11 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
#define IS_IPHONE11Pro ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
#define IS_IPHONEProMax ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)


#define Height_StatusBar ((IS_IPHONE_X == YES || IS_IPHONE_Xr == YES || IS_IPHONE_Xs == YES || IS_IPHONE_Xs_Max == YES) ? 44.0 : 20.0)
#define Height_NavBar ((IS_IPHONE_X == YES || IS_IPHONE_Xr == YES || IS_IPHONE_Xs == YES || IS_IPHONE_Xs_Max == YES) ? 88.0 : 64.0)
#define Height_TabBar ((IS_IPHONE_X == YES || IS_IPHONE_Xr == YES || IS_IPHONE_Xs == YES || IS_IPHONE_Xs_Max == YES) ? 83.0 : 49.0)

#define kBottomHeight  ((IS_IPHONE_X == YES || IS_IPHONE_Xr == YES || IS_IPHONE_Xs == YES || IS_IPHONE_Xs_Max == YES) ? 44:0)



//判断是真机还是模拟器
#if TARGET_OS_IPHONE
// iPhone Device
#endif

#if TARGET_IPHONE_SIMULATOR
// iPhone Simulator
#endif

//iOS11适配
#define  HKAdjustsContentInsets(scrollView)                                                                                                   \
if (IOS11_OR_LATER) {                                                                                                              \
do {                                                                                                                                \
_Pragma("clang diagnostic push")                                                                                                \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"")                                                             \
if ([UIScrollView instancesRespondToSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:")]) {                    \
[scrollView   performSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:") withObject:@(2)];            \
}                                                                                                                               \
_Pragma("clang diagnostic pop")                                                                                                 \
} while (0);                                                                                                                     \
}else {                                                                                                              \
do {                                                                                                                                \
_Pragma("clang diagnostic push")                                                                                                \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"")                                                             \
self.automaticallyAdjustsScrollViewInsets = NO;                                                                                                                          \
_Pragma("clang diagnostic pop")                                                                                                 \
} while (0);                                                                                                                     \
}                                                                                                                                      \
\

#define HKSafeAreaInsets if (@available(iOS 11.0, *)) {self.additionalSafeAreaInsets = UIEdgeInsetsZero;} else {}


#define _(s) NSLocalizedString((s),(s))

#define G7_RELEASE_SAFELY(__POINTER) { [__POINTER RELEASE]; __POINTER = nil; }

//#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)


#endif /* SKApplicationMacro_h */
