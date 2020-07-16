//
//  SKMMacro.h
//  App
//
//  Created by 李焕明 on 16/5/25.
//  Copyright © 2016年 李焕明. All rights reserved.
//

#ifndef SKMMacro_h
#define SKMMacro_h

#define HEIGHT_HOMEHEAD        200.0

#define PUBILC_HEIGHT_CELL     AUTO(50)
/** 弱引用 */
#define WEAKSELF __weak typeof(self) weakSelf = self;

#define kMainColor           kHexRGB(0x1071FE)   //主色调  shen
#define kCiyaoColor          kHexRGB(0x408EFF)      //浅蓝色

//#define kWarningColor        kHexRGB(0xF54949)      //红色警告色
#define kLSRedColor        kHexRGB(0xF54949)      //红色警告色
#define kTagColor            kHexRGB(0xF54949)     //橙色 (240,0,0)

#define k333Color            kHexRGB(0x333333)     //深色 做标题使用 (51,51,51)
#define k666Color            kHexRGB(0x666666)    //正文色 (102,102,102)
#define k999Color            kHexRGB(0x999999)    //提醒色(153,153,153)
#define kBorderColor         kHexRGB(0xc1c1c1)   //描边色(193,193,193)
#define kButtonColor         kHexRGB(0xCCCCCC)     //标签栏图标浅色按钮
#define kLineColor           kHexRGB(0xECECEC)     //)
#define kBackColor           kHexRGB(0xF8F8F8)  //背景色 (245,245,245)
#define kStatusColor         kHexRGB(0xff9947)  //状态颜色 橘色 (245,245,245)
#define kWarningColor         kHexRGB(0xf54949)  //警告色  便红色



//#define kSafeColor           kHexRGB(0x06C198）     //浅蓝色
#define kRandomColor [UIColor colorWithHue:(arc4random()%256/256.0) saturation:(arc4random()%128/256.0)+0.5 brightness:(arc4random()% 128/256.0)+0.5 alpha:1]


#define kRGB(r, g, b) ([UIColor colorWithRed:(r) / 255.0  \
green:(g) / 255.0  \
blue:(b) / 255.0  \
alpha:1])
//字体
#define kFont(x)       [UIFont systemFontOfSize:x]
#define kBoldFont(x)   [UIFont boldSystemFontOfSize:x]
#define kScale(x)  x*([UIView floatWithType:0]/375.0)

//多线程
//1.延迟几秒后操作
#define kGCDAfter(delay, GCDBlock) dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), GCDBlock)
//2.多线程——返回主线程操作
#define kGCDMain(GCDBlock) dispatch_async(dispatch_get_main_queue(),GCDBlock)
//3.多线程——在子线程操作
#define kGCDAsync(GCDBlock) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),GCDBlock)

//#define kScreenW    [UIScreen mainScreen].bounds.size.width
//#define kScreenH    [UIScreen mainScreen].bounds.size.height
//#define kNavbarH    64.0
//#define kTabbarH    49.0
//#define kTabbarXH   83.0
#define kPixels     1.0 / [UIScreen mainScreen].scale  // 1px
// 750 1334
#define kPowerW(w) (w) * (kScreenW / 375.0)
#define kPowerH(h) (h) * (kScreenH / 667.0)

//#define IPHONE_X ([UIScreen mainScreen].bounds.size.width >= 1125.0)

#define PlaceholderImageName  @"basic_zhanwei"

#define LocationTopTime  @"LocationTopTime"

#define kColor_Main [UIColor colorWithHex:0x05c0ab]

#define NEEDLOGIN                                   1

#define JGBoldFont(size1) [UIFont fontWithName:@"Helvetica-Bold" size:size1] //加粗字体尺寸


//请求基础地址
#define URL_BASIC         @"http://192.168.0.199:8088/video"
/**
 微信
 */
#define WXPayAppID   @"wxb4ba3c02aa476ea1"  //测试
#define WXAuthAppID   @"wxd930ea5d5a258f4f"  //测试

#define WX_APPID    @"wxd74bc18978752573"
#define WX_SECRET @"d35da9adb96e17d2e6e0f6dfccae9120"
#define WX_Auth_Scope @"snsapi_message,snsapi_userinfo,snsapi_friend,snsapi_contact"
/**
 本地存储key
 */
#define USER_HISTORY       @"historyContent"
#define USER_ACCOUNT       @"account"
#define USER_PASSWORD      @"password"

#define STORE_ID           @"16"
#define DEFAULT_IMAGE      @"basic_zhanwei"
#endif /* SKMMacro_h */
