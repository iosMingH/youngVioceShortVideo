//
//  MHCourseBuyView.m
//  App
//
//  Created by dayewang on 2020/7/14.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import "MHCourseBuyView.h"

@interface MHCourseBuyView ()
@property(nonatomic,strong)UILabel *titleL;   //课程价格

@property(nonatomic,strong)UILabel *contentL;   //实际支付

@end

@implementation MHCourseBuyView

-(void)initControl{
    
    CGFloat widthV = DEVICEWIDTH;
    CGFloat heightV = AUTO(50);
    
    NSArray *titles = @[@"课程价格",@"积分",@"实际支付"];
    
    for (int i = 0; i < titles.count; i++) {
        UIView *view = [UIView hyb_viewWithSuperView:self constraints:^(MASConstraintMaker *make) {
            make.left.and.right.mas_equalTo(0);
            make.top.mas_equalTo(heightV*i);
            make.height.mas_equalTo(heightV);
        }];
        [UIView hyb_addBottomLineToView:view height:0.5 color:SK_COLOR_BASE_LINE];
        
        UILabel *label = [UILabel hyb_labelWithFont:KSIZE superView:view constraints:^(MASConstraintMaker *make) {
            make.top.and.bottom.mas_equalTo(0);
            make.left.mas_equalTo(SK_MARGINLR);
            make.width.equalTo(view).multipliedBy(0.5);
        }];
        
        label.text = titles[i];
        label.textColor = SK_COLOR_BASE_TEXT_BLACK_DEEP;
        
        UILabel *remarkL = [UILabel hyb_labelWithFont:KSIZE superView:view constraints:^(MASConstraintMaker *make) {
            make.top.and.bottom.mas_equalTo(0);
            make.right.mas_equalTo(-SK_MARGINLR);
            make.width.equalTo(view).multipliedBy(0.5);
        }];
        remarkL.textAlignment = NSTextAlignmentRight;
        
        remarkL.text = @"199";
        remarkL.textColor = SK_COLOR_BASE_TEXT_BLACK_DEEP;
        
        switch (i) {
            case 0:
            {
                self.titleL = remarkL;
            }
                break;
            case 1:
            {
                remarkL.hidden = YES;
                
                UISwitch *openBtn = [UISwitch hyb_viewWithSuperView:view constraints:^(MASConstraintMaker *make) {
                    make.right.mas_equalTo(-SK_MARGINLR);
                    make.size.mas_equalTo(CGSizeMake(AUTO(47), AUTO(23)));
                    make.centerY.equalTo(view);
             
                }];
                [openBtn addTarget:self action:@selector(switchChange:) forControlEvents:UIControlEventValueChanged];
                openBtn.on=YES;
                openBtn.onTintColor = SK_COLOR_BASE_ORANGE;
            }
                break;
            case 2:
            {
                 self.contentL = remarkL;
            }
                break;
                
            default:
                break;
        }
        
        
    }
    
    UIButton *btn = [UIButton hyb_buttonWithTitle:@"确认支付" superView:self constraints:^(MASConstraintMaker *make) {
           make.left.mas_equalTo(SK_MARGINLR);
           make.right.mas_equalTo(-SK_MARGINLR);
           make.bottom.mas_equalTo(-SK_MARGINLR);
           make.height.mas_equalTo(AUTO(44));
       } touchUp:^(UIButton *sender) {
           NSInteger tag = sender.tag;
           NoticeModel* model = [[NoticeModel alloc]init:tag msg:nil data:nil];
           NSString* targer = @"MHCourseVideoDetailViewController";
           [[NSNotificationCenter defaultCenter] postNotificationName:targer object:nil userInfo:[model mj_keyValues]];
       }];
       btn.layer.cornerRadius = AUTO(22);
       btn.backgroundColor = SK_COLOR_BASE_ORANGE;
       [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
       btn.titleLabel.font = FONT(AUTO(16));
       btn.tag = 1000;
    
}

#pragma mark - action
// switch改变
-(void)switchChange:(id)sender{
   UISwitch* openbutton = (UISwitch*)sender;
   Boolean ison = openbutton.isOn;
    if(ison){
        TOAST(@"打开了");
    }else{
        TOAST(@"关闭了");
    }
}



-(void)setModel:(id)model section:(NSInteger )section{
    
    
}
@end
