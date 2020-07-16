//
//  SCLoginController.m
//  App
//
//  Created by mac on 2018/1/2.
//  Copyright © 2018年 HuanMingLi. All rights reserved.
//

#import "SCLoginController.h"
#import "CEMainTabbarController.h"
#import "RSA.h"
#import "AES.h"
#import "WechatAuthSDK.h"
#import "PaySignModel.h"
#import "HomeTabViewController.h"
#define HEIGHT_HEAD     AUTO(234)
#define HEIGHT_ACCOUNTVIEW  AUTO(170)
@interface SCLoginController ()<UITextFieldDelegate,WXApiManagerDelegate, WechatAuthAPIDelegate>
@property(nonatomic ,strong)UIImageView *headImageV;
@property(nonatomic ,strong)UITextField *businessT;
@property(nonatomic ,strong)UITextField *accountT;
@property(nonatomic ,strong)UITextField *passwordT;
@property(nonatomic ,strong)UIButton *rememberB;
@property(nonatomic ,strong)UIButton *loginB;
@property(nonatomic ,strong)UIButton *forgetB;
@property(nonatomic ,strong)UIButton *accountB;
@property(nonatomic ,strong)NSMutableArray *dataList;
@property(nonatomic ,strong)UIButton *headBtn;
@property(nonatomic ,assign)int tapCount;
@property(nonatomic ,strong)UILabel *textLabel;

@property (nonatomic, copy) NSString *publicKey;
@property (nonatomic, copy) NSString *aesKey;
@end

@implementation SCLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self returnKeyHandler];
    self.tapCount = 0;
      [WXApiManager sharedManager].delegate = self;
        
    self.publicKey = @"MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAuA4mjtn88xav8vNPeuCmL6P10EsyZWNeVpqwrdSJp9pGhdHjixG6yXKmdBoV8Oq6fGBeHwCZGsVDoQhjdUykNR5J/BPU3wZXV0QOwCTk2ovr6ILNBuRsh+gUK8qdXOyu6i1UIgG3bFNmMBQL1e6CkRWwXEdy0CqN9VTmswgd4iLyGAvl/5T3V003uWfAFsjx8KnJorISWZ5nvo16vqVM3O2Hq38RB7IF/P94ZoCyfcpDWBc/P0UKsq9GNcEkjfFlQL8hRftHdrogL7kQISWwcp8Q6HAEtCAScYRH3K7qa01jX0ngMLAP33n0qxEQfY3MCTSWvhffySWFMGmkBaATmwIDAQAB";
    self.aesKey = @"0123456789abcdef";

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    [self.accountT resignFirstResponder];
    [self.businessT resignFirstResponder];
    [self.passwordT resignFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:animated];
    //设置导航栏背景图片为一个无图的image，导航栏会加载空imgae，就自然透明掉了
          [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
      //    同理透明掉导航栏下划线
          [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)initView{
 
    
//     __weak typeof(self) wkThis = self;
    CGFloat textW = AUTO(306);
    CGFloat p = (DEVICEWIDTH - textW)*0.5;
    CGFloat textH = AUTO(50);
    NSArray *titles = @[@"企业号",@"账号",@"密码"];
    for (int idx = 0; idx < titles.count; idx++) {
        UITextField *textF = [[UITextField alloc]init];
        textF.placeholder = titles[idx];
         [self.view addSubview:textF];
//        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, AUTO(30), textH)];
//        textF.rightView = paddingView;
//        textF.rightViewMode = UITextFieldViewModeAlways;
//        [self.view addSubview:textF];
//
//        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0,paddingView.bounds.size.width, paddingView.bounds.size.height)];
//        [paddingView addSubview:btn];
        
        [textF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(p);
            make.right.mas_equalTo(-p);
            make.height.mas_equalTo(textH);
//        make.top.equalTo(wkThis.headImageV.mas_bottom).offset(AUTO(30)+textH*idx);
            make.top.mas_equalTo(self.view).offset(AUTO(150)+textH*idx);
        }];
        
        switch (idx) {
            case 0:
            {
                self.businessT = textF;
            }
                break;
            case 1:
            {
                textF.text = @"13999999999";
                self.accountT = textF;
            }
                break;
            case 2:
            {
                //密文样式
                textF.secureTextEntry=YES;
                textF.borderStyle=UITextBorderStyleNone;
                textF.text = @"123";
                self.passwordT = textF;
                
            }
                break;
                
            default:
                break;
        }
        
    }
    
    self.loginB = [[UIButton alloc]init];
    [self.view addSubview: self.loginB];
    [self.loginB setTitle:@"登录" forState:UIControlStateNormal];
    [self.loginB setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.loginB addTarget:self action:@selector(btnLoginTarget:) forControlEvents:UIControlEventTouchUpInside];
    self.loginB.titleLabel.font = FONT(AUTO(16));
    self.loginB.backgroundColor = SK_COLOR_BASE_NAV;
    

    __weak typeof(self) wkThis = self;
 
    [self.loginB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(p);
        make.right.mas_equalTo(-p);
        make.top.equalTo(wkThis.passwordT.mas_bottom).offset(AUTO(37));
        make.height.mas_equalTo(AUTO(50));
    }];
    self.loginB.layer.cornerRadius = AUTO(25);
    
    
    if ([MHPayManager isWXAppInstalled]) {
         UIButton *collectBtn = [[UIButton alloc]init];
              [self.view addSubview: collectBtn];
              [collectBtn setTitle:@"微信授权登录" forState:UIControlStateNormal];
              [collectBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
              [collectBtn addTarget:self action:@selector(btncollectTarget:) forControlEvents:UIControlEventTouchUpInside];
              collectBtn.titleLabel.font = FONT(AUTO(16));
              collectBtn.backgroundColor = SK_COLOR_BASE_NAV;
              
           
              [collectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                  make.left.mas_equalTo(p);
                  make.right.mas_equalTo(-p);
                  make.top.equalTo(wkThis.loginB.mas_bottom).offset(AUTO(37));
                  make.height.mas_equalTo(AUTO(50));
              }];
              collectBtn.layer.cornerRadius = AUTO(25);
    }
}


