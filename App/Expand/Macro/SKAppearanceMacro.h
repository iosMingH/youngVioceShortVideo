//
//  SKAppearanceMacro.h
//  App
//
//  Created by 李焕明 on 16/5/25.
//  Copyright © 2016年 李焕明. All rights reserved.
//

#ifndef SKAppearanceMacro_h
#define SKAppearanceMacro_h

#import "SKApplicationMacro.h"
#import "AppDelegate.h"
// 默认图片
#define FF_PLACEHOLDER    @"tab_pay_pre"

#define LSString(FORMAT, ...) [NSString stringWithFormat:FORMAT, ##__VA_ARGS__]
#define kStr(str)  ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? @"" :str)
#define kArr(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0?@[]:array)
#define kDic(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0?@{}:dic)

//屏幕自适应
#define DEVICEWIDTH [UIScreen mainScreen].bounds.size.width
#define DEVICEHEIGH [UIScreen mainScreen].bounds.size.height

#define FB_FIX_SIZE_WIDTH(w) (((w) / 375.0) * DEVICEWIDTH)
#define SET_FIX_SIZE_WIDTH (DEVICEWIDTH /375.0)
#define AUTO(num)  num * SET_FIX_SIZE_WIDTH

#define FONT(size)    [UIFont systemFontOfSize:(size)]
#define NSIZE         AUTO(15)
#define NFONT    [UIFont systemFontOfSize:AUTO(15)]
//标题大小
#define TSIZE         AUTO(13)
#define TFONT        [UIFont systemFontOfSize:AUTO(13)]
//内容大小
#define CSIZE         AUTO(11)
#define CFONT        [UIFont systemFontOfSize:AUTO(11)]
//关键字大小
#define KSIZE         AUTO(15)
#define KFONT        [UIFont systemFontOfSize:AUTO(15)]

#define SK_NAV_HIGHT                        64.f
#define SK_TABBAR_HIGHT                     self.navigationController.navigationBar.frame.size.height
#define SK_RECTSTATUS_HIGHT                 [[UIApplication sharedApplication] statusBarFrame].size.height
#define SK_MARGIN                           AUTO(30)
//左右边距
#define SK_MARGINLR                           AUTO(15)

#define kStatusBarHeight         [[UIApplication sharedApplication] statusBarFrame].size.height
#define kNavBarHeight  44
#define kStatusAndNavHeight    (kNavBarHeight +kStatusBarHeight)

// 基本颜色
#define SK_COLOR_BASE_BACKGROUND                [UIColor colorWithRed:241.0/255 green:245.0/255 blue:244.0/255 alpha:1]
#define SK_COLOR_BASE_SEBACKGROUND            [UIColor colorWithRed:40.0/255 green:37.0/255 blue:37.0/255 alpha:1]
#define SK_COLOR_BASE_NAV                       [UIColor colorWithRed:40.0/255 green:37.0/255 blue:37.0/255 alpha:1]
#define SK_COLOR_BASE_TABBAR_BACKGROUND         [UIColor colorWithRed:95.0/255 green:95.0/255 blue:95.0/255 alpha:1]
#define SK_COLOR_BASE_LINE                      [UIColor colorWithRed:238.0/255 green:238.0/255 blue:238.0/255 alpha:1]
#define SK_COLOR_BASE_TABBAR_BACKGROUND_DEEP    [UIColor colorWithRed:77.0/255 green:222.0/255 blue:255.0/255 alpha:1]
#define SK_COLOR_BASE_BACKGROUND_LEFT           [UIColor colorWithRed:226/255.0 green:223/255.0 blue:221/255.0 alpha:1]
//正文色
#define SK_COLOR_BASE_TITLEMAIN                [UIColor colorWithRed:255.0/255 green:255.0/255 blue:255.0/255 alpha:1]
// 内容
#define SK_COLOR_BASE_TITLELESS                [UIColor colorWithRed:255.0/255 green:255.0/255 blue:255.0/255 alpha:0.4]
// 提醒色
#define SK_COLOR_BASE_TITLEREMARK              [UIColor colorWithRed:255.0/255 green:198.0/255 blue:0.0/255 alpha:1]

