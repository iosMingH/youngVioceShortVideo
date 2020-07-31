//
//  MHIntegralCell.m
//  App
//
//  Created by dayewang on 2020/7/1.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import "MHIntegralCell.h"

#import "MHIntegralModel.h"

@interface MHIntegralCell()
@property(nonatomic,strong)UILabel *titleL;   //标题
@property(nonatomic,strong)UILabel *contentL;  //时间
@property(nonatomic,strong)UILabel *remarkL;    //积分
@end

@implementation MHIntegralCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        __weak typeof(self) weakSelf = self;
        UIView *bgView = [UIView hyb_viewWithSuperView:self.contentView constraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SK_MARGINLR);
            make.right.mas_equalTo(-SK_MARGINLR);
            make.top.mas_equalTo(AUTO(0));
            make.bottom.mas_equalTo(-AUTO(0));
        }];
        bgView.backgroundColor = HEXCOLOR(0x2e2b2c);
        _remarkL = [UILabel hyb_labelWithFont:KSIZE superView:bgView constraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-SK_MARGINLR);
            make.width.mas_equalTo(AUTO(100));
            make.height.equalTo(weakSelf.contentView);
            make.centerY.equalTo(weakSelf.contentView);
        }];
        _remarkL.textColor = [UIColor yellowColor];
        _remarkL.textAlignment = NSTextAlignmentRight;
        
        _titleL = [UILabel hyb_labelWithFont:AUTO(14) superView:bgView constraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SK_MARGINLR);
            make.right.equalTo(weakSelf.remarkL.mas_left).offset(-AUTO(10));
            make.top.mas_equalTo(AUTO(10));
            make.height.mas_equalTo(AUTO(25));
        }];
        _titleL.textColor = SK_COLOR_BASE_TITLEMAIN;
        
        _contentL = [UILabel hyb_labelWithFont:AUTO(12) superView:bgView constraints:^(MASConstraintMaker *make) {
             make.left.mas_equalTo(SK_MARGINLR);
             make.right.equalTo(weakSelf.remarkL.mas_left).offset(-AUTO(10));
            make.top.equalTo(weakSelf.titleL.mas_bottom).offset(AUTO(0));
            make.height.mas_equalTo(AUTO(25));
        }];
        _contentL.textColor = SK_COLOR_BASE_TITLELESS;
        
        
    }
    return self;
}
-(void)setModel:(id)model indexPath:(NSIndexPath *)indexPath{
    MHIntegralModel *Imodel = (MHIntegralModel *)model;
    _titleL.text = Imodel.title;
    _contentL.text = @"2019/04/12";
    _remarkL.text = Imodel.remark;

}
@end



@interface MHTableHeadView ()

@property(nonatomic,strong)UILabel *titleL;
@property(nonatomic,strong)UIButton *button;
@end

@implementation MHTableHeadView

-(void)initControl{
    __weak typeof (self) weakSelf = self;
    _titleL = [UILabel hyb_labelWithFont:AUTO(22) superView:self constraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(0);
        make.top.mas_equalTo(AUTO(15));
        make.height.equalTo(self).multipliedBy(0.4);
    }];
    _titleL.textColor = [UIColor yellowColor];
    _titleL.textAlignment = NSTextAlignmentCenter;
    
    _button = [UIButton hyb_buttonWithSuperView:self constraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(AUTO(90), AUTO(30)));
        make.top.equalTo(weakSelf.titleL.mas_bottom).offset(AUTO(0));
        make.centerX.equalTo(weakSelf);
    } touchUp:^(UIButton *sender) {
        
        NoticeModel* model = [[NoticeModel alloc]init:sender.tag msg:nil data:nil];
           NSString* targer = @"MHIntegralViewController";
           [[NSNotificationCenter defaultCenter] postNotificationName:targer object:nil userInfo:[model mj_keyValues]];
    }];
    _button.tag = 100;
    [_button setTitle:@"兑换商品" forState:UIControlStateNormal];
    [_button setTitleColor:SK_COLOR_BASE_TITLEMAIN forState:UIControlStateNormal];
    _button.titleLabel.font = FONT(AUTO(12));
    _button.backgroundColor = SK_COLOR_BASE_TRANSPARENT;
    _button.layer.cornerRadius = AUTO(15);
    
}

- (void)setModel:(id)model{
    _titleL.text = model;
}
@end
