//
//  MHLoginViewController.m
//  App
//
//  Created by Pro on 2020/6/23.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import "MHLoginViewController.h"
#import "WechatAuthSDK.h"
#import "MHDrawViewController.h"
#import "HomeTabViewController.h"
#import "MHSettingViewController.h"

@interface MHLoginViewController ()<UITextFieldDelegate,WXApiManagerDelegate, WechatAuthAPIDelegate>

@property(nonatomic,strong)UITextField *tellPhoneT;
@property(nonatomic,strong)UITextField *verificationCodeT;
@property(nonatomic,strong)UIButton *verificationCodeB;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger iTime;
@property(nonatomic,strong)UIButton *loginB;

@end

@implementation MHLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self returnKeyHandler];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //设置导航栏背景图片为一个无图的image，导航栏会加载空imgae，就自然透明掉了
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
      //    同理透明掉导航栏下划线
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}


- (void)viewWillDisappear:(BOOL)animated
{
  [super viewWillDisappear:animated];
  [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
   // 有效释放
  [self.timer invalidate];
  self.timer = nil;
    
}

- (void)returnKeyHandler
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(reKeyBoard)];
    [self.view addGestureRecognizer:tap];
    tap.cancelsTouchesInView = false;
}

//实现方法//取消textView ,textField的第一响应者即可
- (void)reKeyBoard
{
    [self.tellPhoneT resignFirstResponder];
    [self.verificationCodeT resignFirstResponder];
}


-(void)initView{
    __weak typeof(self) this = self;
    
    UILabel *phoneR = [UILabel hyb_labelWithText:@"手机号登录" font:AUTO(20) superView:self.view constraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(AUTO(30));
        make.top.mas_equalTo(Height_StatusBar+AUTO(60));
        make.right.mas_equalTo(-AUTO(30));
        make.height.mas_equalTo(AUTO(30));
    }];
    phoneR.textColor = SK_COLOR_BASE_TEXT_BLACK;
    
    UILabel *agreementR = [UILabel hyb_labelWithText:@"登录即表示同意" font:AUTO(12) superView:self.view constraints:^(MASConstraintMaker *make) {
       make.left.mas_equalTo(AUTO(30));
        make.top.equalTo(phoneR.mas_bottom);
        make.height.mas_equalTo(AUTO(30));
    }];
    agreementR.textColor = SK_COLOR_BASE_TEXT_GRAY;
    //用户协议按钮
    UIButton *agreementB = [UIButton hyb_buttonWithTitle:@"《用户协议》" superView:self.view constraints:^(MASConstraintMaker *make) {
        make.left.equalTo(agreementR.mas_right);
        make.top.equalTo(phoneR.mas_bottom);
        make.height.mas_equalTo(AUTO(30));
        
    } touchUp:^(UIButton *sender) {
        TOAST(@"点击用户协议");
    }];
