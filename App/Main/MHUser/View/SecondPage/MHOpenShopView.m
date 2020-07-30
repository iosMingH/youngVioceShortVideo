//
//  MHOpenShopView.m
//  App
//
//  Created by dayewang on 2020/7/15.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import "MHOpenShopView.h"
#define KY_MTITLE @"key_title"
#define KY_MMARK  @"key_mark"
#define KY_MIMAGE @"key_image"
//申请开店
@interface MHOpenShopView ()<UITextFieldDelegate>
@property(nonatomic,strong)UITextField *tellPhoneT;
@property(nonatomic,strong)UITextField *verificationCodeT;
@property(nonatomic,strong)UITextField *nameT;
@property(nonatomic,strong)UITextField *areaT;
@property(nonatomic,strong)UIButton *verificationCodeB;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger iTime;
@property(nonatomic,strong)NSArray *menusData;

@end

@implementation MHOpenShopView


-(void)initData{
    
    self.menusData = @[
        @{KY_MTITLE:@"取消",
          KY_MMARK:@"100",
          KY_MIMAGE:@""},
        @{KY_MTITLE:@"确定",
          KY_MMARK:@"200",
          KY_MIMAGE:@""}
    ];
}


- (void)initControl{
    
     __weak typeof(self) this = self;
    
    UILabel *titleL = [UILabel hyb_labelWithText:@"验证手机号" font:AUTO(16) superView:self constraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(SK_MARGINLR);
        make.height.mas_equalTo(AUTO(30));
    }];
    titleL.textColor = SK_COLOR_BASE_TEXT_BLACK_DEEP;
    titleL.textAlignment = NSTextAlignmentCenter;
    
    //输入姓名
        UITextField *nameT = [UITextField hyb_textFieldWithHolder:@"在此输入姓名" delegate:self superView:self constraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SK_MARGINLR);
            make.right.mas_equalTo(-SK_MARGINLR);
            make.top.equalTo(titleL.mas_bottom).offset(AUTO(20));
            make.height.mas_equalTo(AUTO(50));
        }];
        nameT.textColor = SK_COLOR_BASE_TEXT_BLACK;
        nameT.backgroundColor = HEXCOLOR(0xF7F7F7);
        nameT.font = NFONT;
    
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, AUTO(50))];
        nameT.leftViewMode = UITextFieldViewModeAlways;
        nameT.leftView = leftView;
        self.nameT = nameT;
    
    //输入地区
        UITextField *areaT = [UITextField hyb_textFieldWithHolder:@"在此输入地区" delegate:self superView:self constraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SK_MARGINLR);
            make.right.mas_equalTo(-SK_MARGINLR);
            make.top.equalTo(nameT.mas_bottom).offset(AUTO(20));
            make.height.mas_equalTo(AUTO(50));
        }];
        areaT.textColor = SK_COLOR_BASE_TEXT_BLACK;
        areaT.backgroundColor = HEXCOLOR(0xF7F7F7);
        areaT.font = NFONT;
    
        leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, AUTO(50))];
        areaT.leftViewMode = UITextFieldViewModeAlways;
        areaT.leftView = leftView;
        self.areaT = areaT;
    
    //输入手机号
        UITextField *tellPhoneT = [UITextField hyb_textFieldWithHolder:@"在此输入手机号码" delegate:self superView:self constraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SK_MARGINLR);
            make.right.mas_equalTo(-SK_MARGINLR);
            make.top.equalTo(areaT.mas_bottom).offset(AUTO(20));
            make.height.mas_equalTo(AUTO(50));
        }];
        tellPhoneT.textColor = SK_COLOR_BASE_TEXT_BLACK;
        tellPhoneT.backgroundColor = HEXCOLOR(0xF7F7F7);
        tellPhoneT.font = NFONT;
        tellPhoneT.keyboardType = UIKeyboardTypeNumberPad;
    
        leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, AUTO(50))];
        tellPhoneT.leftViewMode = UITextFieldViewModeAlways;
        tellPhoneT.leftView = leftView;
        self.tellPhoneT = tellPhoneT;

    
        //验证码按钮
        UIButton *verificationCodeB = [UIButton hyb_buttonWithTitle:@"获取" superView:self constraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-SK_MARGINLR);
            make.width.mas_equalTo(AUTO(90));
            make.top.mas_equalTo(tellPhoneT.mas_bottom).offset(AUTO(10));;
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
    verificationCodeB.backgroundColor = HEXCOLOR(0xF7F7F7);
        self.verificationCodeB = verificationCodeB;


        //输入验证码
        UITextField *verificationCodeT = [UITextField hyb_textFieldWithHolder:@"请输入验证码" text:@"" delegate:self superView:self constraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SK_MARGINLR);
            make.right.equalTo(verificationCodeB.mas_left);
            make.top.mas_equalTo(tellPhoneT.mas_bottom).offset(AUTO(10));
            make.height.mas_equalTo(AUTO(50));
        }];
        verificationCodeT.font = NFONT;
        verificationCodeT.textColor = SK_COLOR_BASE_TEXT_BLACK;
        verificationCodeT.backgroundColor = HEXCOLOR(0xF7F7F7);
        verificationCodeT.keyboardType = UIKeyboardTypeNumberPad;
       leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, AUTO(50))];
       verificationCodeT.leftViewMode = UITextFieldViewModeAlways;
       verificationCodeT.leftView = leftView;
        
        self.verificationCodeT = verificationCodeT;


    CGFloat widthV = self.width/self.menusData.count;
    
    for (int i = 0; i < self.menusData.count; i++) {
        NSDictionary* item = [self.menusData objectAtIndex:i];
        UIView *titleV = [UIView hyb_viewWithSuperView:self constraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(AUTO(70));
            make.width.mas_equalTo(widthV);
            make.left.mas_equalTo(i*widthV);
        } onTaped:^(UITapGestureRecognizer *sender) {
            
            [self infoAction:sender];
            
        }];
        [UIView hyb_addTopLineToView:titleV height:0.5 color:SK_COLOR_BASE_LINE];
        
        titleV.tag = [[item objectForKey:KY_MMARK]integerValue];
        
        UILabel *label = [UILabel hyb_labelWithText:[item objectForKey:KY_MTITLE] font:AUTO(16) superView:titleV constraints:^(MASConstraintMaker *make) {
            make.left.and.right.and.bottom.mas_equalTo(0);
            make.height.equalTo(titleV);
        }];
        label.textColor =SK_COLOR_BASE_TEXT_GRAY;
        label.textAlignment = NSTextAlignmentCenter;
        
        if (i == 1) {
            label.textColor = SK_COLOR_BASE_TEXT_ORANGE;
        }

    }
    
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

