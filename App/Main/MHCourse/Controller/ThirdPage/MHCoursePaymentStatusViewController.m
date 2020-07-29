//
//  MHCoursePaymentStatusViewController.m
//  App
//
//  Created by dayewang on 2020/7/14.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import "MHCoursePaymentStatusViewController.h"
#import "MHMyOrderDetailViewController.h"
#import "MHCousreShopViewController.h"
@interface MHCoursePaymentStatusViewController ()

@end

@implementation MHCoursePaymentStatusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"付款成功";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addLeftButtonImage:@"p_arrow_left_selected" Action:@selector(backButtonTouched:)];
    
}


- (void)initView{
    UIView *superView = self.view;
    UIImageView *iconV = [UIImageView hyb_imageViewWithImage:@"p_right_orange" superView:self.view constraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(AUTO(75), AUTO(75)));
        make.top.mas_equalTo(Height_NavBar+AUTO(50));
        make.centerX.equalTo(superView);
    }];
    
    UILabel *titleL = [UILabel hyb_labelWithFont:AUTO(19) superView:superView constraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(0);
        make.top.equalTo(iconV.mas_bottom).offset(AUTO(30));
        make.height.mas_equalTo(AUTO(40));
    }];
    titleL.text = @"付款成功";
    titleL.textAlignment = NSTextAlignmentCenter;
    
    UILabel *contentL = [UILabel hyb_labelWithFont:AUTO(24) superView:superView constraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(0);
        make.top.equalTo(titleL.mas_bottom).offset(AUTO(0));
        make.height.mas_equalTo(AUTO(40));
    }];
    contentL.text = @"￥100.00";
    contentL.textAlignment = NSTextAlignmentCenter;
    
    UIButton *orderB = [UIButton hyb_buttonWithSuperView:superView constraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(3*SK_MARGINLR);
         make.right.mas_equalTo(-3*SK_MARGINLR);
        make.top.equalTo(contentL.mas_bottom).offset(AUTO(40));
         make.height.mas_equalTo(AUTO(44));
    } touchUp:^(UIButton *sender) {
        MHMyOrderDetailViewController *vc = [[MHMyOrderDetailViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    orderB.layer.cornerRadius = AUTO(22);
    orderB.backgroundColor = SK_COLOR_BASE_ORANGE;
    [orderB setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    orderB.titleLabel.font = FONT(AUTO(16));
     [orderB setTitle:@"查看订单" forState:UIControlStateNormal];
    
    UIButton *buyB = [UIButton hyb_buttonWithSuperView:superView constraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(3*SK_MARGINLR);
         make.right.mas_equalTo(-3*SK_MARGINLR);
        make.top.equalTo(orderB.mas_bottom).offset(AUTO(20));
         make.height.mas_equalTo(AUTO(44));
    } touchUp:^(UIButton *sender) {
        MHCousreShopViewController *vc = [[MHCousreShopViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    buyB.layer.cornerRadius = AUTO(22);
    buyB.backgroundColor = SK_COLOR_BASE_BACKGROUND;
    [buyB setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    buyB.titleLabel.font = FONT(AUTO(16));
    [buyB setTitle:@"继续购买" forState:UIControlStateNormal];
    
}

//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
//
////        设置导航栏背景图片为一个无图的image，导航栏会加载空imgae，就自然透明掉了
//        [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
//    //    同理透明掉导航栏下划线
//        [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
//}
//
//- (void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
//
//}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
      self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];

}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
     [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        self.navigationController.navigationBar.barTintColor = SK_COLOR_BASE_NAV;
}

#pragma mark - aciton
- (void)backButtonTouched:(UIButton *)sender {

    [self.navigationController popViewControllerAnimated:YES];
}




@end
