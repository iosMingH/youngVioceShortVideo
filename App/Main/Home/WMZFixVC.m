//
//  WMZFixVC.m
//  WMZPageController
//
//  Created by wmz on 2020/1/6.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "WMZFixVC.h"
#import "MHMyCourseViewController.h"
@interface WMZFixVC ()

@end

@implementation WMZFixVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"课程详情";
      WMZPageParam *param = PageParam()
      .wTitleArrSet(@[@"热门",@"分类",@"推荐"])
      .wControllersSet(@[[MHMyCourseViewController new],[UIViewController new],[MHMyCourseViewController new]])
      //固定在所有子控制器底部  需要放在第一个控制器里 例如此例子
//     .wControllersSet(@[[FixSonVC new],[CollectionViewPopDemo new],[CollectionViewPopDemo new]])
//     .wFixFirstSet(YES)
      //悬浮开启
      .wTopSuspensionSet(YES)
        .wMenuAnimalSet(PageTitleMenuAiQY)
    //设置标题颜色
      .wMenuTitleSelectColorSet([UIColor yellowColor])
    //设置指示器颜色
      .wMenuIndicatorColorSet([UIColor yellowColor])
      //等分
      .wMenuTitleWidthSet(PageVCWidth/3)
      //头视图y坐标从0开始
      .wFromNaviSet(NO)
      //导航栏透明度变化
      .wNaviAlphaSet(YES)
      //头部
      .wMenuHeadViewSet(^UIView *{
          UIView *back = [UIView new];
          back.frame = CGRectMake(0, 0, PageVCWidth, 370+PageVCStatusBarHeight);
          back.backgroundColor = [UIColor yellowColor];
          UIImageView *image = [UIImageView new];
          [image sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1576232579082&di=f6ae983436a2512d41ed5b25789cf212&imgtype=0&src=http%3A%2F%2Fbig5.ocn.com.cn%2FUpload%2Fuserfiles%2F18%252858%2529.png"]];
          image.frame =CGRectMake(0, 0, PageVCWidth, 320+PageVCStatusBarHeight);
          [back addSubview:image];
          return back;
      });
      self.param = param;
    
 
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.translucent = YES;

//    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
//      self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
//    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
  
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
//    self.navigationController.navigationBar.barTintColor = SK_COLOR_BASE_SEBACKGROUND;
//    self.navigationController.navigationBar.translucent = NO;

}

@end
