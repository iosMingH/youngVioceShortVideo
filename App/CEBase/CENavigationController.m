//
//  CENavigationController.m
//  App
//
//  Created by mac on 2017/11/16.
//  Copyright © 2017年 HuanMingLi. All rights reserved.
//

#import "CENavigationController.h"
#import "CENavigationDelegate.h"

#define kIS_iOS(x) ([[[UIDevice currentDevice]systemVersion]floatValue] < x)

@interface CENavigationController ()

@end

@implementation CENavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = [CENavigationDelegate Instance];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    NSLog(@"PushNav============%@",NSStringFromClass([viewController class]));
    if (self.childViewControllers.count > 0) { // 如果push进来的不是第一个控制器
        UIButton* back = [[UIButton alloc] init];
        
        [back setTitle:@"返回" forState:UIControlStateNormal];
      
        [back.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [back setImageEdgeInsets:UIEdgeInsetsMake(0, 25, 0, 0)];
        [back setTitleEdgeInsets:UIEdgeInsetsMake(0, 50, 0, -5)];
        [back setTitleColor:[UIColor whiteColor]  forState:UIControlStateNormal];
        
        [back setImage:[UIImage imageNamed:@"ru_arrow"] forState:UIControlStateNormal];
        [back setImage:[UIImage imageNamed:@"ru_arrow"] forState:UIControlStateHighlighted];
        [back sizeToFit];
        [back addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:back];
        // 隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)back:(UIButton*)sender
{
    [self popViewControllerAnimated:YES];
}

+ (void)initialize
{
    if (self == [CENavigationController class]) {
        [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:AUTO(18)]}];
        [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
        [[UINavigationBar appearance]setBarStyle:UIBarStyleBlackTranslucent];
        
//        [[UINavigationBar appearance] setTintColor:c2];
        [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];
//        [[UINavigationBar appearance] setBarTintColor:c1];
//        [[UINavigationBar appearance] setBackgroundColor:c1];
//        [[UINavigationBar appearance] setBackIndicatorImage:[UIImage imageNamed:@"icon_top_arrow_left"]];
//        [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"icon_top_arrow_left"]];
        CIColor * color = [[CIColor alloc] initWithColor:[UIColor whiteColor]];
        CIImage * ci = [CIImage imageWithColor:color];
        UIImage * img = [UIImage imageWithCIImage:ci];
        [[UINavigationBar appearance] setBackgroundImage:img forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
        [[UINavigationBar appearance] setShadowImage:[UIImage new]];
//        if (kIS_iOS(8.0)) {// 半透明效果
//            [[UINavigationBar appearance] setTranslucent:NO];
//        }
        // 设置背景
        //        [[UINavigationBar appearance] setBackgroundImage:[FUCommon imageResizing:@"navbar_bg"] forBarMetrics:UIBarMetricsDefault];
        
               [[UINavigationBar appearance] setBarTintColor: SK_COLOR_BASE_NAV];
        // 清除线条
        [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
        
        // 设置状态栏颜色
        //        [FUCommon statusBar:[UIColor blackColor]];
        
        //设置状态栏的字体颜色模式
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        //设置状态栏是否隐藏
        //    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    }
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
@end