- (void)initLayout{
    

    
}

//限制最大输入字数限制
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
//    if (textField == _telphoneText) {
//        NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
//        if ([toBeString length] > 11) {
//
//            return NO;
//        }
//    }
//    if([string hasSuffix:@" "])     // 忽视空格
//        return NO;
//    else
//        return YES;
    return YES;
}


#pragma mark - btnAction

//登录
- (void)btnLoginTarget:(UIButton *)pBtn
{
//    self.businessT.text = @"1";
//    self.accountT.text = @"test";
//    self.passwordT.text = @"123456";
//    if (self.businessT.text.length > 0 && self.accountT.text.length > 0 && self.passwordT.text.length > 0) {
        [self Net_Login];
//    }else{
//        TOAST(@"你还有账号或密码未输入！");
//    }
    
//    SkNetGetSortMsgCodeRequest *request = [[SkNetGetSortMsgCodeRequest alloc]init];
//    request.mobileNo = @"25106096360";
//    [SkNetApi request:request success:^(NSDictionary *pDic) {
//        NSLog(@"pdic=%@",pDic);
//        self.publicKey = pDic[@"data"];
//    } failure:^(NSError *pError) {
//
//    }];
    
    
}
- (void)btncollectTarget:(UIButton *)pBtn{
    
    [self Net_Collect];
//    SkNetRegisterRequest *request = [[SkNetRegisterRequest alloc]init];
//      NSLog(@"self.publicKey=%@",self.publicKey);
//    request.token = self.publicKey;
//    request.code = self.businessT.text;
//    [SkNetApi request:request success:^(NSDictionary *pDic) {
//        NSLog(@"pdic=%@",pDic);
//    } failure:^(NSError *pError) {
//
//    }];
}




#pragma mark - net
- (void)Net_Login
{
//     __weak typeof(self )this = self;


//    SkNetDecryptRequest *request = [[SkNetDecryptRequest alloc]init];


//    [SkNetApi request:request success:^(NSDictionary *pDic) {
//        NSLog(@"pdic=%@",pDic);
//        NSString *encryptContent  = pDic[@"data"];
//         NSLog(@"encryptContent=%@",encryptContent);
//       NSString *content = [RSA decryptString:encryptContent publicKey:self.publicKey];
//         NSLog(@"content=%@",content);
//    } failure:^(NSError *pError) {
//
//    }];
    
    
    SkNetLoginRequest *request = [[SkNetLoginRequest alloc]init];
    request.phone = self.accountT.text;
    request.password = self.passwordT.text;
    [SkNetApi request:request success:^(NSDictionary *pDic) {

        if (kDic(pDic)) {
            [FUCacheManager write:COMMON_USER_TOKEN value:pDic[@"data"]];
             [SkUserDefaults writeIsBool:YES key:KEY_BOOL_LOGIN];
    //         HomeTabViewController* tab = [[HomeTabViewController alloc]init];
    //        self.view.window.rootViewController = tab;
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:[[NSClassFromString(@"HomeTabViewController") alloc]init]];
            [self.view.window setRootViewController:nav];
            [FUPROGRESS_HUD success:@"登录成功"];
        }
    } failure:^(NSError *pError) {

    }];

    
    
