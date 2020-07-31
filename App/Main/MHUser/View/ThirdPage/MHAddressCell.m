//
//  MHAddressCell.m
//  App
//
//  Created by dayewang on 2020/7/2.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import "MHAddressCell.h"

#import "MHAddressModel.h"

@interface MHAddressCell()
@property(nonatomic,strong)UILabel *titleL;  //姓名
@property(nonatomic,strong)UILabel *remarkL; //电话
@property(nonatomic,strong)UILabel *contentL; //地址

@property(nonatomic,strong)UIButton *followB;
@end

@implementation MHAddressCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        __weak typeof(self) weakSelf = self;
        self.contentView.backgroundColor = SK_COLOR_BASE_SEBACKGROUND;
        
        UIView *bgView = [UIView hyb_viewWithSuperView:self.contentView constraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SK_MARGINLR);
            make.right.mas_equalTo(-SK_MARGINLR);
            make.top.mas_equalTo(AUTO(7));
            make.bottom.mas_equalTo(-AUTO(7));
        }];
        bgView.backgroundColor = HEXCOLOR(0x2e2b2c);
        
        
        
        _followB = [UIButton hyb_buttonWithSuperView:bgView constraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(AUTO(50), AUTO(34)));
            make.right.mas_equalTo(-AUTO(10));
            make.centerY.equalTo(self.contentView.mas_centerY);
        } touchUp:^(UIButton *sender) {
            NoticeModel* model = [[NoticeModel alloc]init:sender.tag msg:nil data:nil];
            NSString* targer = @"MHAddressViewController";
            [[NSNotificationCenter defaultCenter] postNotificationName:targer object:nil userInfo:[model mj_keyValues]];
        }];
        _followB.tag = 100;
//        _followB.backgroundColor = [UIColor colorWithRed:195.0/255 green:195.0/255 blue:195.0/255 alpha:0.5];
        [_followB setTitleColor:SK_COLOR_BASE_TITLEMAIN forState:UIControlStateNormal];
//        [_followB setTitle:@"编辑" forState:UIControlStateNormal];
        [_followB setImage:IMG(@"p_edit") forState:UIControlStateNormal];
        _followB.contentMode = UIViewContentModeScaleAspectFit;
        _followB.layer.cornerRadius = AUTO(5);
        
        _titleL = [UILabel hyb_labelWithFont:AUTO(15) superView:bgView constraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SK_MARGINLR);
            make.width.mas_equalTo(AUTO(80));
            make.top.mas_equalTo(AUTO(10));
            make.height.mas_equalTo(AUTO(25));
        }];
        _titleL.textColor = SK_COLOR_BASE_TITLEMAIN;
        //电话
        _remarkL = [UILabel hyb_labelWithFont:AUTO(15) superView:bgView constraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.titleL.mas_right).offset(AUTO(5));
            make.right.equalTo(weakSelf.followB.mas_left).offset(-AUTO(10));
            make.top.mas_equalTo(AUTO(10));
            make.height.mas_equalTo(AUTO(25));
        }];
        _remarkL.textColor = SK_COLOR_BASE_TITLELESS;
        
        _contentL = [UILabel hyb_labelWithFont:AUTO(15) superView:bgView constraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SK_MARGINLR);
            make.right.equalTo(weakSelf.followB.mas_left).offset(-AUTO(10));
            make.top.equalTo(weakSelf.titleL.mas_bottom).offset(AUTO(5));
            make.height.mas_equalTo(AUTO(25));
        }];
        _contentL.textColor = SK_COLOR_BASE_TITLELESS;
        
        
    }
    return self;
}
-(void)setModel:(id)model indexPath:(NSIndexPath *)indexPath{
    MHAddressModel *addressM = (MHAddressModel *)model;
    _titleL.text = addressM.title;
    _remarkL.text = addressM.remark;
    _contentL.text = addressM.content;
}

@end