//    agreementB.titleLabel.textColor = SK_COLOR_BASE_TEXT_BLUE;
    [agreementB setTitleColor:SK_COLOR_BASE_TEXT_BLUE forState:UIControlStateNormal];
    agreementB.titleLabel.font = FONT(AUTO(12));
    
    UILabel *heR = [UILabel hyb_labelWithText:@"和" font:AUTO(12) superView:self.view constraints:^(MASConstraintMaker *make) {
        make.left.equalTo(agreementB.mas_right);
        make.top.equalTo(phoneR.mas_bottom);
        make.height.mas_equalTo(AUTO(30));
    }];
    heR.textColor = SK_COLOR_BASE_TEXT_GRAY;
    
    //隐私政策按钮
    UIButton *privacyB = [UIButton hyb_buttonWithTitle:@"《隐私政策》" superView:self.view constraints:^(MASConstraintMaker *make) {
        make.left.equalTo(heR.mas_right);
        make.top.equalTo(phoneR.mas_bottom);
        make.height.mas_equalTo(AUTO(30));
        
    } touchUp:^(UIButton *sender) {
        TOAST(@"隐私政策");
    }];
    [privacyB setTitleColor:SK_COLOR_BASE_TEXT_BLUE forState:UIControlStateNormal];
    privacyB.titleLabel.font = FONT(AUTO(12));
    
    
    UILabel *numL = [UILabel hyb_labelWithText:@"+86" font:NSIZE superView:self.view constraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SK_MARGIN);
        make.width.mas_equalTo(AUTO(60));
        make.top.mas_equalTo(agreementR.mas_bottom);
        make.height.mas_equalTo(AUTO(50));
    }];
    numL.textColor = SK_COLOR_BASE_TEXT_BLACK;
    
    [UIView hyb_addBottomLineToView:numL height:1 color:SK_COLOR_BASE_LINE];
    
    //输入手机号
    UITextField *tellPhoneT = [UITextField hyb_textFieldWithHolder:@"请输入正确的手机号" delegate:self superView:self.view constraints:^(MASConstraintMaker *make) {
        make.left.equalTo(numL.mas_right);
        make.right.mas_equalTo(-SK_MARGIN);
        make.top.mas_equalTo(agreementR.mas_bottom);
        make.height.mas_equalTo(AUTO(50));
    }];
    tellPhoneT.textColor = SK_COLOR_BASE_TEXT_BLACK;
    tellPhoneT.font = NFONT;
    
    tellPhoneT.text = @"13999999999";
    
    self.tellPhoneT = tellPhoneT;

    [UIView hyb_addBottomLineToView:tellPhoneT height:1 color:SK_COLOR_BASE_LINE];
    
    //验证码按钮
    UIButton *verificationCodeB = [UIButton hyb_buttonWithTitle:@"获取验证码" superView:self.view constraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-SK_MARGIN);
        make.width.mas_equalTo(AUTO(90));
        make.top.mas_equalTo(tellPhoneT.mas_bottom);
        make.height.mas_equalTo(AUTO(50));

    } touchUp:^(UIButton *sender) {

        if (this.tellPhoneT.text.length <= 0 ) {
            TOAST(@"您还未填写手机号！");
            return;
        }
            this.verificationCodeB.enabled = NO;
//        [this.loginB setUserInteractionEnabled:YES];
            this.iTime = 10;
            this.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
            [this performSelectorOnMainThread:@selector(UI_update_btnCode) withObject:nil waitUntilDone:NO];

    }];
    [verificationCodeB setTitleColor:SK_COLOR_BASE_TEXT_ORANGE forState:UIControlStateNormal];
    verificationCodeB.titleLabel.font = FONT(AUTO(14));
    self.verificationCodeB = verificationCodeB;

    [UIView hyb_addBottomLineToView:verificationCodeB height:1 color:SK_COLOR_BASE_LINE];

    //输入验证码
    UITextField *verificationCodeT = [UITextField hyb_textFieldWithHolder:@"请输入验证码" text:@"" delegate:self superView:self.view constraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SK_MARGIN);
        make.right.equalTo(verificationCodeB.mas_left);
        make.top.mas_equalTo(tellPhoneT.mas_bottom);
        make.height.mas_equalTo(AUTO(50));
    }];
    verificationCodeT.font = NFONT;
    verificationCodeT.textColor = SK_COLOR_BASE_TEXT_BLACK;
    verificationCodeT.keyboardType = UIKeyboardTypeNumberPad;
    verificationCodeT.text = @"123";
    
    
    self.verificationCodeT = verificationCodeT;

     [UIView hyb_addBottomLineToView:verificationCodeT height:1 color:SK_COLOR_BASE_LINE];


    //登录按钮
    UIButton *loginB = [UIButton hyb_buttonWithTitle:@"登录" superView:self.view constraints:^(MASConstraintMaker *make) {
       make.left.mas_equalTo(AUTO(20));
       make.right.mas_equalTo(-AUTO(20));
       make.top.equalTo(verificationCodeT.mas_bottom).offset(AUTO(60));
       make.height.mas_equalTo(AUTO(50));
    } touchUp:^(UIButton *sender) {
        TOAST(@"登录成功");
//        [this Net_Login];
        
        MHDrawViewController *drawVc = [self loadNavigationController];
        [self.view.window setRootViewController:drawVc];
    }];
     loginB.titleLabel.font = NFONT;
     loginB.layer.cornerRadius = AUTO(25);
     loginB.backgroundColor = SK_COLOR_BASE_ORANGE;
    self.loginB = loginB;

    //判断是否有安装微信
