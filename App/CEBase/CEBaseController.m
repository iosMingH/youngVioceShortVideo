//
//  CEBaseController.m
//  App
//
//  Created by mac on 2017/11/16.
//  Copyright © 2017年 HuanMingLi. All rights reserved.
//
//

#import "CEBaseController.h"

@interface CEBaseController ()

@end

@implementation CEBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //    self.view.backgroundColor = [UIColor whiteColor];
    
    //    [self setStatusBarBackgroundColor:[UIColor blackColor]];
    
    self.view.backgroundColor =SK_COLOR_BASE_BACKGROUND;
    [self addNotificationWith:@selector(eventNotice:)
                         name:NSStringFromClass([self class])];
    [self initView];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (instancetype)init:(id)parameter
{
    self = [super init];
    if (self) {
        [self setIsNavbarShow:NO];
        [self initData:parameter];
    }
    return self;
}

#pragma 初始化方法
-(void)loadData{
    
}
-(void)initView{
    
}
-(void)initData:(id)parameter{}
-(void)initLayout{
    
}
// 消息
-(void)eventNotice:(NSNotification *)info{};
#pragma 通知方法
//添加一个通知
-(void)addNotificationWith:(SEL)selector name:(NSString *)sbuff
{
    //信息同步返回
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:selector
                                                 name:sbuff
                                               object:nil];
}

//移除一个通知
-(void)delNotificationWith:(NSString *)name
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:name
                                                  object:nil];
}

-(void)onPushViewController:(UIViewController*)vc animated:(BOOL)animate{
    [self.navigationController pushViewController:vc animated:animate];
}

#pragma 生命周期
// 页面打开前回调
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // 管理标题栏显示
//    NSLog(@"%d",_isNavbarShow);
    [self.navigationController setNavigationBarHidden:_isNavbarShow];
    // 键盘插件
    //     [IQKeyboardManager sharedManager].enable = NO;
    
}

//设置状态栏颜色
- (void)setStatusBarBackgroundColor:(UIColor *)color {
    
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}


// 页面打开后回调
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
};

// 页面关闭前回调
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //     [IQKeyboardManager sharedManager].enable = YES;
};

// 页面关闭后回调
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
};

-(void)setExtendedLayout{
    self.edgesForExtendedLayout = UIRectEdgeNone;
}


#pragma 左侧按钮
-(UIButton *)addLeftButtonImage:(NSString*)path Action:(SEL)action
{// 返回
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:path] forState:UIControlStateNormal];
    btn.contentMode = UIViewContentModeScaleAspectFit;
    [btn setFrame:CGRectMake(0, 0, AUTO(24), AUTO(24))];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* BarButton = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationController.topViewController.navigationItem.leftBarButtonItem = BarButton;
    return btn;
}

-(UIButton *)addNavLeftBtn:(NSString*)str image:(NSString*)name action:(SEL)action{
        
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:str forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:AUTO(16)]];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* BarButton = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationController.topViewController.navigationItem.leftBarButtonItem = BarButton;
    return btn;
}

-(UIButton *)addRightButtonImage:(NSString*)path Action:(SEL)action
{
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn setImage:[UIImage imageNamed:path] forState:UIControlStateNormal];
    [btn setFrame:CGRectMake(0, 0, AUTO(24), AUTO(24))];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* BarButton = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationController.topViewController.navigationItem.rightBarButtonItem = BarButton;
    return btn;
}

-(UIButton *)addNavRightBtnTitle:(NSString*)str action:(SEL)action
{
    UIButton* btn = [[UIButton alloc] init];
    [btn setTitle:str forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:AUTO(16)]];
     [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -25, 0, 0)]; 
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn sizeToFit];
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* BarButton = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationController.topViewController.navigationItem.rightBarButtonItem = BarButton;
    return btn;
}

-(void)addNavRightBtn:(NSString*)str image:(NSString*)name action:(SEL)action
{
    UIButton* btn = [[UIButton alloc] init];
    [btn setTitle:str forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:AUTO(14)]];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(-4, 0, 4, 0)];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(-4, 5, 4, -5)];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:name] forState:UIControlStateHighlighted];
    [btn sizeToFit];
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* BarButton = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationController.topViewController.navigationItem.rightBarButtonItem = BarButton;
}


-(void)addLeftButton:(SEL)action
{
    UIButton* back = [[UIButton alloc] init];
    [back setTitle:@"返回" forState:UIControlStateNormal];
    [back.titleLabel setFont:[UIFont systemFontOfSize:AUTO(14)]];
    [back setImageEdgeInsets:UIEdgeInsetsMake(-4, 0, 4, 0)];
    [back setTitleEdgeInsets:UIEdgeInsetsMake(-4, 5, 4, -5)];
    [back setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [back setImage:[UIImage imageNamed:@"return_s"] forState:UIControlStateNormal];
    [back setImage:[UIImage imageNamed:@"return_s"] forState:UIControlStateHighlighted];
    [back sizeToFit];
    [back addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* BarButton = [[UIBarButtonItem alloc]initWithCustomView:back];
    self.navigationController.topViewController.navigationItem.leftBarButtonItem = BarButton;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

-(void)popCurrentNormalViewAction:(BOOL)action
{// 关闭普通界面
    [self.navigationController popViewControllerAnimated:action];
}

-(void)popCurrentToRootViewAction:(BOOL)action
{// 返回根视图普
    [self.navigationController popToRootViewControllerAnimated:action];
}

-(void)dismissCurrentModalWithAction:(BOOL)action
{// 关闭模态界面
    [[[UIApplication sharedApplication] keyWindow].rootViewController dismissViewControllerAnimated:action completion:^{}];
}

#pragma layout

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self initLayout];
}

@end
