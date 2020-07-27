//
//  MHShareWXView.m
//  App
//
//  Created by dayewang on 2020/7/21.
//  Copyright © 2020 李焕明. All rights reserved.
// 分享视图

#import "MHShareWXView.h"


#define KY_MTITLE @"key_title"
#define KY_MMARK  @"key_mark"
#define KY_MIMAGE @"key_image"

@interface MHShareWXView ()
@property(nonatomic,strong)NSArray *menusData;

@end

@implementation MHShareWXView

- (void)initData{
    self.menusData = @[
        @{KY_MTITLE:@"微信好友",
          KY_MMARK:@"100",
          KY_MIMAGE:@"p_weixin"},
        @{KY_MTITLE:@"朋友圈",
          KY_MMARK:@"200",
          KY_MIMAGE:@"p_circle"}];
}

- (void)initControl{
    
    self.backgroundColor = [UIColor whiteColor];
    
    UILabel *title = [UILabel hyb_labelWithText:@"分享到" font:AUTO(13) superView:self constraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(AUTO(80), AUTO(30)));
        make.centerX.equalTo(self);
    }];
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = SK_COLOR_BASE_TEXT_GRAY;
    
    UIView *vLine = [UIView hyb_viewWithSuperView:self constraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(2*SK_MARGINLR);
        make.right.equalTo(title.mas_left).offset(-SK_MARGINLR);
        make.centerY.equalTo(title);
        make.height.mas_equalTo(0.5);
    }];
    vLine.backgroundColor = SK_COLOR_BASE_LINE;
    
    vLine = [UIView hyb_viewWithSuperView:self constraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-2*SK_MARGINLR);
        make.left.equalTo(title.mas_right).offset(SK_MARGINLR);
        make.centerY.equalTo(title);
        make.height.mas_equalTo(0.5);
    }];
    vLine.backgroundColor = SK_COLOR_BASE_LINE;
    
    CGFloat btnW = DEVICEWIDTH*0.5;
    CGFloat btnH = AUTO(80);

    for (int i = 0; i < self.menusData.count; i++) {
        NSDictionary* item = [self.menusData objectAtIndex:i];
        UIView *titleV = [UIView hyb_viewWithSuperView:self constraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(50);
            make.height.mas_equalTo(btnH);
            make.width.mas_equalTo(btnW);
            make.left.mas_equalTo(i*btnW);
        }];
//        titleV.tag = [[item objectForKey:KY_MMARK]integerValue];
        
        UIButton *btn = [UIButton hyb_buttonWithTitle:[item objectForKey:KY_MTITLE] superView:titleV constraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(AUTO(100), AUTO(100)));
            make.top.mas_equalTo(0);
            make.centerX.equalTo(titleV);
        } touchUp:^(UIButton *sender) {
              [self infoAction:sender];
        }];
        btn.tag = [[item objectForKey:KY_MMARK]integerValue];
       [btn.titleLabel setFont:[UIFont systemFontOfSize:AUTO(14)]];
       [btn setTitleEdgeInsets:UIEdgeInsetsMake(30, 0, 0, 0)];
       [btn setTitleColor:SK_COLOR_BASE_TEXT_GRAY_DEEP forState:UIControlStateNormal];
        
        UIImageView *icon = [UIImageView hyb_imageViewWithImage:[item objectForKey:KY_MIMAGE] superView:btn constraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(AUTO(45), AUTO(45)));
            make.top.mas_equalTo(0);
            make.centerX.equalTo(btn);
        }];
        icon.contentMode = UIViewContentModeScaleAspectFit;
    
    }
        
}

- (void)infoAction:(UIButton *)sender{
    NSString *tag = [NSString stringWithFormat:@"%ld",sender.tag];
    NSDictionary *dic = @{@"tag":tag};
    [[NSNotificationCenter defaultCenter]postNotificationName:@"notificationShareWX" object:nil userInfo:dic];
}
@end