#define SK_COLOR_BASE_TRANSPARENT              [UIColor colorWithRed:255.0/255 green:255.0/255 blue:255.0/255 alpha:0.2]

//主颜色
#define SK_COLOR_BASE_RED                 [UIColor colorWithRed:255.0/255.0 green:100.0/255.0 blue:96.0/255.0 alpha:1]

// 文字正常颜色
#define SK_COLOR_BASE_TEXT_NAV                  [UIColor whiteColor]
#define SK_COLOR_BASE_TEXT_BLACK                 [UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1]
#define SK_COLOR_BASE_TEXT_WHITE                [UIColor whiteColor]
#define SK_COLOR_BASE_TEXT_GRAY                 [UIColor colorWithRed:148.0/255.0 green:148.0/255.0 blue:148.0/255.0 alpha:1]
#define SK_COLOR_BASE_TEXT_RED                  [UIColor colorWithRed:255.0/255.0 green:32.0/255.0 blue:58.0/255.0 alpha:1]
#define SK_COLOR_BASE_TEXT_BLUE                 [UIColor colorWithRed:43/255.0 green:143/255.0 blue:255/255.0 alpha:1]
#define SK_COLOR_BASE_ORANGE                    [UIColor colorWithRed:255/255.0 green:135/255.0 blue:47/255.0 alpha:1]
#define SK_COLOR_BASE_TEXT_ORANGE               [UIColor colorWithRed:254/255.0 green:90/255.0 blue:0/255.0 alpha:1]

#define SK_COLOR_BASE_TEXT_GREEN                [UIColor colorWithRed:42/255.0 green:171/255.0 blue:7/255.0 alpha:1]
//按钮颜色
#define SK_COLOR_BASE_BUTTON                    [UIColor colorWithRed:255/255.0 green:33/255.0 blue:32/255.0 alpha:1]

// 文字选中颜色
#define SK_COLOR_BASE_TEXT_BLACK_DEEP            [UIColor colorWithRed:40/255 green:40/255 blue:40/255 alpha:1]

#define SK_COLOR_BASE_TEXT_WHITE_DEEP           [UIColor whiteColor]
#define SK_COLOR_BASE_TEXT_GRAY_DEEP            [UIColor colorWithRed:121.0/255 green:121.0/255 blue:121.0/255 alpha:1]
#define SK_COLOR_BASE_TEXT_RED_DEEP             [UIColor colorWithRed:255.0/255 green:10.0/255 blue:10.0/255 alpha:0.6]
#define SK_COLOR_BASE_TEXT_ORANGE_DEEP          [UIColor colorWithRed:235/255.0 green:133/255.0 blue:14/255.0 alpha:1]
#define SK_COLOR_BASE_TEXT_GREEN_DEEP                [UIColor colorWithRed:57/255.0 green:186/255.0 blue:22/255.0 alpha:1]

#define SK_COLOR_BASE_TEXT_YELLOW               [UIColor yellowColor]
// 基础宏定义
#define ALERTSHOW(msg)                          [[[UIAlertView alloc]initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil] show];
//#define TOAST(msg)                              [[[[UIApplication sharedApplication] delegate] window] makeToast: msg]
// 临时替换提示框
#define TOAST(msg)  [FUPROGRESS_HUD info:msg]

#define WINDOW                                  [[UIApplication sharedApplication].delegate window]
#define GOAPPSTORE(appId)                       [[UIApplication sharedApplication] openURL:[NSURL URLWithString: [NSString stringWithFormat:@"itms-apps://itunes.apple.com/us/app/id%@?mt=8", appId] ]]
#define MAINWIDTH                               CGRectGetWidth([[UIScreen mainScreen] bounds])
#define IMG(name)                               [UIImage imageNamed:name]
#define ISMobileNumber(mobileNum)               [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$"] evaluateWithObject:mobileNum]
#define MAINWIDTH                               CGRectGetWidth([[UIScreen mainScreen] bounds])
#define SCALE                                   MAINWIDTH/320.f
#define ScreenFrame [UIScreen mainScreen].bounds

#define RGBA(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