- (void)infoAction:(UITapGestureRecognizer *)sender{
     [[HWPopTool sharedInstance] closeWithBlcok:nil];
   
     NSInteger tag = [sender view].tag;
    if (tag == 200) {
        NoticeModel* model = [[NoticeModel alloc]init:tag msg:nil data:nil];
        NSString* targer = @"MHSettingViewController";
        [[NSNotificationCenter defaultCenter] postNotificationName:targer object:nil userInfo:[model mj_keyValues]];
    }
      
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


@end



//签到 *******************
@interface MHSignInView ()

@end

@implementation MHSignInView

- (void)initControl{
    UIImageView *iconV = [UIImageView hyb_imageViewWithImage:@"p_right_star" superView:self constraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SK_MARGINLR);
        make.size.mas_equalTo(CGSizeMake(AUTO(126), AUTO(100)));
        make.centerX.equalTo(self);
    }];
    
    UILabel *titleL = [UILabel hyb_labelWithText:@"签到成功" font:AUTO(15) superView:self constraints:^(MASConstraintMaker *make) {
        make.top.equalTo(iconV.mas_bottom).offset(AUTO(15));
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(AUTO(30));
    }];
    titleL.textColor = SK_COLOR_BASE_TEXT_BLACK_DEEP;
    titleL.textAlignment = NSTextAlignmentCenter;
    
    UILabel *contentL = [UILabel hyb_labelWithFont:AUTO(13) superView:self constraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleL.mas_bottom).offset(0);
        make.left.mas_equalTo(SK_MARGINLR);
        make.right.mas_equalTo(-SK_MARGINLR);
        make.height.mas_equalTo(AUTO(50));
    }];
    contentL.numberOfLines = 2;
    contentL.text = @"获得5积分，保持连续签到可以获得更多的机会哦~";
    contentL.textColor = SK_COLOR_BASE_TEXT_GRAY;
    
    UIButton *btn = [UIButton hyb_buttonWithTitle:@"我知道了" superView:self constraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(AUTO(60));
        make.bottom.mas_equalTo(0);
    } touchUp:^(UIButton *sender) {
        //关闭弹窗
        [[HWPopTool sharedInstance] closeWithBlcok:nil];
    }];
    btn.titleLabel.font = FONT(AUTO(15));
    [btn setTitleColor:SK_COLOR_BASE_TEXT_ORANGE forState:UIControlStateNormal];
    
    [UIView hyb_addTopLineToView:btn height:0.5 color:SK_COLOR_BASE_LINE];
}

@end