//    [SCLoginStatusTool LoginWithCompanyId:[self.businessT.text intValue] loginName:self.accountT.text loginPassword:self.passwordT.text storeId:@"" token:@"" success:^(NSDictionary *statusDic) {
//        if ([statusDic objectForKey:@"token"]) {
//            [FUCacheManager write:COMMON_USER_TOKEN value:statusDic[@"token"]];
//        }
//        if ([statusDic objectForKey:@"userCode"]) {
//        }
//        if ([statusDic objectForKey:@"userID"]) {
//        }
//        if ([statusDic objectForKey:@"account"]) {
//            [FUCacheManager write:COMMON_USER_ACCOUNT value:statusDic[@"account"]];
//        }
//        if ([statusDic objectForKey:@"fullName"]) {
////            [FUCacheManager write:COMMON_USER_USERNAME value:statusDic[@"fullName"]];
//        }
//        if ([statusDic objectForKey:@"photo"]) {
//            [FUCacheManager write:COMMON_USER_USERPHOTO value:statusDic[@"photo"]];
//        }
//
//        [SCUserInfoSave writeAccountInfoKey:USER_ACCOUNT content:self.accountT.text total:USER_HISTORY];
//        if (self.rememberB.isSelected) {
//            NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
//            [dic setValue:self.businessT.text  forKey:@"businessNo"];
//            [dic setValue:self.passwordT.text forKey:@"password"];
//            [FUCacheManager write:self.accountT.text value:dic];
////            [FUCacheManager write:self.accountT.text value:self.passwordT.text];
//        }else{
//            [FUCacheManager remove:self.accountT.text];
//        }
//        [FUCacheManager write:COMMON_USER_BUSINESSID value:self.businessT.text];
//        [FUCacheManager write:COMMON_USER_USERNAME value:self.accountT.text];
//        [FUCacheManager write:COMMON_USER_PASSWORD value:self.passwordT.text];
//        [SkUserDefaults writeIsBool:YES key:KEY_BOOL_LOGIN];
//
//        if ([FUCacheManager read:COMMON_USER_STOREID] != nil) {
//           [self Net_Login_storeId:[FUCacheManager read:COMMON_USER_STOREID]];
//        }else{
//            CEMainTabbarController* tab = [[CEMainTabbarController alloc]init];
//            self.view.window.rootViewController = tab;
//            [FUPROGRESS_HUD success:@"登录成功"];
//        }
//
//    } failure:^(NSError *error) {
//
//    }];
}

- (void)Net_Collect
{
      __weak typeof(self )this = self;
    [[MHPayManager sharedManager] wxAuthLogin:WX_Auth_Scope vc:self respBlock:^(NSInteger resultCode, NSString *resultMsg) {
        NSLog(@"resultMsg=%@",resultMsg);
         if (0 == resultCode) {
        //            [FUPROGRESS_HUD error:@"接口还没添加"];
                    [this wxOpenUnion:resultMsg];
                }else{
                    [FUPROGRESS_HUD error:resultMsg];
                }
    }];
    
//    [FUCacheManager read:<#(NSString *)#>];
//    SkNetCollectRequest *request = [[SkNetCollectRequest alloc]init];
//    request.token =  [FUCacheManager read:COMMON_USER_TOKEN];
//
//      [SkNetApi request:request success:^(NSDictionary *pDic) {
//
//          NSLog(@"pDic=%@",pDic);
//
//      } failure:^(NSError *pError) {
//
//
//      }];
    
    
//    NSString *content = @"漳州开发区大家好";
//    NSString *encryptContent = [AES AESEncrypt:content key:self.aesKey];
//    NSString *str = [AES AESDecrypt:encryptContent key:self.aesKey];
//    NSLog(@"str=%@",str);
//    SkNetencryptRequest *request = [[SkNetencryptRequest alloc]init];
//    request.source = content;
//    request.encryptStr  = encryptContent;
//    [SkNetApi request:request success:^(NSDictionary *pDic) {
//        NSLog(@"pdci=%@",pDic);
//    } failure:^(NSError *pError) {
//
//    }];
}


-(void)wxOpenUnion:(NSString*)openid
{
    
//   __weak typeof(self)this = self;
    [SkNetApi reqWxUnionId:openid success:^(NSDictionary *resp) {
         NSLog(@"resp=%@",resp);
        NSString* unionid = [resp objectForKey:@"unionid"];
        NSLog(@"unionid=%@",unionid);
        TOAST(unionid);
    } failure:^(NSError *err) {
           [FUPROGRESS_HUD info:@"微信授权错误"];
       }];
     
}

@end
