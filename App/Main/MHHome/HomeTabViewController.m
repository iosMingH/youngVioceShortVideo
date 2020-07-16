//
//  HomeTabViewController.m
//  App
//
//  Created by Pro on 2020/3/26.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import "HomeTabViewController.h"
#import "AlivcShortVideoPersonalViewController.h"
#import "MHShortVideoTabBar.h"
#import "AlivcDefine.h"
#import "AlivcMacro.h"
#import "AlivcImage.h"
#import "MHShortVideoLivePlayViewController.h"
#import "MHShortVideoPersonalViewController.h"
#import "MHHomeVideoViewController.h"
#import "MHCourseMultipleViewController.h"
#import "MHMessageViewController.h"
#import "MHUserViewController.h"

@interface HomeTabViewController ()

@property (strong, nonatomic) MHShortVideoTabBar *customBar;

@end

@implementation HomeTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    [UITabBar appearance].translucent = NO;

    // Do any additional setup after loading the view.
    // 利用KVO来使用自定义的tabBar
    self.customBar = [[MHShortVideoTabBar alloc]init];
    [self setValue:[[MHShortVideoTabBar alloc] init] forKey:@"tabBar"];
    [self addChildVC];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(centerButtonSelectedToNo) name:AlivcNotificationVideoStartPublish object:nil];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)addChildVC {

    self.tabBar.barTintColor = [UIColor whiteColor];
    self.tabBar.tintColor = [UIColor whiteColor];

    self.tabBar.backgroundImage = [[UIImage alloc] init];
    self.tabBar.shadowImage = [[UIImage alloc] init];
    
    self.tabBar.backgroundImage = [UIImage imageNamed:@"tab_background"];

      [self setupChildVc:[[MHHomeVideoViewController alloc] init] title:@"" image:@"tab_home"  selectedImage:@"tab_home_selected"];
      
      [self setupChildVc:[[MHCourseMultipleViewController alloc] init] title:@"" image:@"tab_course"  selectedImage:@"tab_course_selected"];

      [self setupChildVc:[[MHMessageViewController alloc] init] title:@"" image:@"tab_message"  selectedImage:@"tab_message_selected"];
    
      [self setupChildVc:[[MHUserViewController alloc] init] title:@"" image:@"tab_me"  selectedImage:@"tab_me_selected"];
    
}

/**
 *  初始化控制器
 *
 *  @param vc            控制器
 *  @param title         标题
 *  @param image         图片
 *  @param selectedImage 选中图片
 */
- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage {

    
//    // 通过normal状态设置字体大小
//    // 字体大小 跟 normal
//    NSMutableDictionary *attrnor = [NSMutableDictionary dictionary];
//
//    // 设置字体
//    attrnor[NSFontAttributeName] = [UIFont systemFontOfSize:18];
//
//    [vc.tabBarItem setTitleTextAttributes:attrnor forState:UIControlStateNormal];
//    vc.tabBarItem.title = title;
//    vc.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
     vc.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
//
//    [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:SK_COLOR_BASE_NAV} forState:UIControlStateSelected];
//    [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]} forState:UIControlStateNormal];

    
    CENavigationController *nav = [[CENavigationController alloc] initWithRootViewController:vc];
       
    //隐藏tabbar
    [self addChildViewController:nav];
}

- (void)centerButtonSelectedToNo{
    self.customBar.centerBtn.selected = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter]postNotificationName:AlivcNotificationQuPlay_QutiMask object:nil];
    });

}

#pragma mark -
- (BOOL)shouldAutorotate{
    return [self.selectedViewController shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return [self.selectedViewController supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return [self.selectedViewController preferredInterfaceOrientationForPresentation];
}

#pragma mark - UITabBarDelegate
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    [[NSNotificationCenter defaultCenter]postNotificationName:AlivcNotificationQuPlay_QutiMask object:nil];
}

//隐藏导航栏 MH

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
         self.navigationController.navigationBar.hidden = YES;
}

@end