//    if ([MHPayManager isWXAppInstalled]) {

        UILabel *wxL = [UILabel hyb_labelWithText:@"微信登录" font:AUTO(13) superView:self.view constraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-AUTO(10)-kBottomHeight);
            make.left.and.right.mas_equalTo(0);
            make.height.mas_equalTo(AUTO(25));
        }];
        wxL.textColor = SK_COLOR_BASE_TEXT_GRAY;
        wxL.textAlignment = NSTextAlignmentCenter;

//     UIButton *wxAuthB =
       [UIButton hyb_buttonWithImage:@"p_weixin" superView:self.view constraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(wxL.mas_top);
            make.size.mas_equalTo(CGSizeMake(50,50));
            make.centerX.equalTo(self.view);
        } touchUp:^(UIButton *sender) {
            TOAST(@"微信登录");
        }];

//    }
}

#pragma mark - action

- (void)UI_update_btnCode
{
    NSString *title = [NSString stringWithFormat:@"重新发送(%ld)", (long)_iTime];
    [self.verificationCodeB setTitle:title forState:UIControlStateNormal];
}


- (void)timerAction
{
    self.iTime--;
    if ( self.iTime <= 0) {
        [self.timer invalidate];
        self.verificationCodeB.enabled = YES;
        [self.verificationCodeB setTitle:@"重新发送" forState:UIControlStateNormal];
//        [self.verificationCodeB setImage:IMG(@"icon_arrow_r") forState:UIControlStateNormal];
//        [ self.verificationCodeB setTitleColor:SK_COLOR_BASE_TEXT_RED forState:0];
        return;
    }
    
    [self performSelectorOnMainThread:@selector(UI_update_btnCode) withObject:nil waitUntilDone:NO];
}



#pragma mark - delegate

//限制最大输入字数限制
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    if (textField == self.tellPhoneT) {
        NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        if ([toBeString length] > 11) {
            return NO;
        }
    }
//    if([string hasSuffix:@" "])     // 忽视空格
//        return NO;
//    else
//        return YES;
    return YES;
}


#pragma mark - Net
//登录
- (void)Net_Login
{
//     __weak typeof(self )this = self;
    
    SkNetLoginRequest *request = [[SkNetLoginRequest alloc]init];
    request.phone = self.tellPhoneT.text;
    request.password = self.verificationCodeT.text;
    [SkNetApi request:request success:^(NSDictionary *pDic) {

        if (kDic(pDic)) {
            [FUCacheManager write:COMMON_USER_TOKEN value:pDic[@"data"]];
             [SkUserDefaults writeIsBool:YES key:KEY_BOOL_LOGIN];
    //         HomeTabViewController* tab = [[HomeTabViewController alloc]init];
    //        self.view.window.rootViewController = tab;
            
//            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:[[NSClassFromString(@"HomeTabViewController") alloc]init]];
            MHDrawViewController *drawVc = [self loadNavigationController];
            [self.view.window setRootViewController:drawVc];
            [FUPROGRESS_HUD success:@"登录成功"];
        }
    } failure:^(NSError *pError) {

    }];

}

#pragma mark - 导航控制器/TabBar控制器
- (MHDrawViewController *)loadNavigationController
{
    // 左侧抽屉
//    UIViewController *leftVC = [UIViewController new];
    // 右侧抽屉
    MHSettingViewController *rightVC = [MHSettingViewController new];

    HomeTabViewController *tabBarVC = [HomeTabViewController new];
    MHDrawViewController *drawVC = [[MHDrawViewController alloc] initWithRootVC:tabBarVC leftVC:nil rightVC:rightVC];
    return drawVC;
}




@end
