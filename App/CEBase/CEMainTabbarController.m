//
//  CEMainTabbarController.m
//  App
//
//  Created by mac on 2017/11/16.
//  Copyright © 2017年 HuanMingLi. All rights reserved.
//

#import "CEMainTabbarController.h"
#import "CENavigationController.h"
#import "SCHomeController.h"
#import "MHHomeVideoViewController.h"
@interface CEMainTabbarController ()

@property(nonatomic,strong)NSArray* mTitles;

@end

@implementation CEMainTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.mTitles = @[@"首页",@"消息",@"其他",@"我的"];
    
//    [self chile:[[SCHomeController alloc]init] index:0];
//    [self chile:[[SCMessageController alloc]init] index:1];
//    [self chile:[[MHHomeVideoViewController alloc]init] index:2];
//    [self chile:[[SCUserController alloc]init] index:3];
//    [self setSelectedIndex:2];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


+ (void)initialize
{
    if (self == [CEMainTabbarController class]) {
        //设置tabbaritem title样式
//        [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:AUTO(12)]} forState:UIControlStateNormal];
//
//
//        [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:SK_COLOR_BASE_NAV,NSFontAttributeName:[UIFont systemFontOfSize:AUTO(12)]} forState:UIControlStateSelected];
        
//        [_tabBarController.tabBar setTintColor:Main_Dominant_Pass_Color];
        
      
        // 清除背景和线条
        UITabBar* tabbar =   [UITabBar appearance];
//      [tabbar setBackgroundImage:[FUCommon imageResizing:@"tabbar_bg"]];
        [tabbar setBackgroundColor:[UIColor whiteColor]];
//      [tabbar setBackgroundImage:[UIImage imageNamed:@"tabbar_bg"]];
        // 清除背景
//      [tabbar setBackgroundImage:[[UIImage alloc] init]];
        [tabbar setClipsToBounds:YES]; // ，屏蔽掉
        [tabbar setShadowImage:[[UIImage alloc] init]];
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

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
//    // 重新定义tabar高度
//    CGRect tabFrame = self.tabBar.frame;
//    CGFloat barh = kPowerH(134);
//    if (kIsPhoneX) {
//        barh = kTabbarXH;
//    }else{
//        barh = kTabbarH;
//        // 位置
////        [[UITabBarItem appearance] setTitlePositionAdjustment:UIOffsetMake(0, -5)];
//    }
//    tabFrame.size.height = barh;
//    tabFrame.origin.y = self.view.frame.size.height - barh;
//    self.tabBar.frame = tabFrame;
    
    // 重新定义tabar高度
    CGRect tabFrame = self.tabBar.frame;
//    CGFloat barh = kPowerH(134);
//    if (kIsPhoneX) {
//        barh = kTabbarXH;
//    }else{
//        barh = kTabbarH;
//        // 位置
//        //        [[UITabBarItem appearance] setTitlePositionAdjustment:UIOffsetMake(0, -5)];
//    }
    tabFrame.size.height = Height_TabBar;
    tabFrame.origin.y = self.view.frame.size.height - Height_TabBar;
    self.tabBar.frame = tabFrame;
    
}


-(NSDictionary*)Attributes:(UIColor*)color font:(UIFont*)fo
{
    return [NSDictionary dictionaryWithObjectsAndKeys:color,NSForegroundColorAttributeName,fo,NSFontAttributeName, nil];
}

-(void)chile:(UIViewController*)v index:(NSInteger)i
{
    v.tabBarItem.title = self.mTitles[i];// [LLSHARE_MANAGER read:mark];
    
    
    // 适配iOS13导致的bug
    if (@available(iOS 13.0, *)) {
        // iOS 13以上
        self.tabBar.tintColor = SK_COLOR_BASE_NAV;
//        self.tabBar.unselectedItemTintColor = [UIColor blackColor];
        UITabBarItem *item = [UITabBarItem appearance];
        item.titlePositionAdjustment = UIOffsetMake(0, -2);
        [item setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:AUTO(12)]} forState:UIControlStateNormal];
        [item setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:AUTO(12)]} forState:UIControlStateSelected];
    } else {
        // iOS 13以下
        UITabBarItem *item = [UITabBarItem appearance];
        item.titlePositionAdjustment = UIOffsetMake(0, -2);
//        [item setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12], NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateNormal];
        [item setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:AUTO(12)], NSForegroundColorAttributeName:SK_COLOR_BASE_NAV} forState:UIControlStateSelected];
    }
    
    
    NSString* nonamImage = [NSString stringWithFormat:@"icon_shouye%ld_normal",i+1];
    NSString* selecImage = [NSString stringWithFormat:@"icon_shouye%ld_selected",i+1];
    v.tabBarItem.image = [[UIImage imageNamed:nonamImage]
                           imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    v.tabBarItem.selectedImage = [[UIImage imageNamed:selecImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    v.tabBarItem.imageInsets = UIEdgeInsetsMake(0, 0, -2, 0);

    CENavigationController *nav =[[CENavigationController alloc]initWithRootViewController:v];
    nav.navigationBar.topItem.title = self.mTitles[i];
    nav.visibleViewController.view.tag = i;
    [self addChildViewController:nav];
}

@end