#define ColorWhiteAlpha10 RGBA(255.0, 255.0, 255.0, 0.1)
#define ColorWhiteAlpha20 RGBA(255.0, 255.0, 255.0, 0.2)
#define ColorWhiteAlpha40 RGBA(255.0, 255.0, 255.0, 0.4)
#define ColorWhiteAlpha60 RGBA(255.0, 255.0, 255.0, 0.6)
#define ColorWhiteAlpha80 RGBA(255.0, 255.0, 255.0, 0.8)

#define ColorBlackAlpha1 RGBA(0.0, 0.0, 0.0, 0.01)
#define ColorBlackAlpha5 RGBA(0.0, 0.0, 0.0, 0.05)
#define ColorBlackAlpha10 RGBA(0.0, 0.0, 0.0, 0.1)
#define ColorBlackAlpha20 RGBA(0.0, 0.0, 0.0, 0.2)
#define ColorBlackAlpha40 RGBA(0.0, 0.0, 0.0, 0.4)
#define ColorBlackAlpha60 RGBA(0.0, 0.0, 0.0, 0.6)
#define ColorBlackAlpha80 RGBA(0.0, 0.0, 0.0, 0.8)
#define ColorBlackAlpha90 RGBA(0.0, 0.0, 0.0, 0.9)

#define ColorThemeGrayLight RGBA(104.0, 106.0, 120.0, 1.0)
#define ColorThemeGray RGBA(92.0, 93.0, 102.0, 1.0)
#define ColorThemeGrayDark RGBA(20.0, 21.0, 30.0, 1.0)
#define ColorThemeYellow RGBA(250.0, 206.0, 21.0, 1.0)
#define ColorThemeYellowDark RGBA(235.0, 181.0, 37.0, 1.0)
#define ColorThemeBackground RGBA(14.0, 15.0, 26.0, 1.0)
#define ColorThemeGrayDarkAlpha95 RGBA(20.0, 21.0, 30.0, 0.95)

#define ColorThemeRed RGBA(241.0, 47.0, 84.0, 1.0)

#define ColorRoseRed RGBA(220.0, 46.0, 123.0, 1.0)
#define ColorClear [UIColor clearColor]
#define ColorBlack [UIColor blackColor]
#define ColorWhite [UIColor whiteColor]
#define ColorGray  [UIColor grayColor]
#define ColorBlue RGBA(40.0, 120.0, 255.0, 1.0)
#define ColorGrayLight RGBA(40.0, 40.0, 40.0, 1.0)
#define ColorGrayDark RGBA(25.0, 25.0, 35.0, 1.0)
#define ColorGrayDarkAlpha95 RGBA(25.0, 25.0, 35.0, 0.95)
#define ColorSmoke RGBA(230.0, 230.0, 230.0, 1.0)

//Font
#define SuperSmallFont [UIFont systemFontOfSize:10.0]
#define SuperSmallBoldFont [UIFont boldSystemFontOfSize:10.0]

#define SmallFont [UIFont systemFontOfSize:12.0]
#define SmallBoldFont [UIFont boldSystemFontOfSize:12.0]

#define MediumFont [UIFont systemFontOfSize:14.0]
#define MediumBoldFont [UIFont boldSystemFontOfSize:14.0]

#define BigFont [UIFont systemFontOfSize:16.0]
#define BigBoldFont [UIFont boldSystemFontOfSize:16.0]

#define LargeFont [UIFont systemFontOfSize:18.0]
#define LargeBoldFont [UIFont boldSystemFontOfSize:18.0]

#define SuperBigFont [UIFont systemFontOfSize:26.0]
#define SuperBigBoldFont [UIFont boldSystemFontOfSize:26.0]


//其他定义
typedef NS_OPTIONS(NSUInteger, ShareType) {
    
    ShareToWX                   = 0,
    ShareToFriend               = 1,
    ShareToSinaWeibo            = 2,
    ShareToQQ                   = 3,
    ShareToQQZone               = 4,
    ShareToTencentWeibo         = 5,
};

#define TAG_START_                          1000


#ifndef __has_attribute
#define __has_attribute(x) 0 // Compatibility with non-clang compilers
#endif
#if __has_attribute(objc_method_family)
#define BV_OBJC_METHOD_FAMILY_NONE __attribute__((objc_method_family(none)))
#else
#define BV_OBJC_METHOD_FAMILY_NONE
#endif


#endif /* SKAppearanceMacro_h */
