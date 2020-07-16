//
//  MHEditTipsView.m
//  App
//
//  Created by dayewang on 2020/7/2.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import "MHEditTipsView.h"
#define KY_MTITLE @"key_title"
#define KY_MMARK  @"key_mark"
#define KY_MIMAGE @"key_image"
@interface MHEditTipsView ()
@property(nonatomic,strong)UILabel *titleL;
@property(nonatomic,strong)NSArray* menusData;

@end

@implementation MHEditTipsView

-(void)initData
{
    self.menusData = @[
                       @{KY_MTITLE:@"取消",
                         KY_MMARK:@"100",
                         },
                       @{KY_MTITLE:@"更换",
                         KY_MMARK:@"200",
                         },
                       ];
}

-(void)initControl{
     [self initData];
        self.layer.cornerRadius = AUTO(5);
    UILabel *remarkL = [UILabel hyb_labelWithText:@"更换已绑定的手机" font:AUTO(20) superView:self constraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(AUTO(10));
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(AUTO(25));
    }];
    remarkL.textColor = SK_COLOR_BASE_TEXT_BLACK_DEEP;
    remarkL.textAlignment = NSTextAlignmentCenter;
    
    UILabel *titleL = [UILabel hyb_labelWithFont:AUTO(18) superView:self constraints:^(MASConstraintMaker *make) {
        make.top.equalTo(remarkL.mas_bottom).offset(AUTO(10));
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(AUTO(25));
    }];
    titleL.textAlignment = NSTextAlignmentCenter;
    titleL.textColor = SK_COLOR_BASE_TEXT_GRAY;
    self.titleL = titleL;
    
    UIView *view = [UIView hyb_viewWithSuperView:self constraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.mas_equalTo(0);
        make.height.mas_equalTo(AUTO(50));
    }];
    view.backgroundColor = [UIColor yellowColor];
    [UIView hyb_addTopLineToView:view height:1 color:SK_COLOR_BASE_LINE];
    [view layoutIfNeeded];
    
    CGFloat btnW = view.width/2;
    for (int idx = 0; idx < self.menusData.count; idx++) {
         NSDictionary* item = [self.menusData objectAtIndex:idx];
        UIButton *btn = [UIButton hyb_viewWithSuperView:view constraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(btnW*idx);
            make.width.mas_equalTo(btnW);
            make.top.and.bottom.mas_equalTo(0);
            
        }];
        [btn setTitle:[item objectForKey:KY_MTITLE] forState:UIControlStateNormal];
        [btn setTag:[[item objectForKey:KY_MMARK]integerValue]];
        [btn addTarget:self action:@selector(onTouch:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = FONT(AUTO(18));
        [btn setTitleColor:SK_COLOR_BASE_TEXT_GRAY forState:UIControlStateNormal];

    }
}

-(void)setModel:(id)model{
    
    self.titleL.text = model;
}

#pragma mark - btnAcion
-(void)onTouch:(UIButton*)sender
{
     [[HWPopTool sharedInstance] closeWithBlcok:nil];
    if (sender.tag == 200) {
         NoticeModel* model = [[NoticeModel alloc]init:sender.tag msg:nil data:nil];
           NSString* targer = @"MHEditInfoViewController";
           [[NSNotificationCenter defaultCenter] postNotificationName:targer object:nil userInfo:[model mj_keyValues]];
          
    }
   
}

@end
