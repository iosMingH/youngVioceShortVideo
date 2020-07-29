//
//  MHMagicCameraRaceViewController.m
//  App
//
//  Created by dayewang on 2020/7/29.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import "MHMagicCameraRaceViewController.h"
#import "AlivcShortVideoRaceManager.h"
#import "AVC_ShortVideo_Config.h"

@interface MHMagicCameraRaceViewController ()

@end

@implementation MHMagicCameraRaceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //单个页面禁止系统侧滑返回上个页面
    id traget = self.navigationController.interactivePopGestureRecognizer.delegate;
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:traget action:nil];
    [self.view addGestureRecognizer:pan];
}

//MH ---- 隐藏导航栏
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
     [[UIApplication sharedApplication]setStatusBarHidden:YES];
}

//MH ---- 显示导航栏
- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
     [[UIApplication sharedApplication]setStatusBarHidden:NO];

    
    //ios11返回上一级页面导航栏会出现偏移
    #ifndef __IPHONE_11_0
    #define __IPHONE_11_0 110000
    #endif
    #if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_11_0
    // if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"11.0")) {
    if (@available(iOS 11.0, *)) {
       self.navigationController.navigationBar.frame = CGRectMake(0, Height_StatusBar, DEVICEWIDTH, Height_NavBar-Height_StatusBar);
    } else {
    // Fallback on earlier versions
    }
    #endif
  
}

////MH ---- 显示导航栏
//- (void)viewDidDisappear:(BOOL)animated{
//    [super viewDidDisappear:animated];
//    self.navigationController.navigationBar.hidden = NO;
//    [[UIApplication sharedApplication]setStatusBarHidden:NO];
//}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

}



#if SDK_VERSION == SDK_VERSION_CUSTOM


// 集成race
- (int)customRenderedTextureWithRawSampleBuffer:(CMSampleBufferRef)sampleBuffer {
    if ([[AlivcShortVideoRoute shared] currentBeautyType] == AlivcBeautyTypeFaceUnity) {
        return 0;
    }
    if (self.beautyView.currentBeautyType == AlivcBeautySettingViewStyle_ShortVideo_BeautyFace_Base) {
        return 0;
    }
    
    //注意这里美颜美型的参数是分开的beautyParams和beautySkinParams
    //美颜参数设置(这里用的是beautyParams)
    CGFloat beautyBuffing = self.beautyView.beautyParams.beautyBuffing/100.0f;
    CGFloat beautyWhite = self.beautyView.beautyParams.beautyWhite/100.0f;
    CGFloat beautySharpen = self.beautyView.beautyParams.beautyRuddy/100.0f; //race中，这个是锐化
    //美型参数设置(这里用的是beautySkinParams)
    CGFloat beautyBigEye = self.beautyView.beautySkinParams.beautyBigEye/100.0f;
    CGFloat beautyThinFace = self.beautyView.beautySkinParams.beautySlimFace/100.0f;
    CGFloat longFace = self.beautyView.beautySkinParams.longFace/100.0f;
    CGFloat cutFace = self.beautyView.beautySkinParams.cutFace/100.0f;
    CGFloat lowerJaw = self.beautyView.beautySkinParams.lowerJaw/100.0f;
    CGFloat mouthWidth = self.beautyView.beautySkinParams.mouthWidth/100.0f;
    CGFloat thinNose = self.beautyView.beautySkinParams.thinNose/100.0f;
    CGFloat thinMandible = self.beautyView.beautySkinParams.thinMandible/100.0f;
    CGFloat cutCheek = self.beautyView.beautySkinParams.cutCheek/100.0f;
    int rander = [[AlivcShortVideoRaceManager shareManager] customRenderWithBuffer:sampleBuffer skinBuffing:beautyBuffing skinWhitening:beautyWhite sharpen:beautySharpen bigEye:beautyBigEye longFace:longFace cutFace:cutFace thinFace:beautyThinFace lowerJaw:lowerJaw mouthWidth:mouthWidth thinNose:thinNose thinMandible:thinMandible cutCheek:cutCheek];
    return rander;
}
#endif



// 后面添加  MH
//- (void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion{
//    [super dismissViewControllerAnimated:flag completion:completion];
//
//    if (DP_IS_IOS11) {
//        //执行词句代码，可以消除跳动的问题。但遗憾，没有能够控制隐藏动画时间的接口，所以为了防止突兀，设置了透明度动画。
//        [self.navigationController setNavigationBarHidden:YES animated:YES];
//        [UIView animateWithDuration:UINavigationControllerHideShowBarDuration animations:^{
//            self.navigationController.navigationBar.alpha = 0.0;
//        }];
//    }
//}
@end

