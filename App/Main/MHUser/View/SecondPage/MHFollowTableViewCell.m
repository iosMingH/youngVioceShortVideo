//
//  MHFollowTableViewCell.m
//  App
//
//  Created by Pro on 2020/6/30.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import "MHFollowTableViewCell.h"

#import "MHFollowModel.h"

@interface MHFollowTableViewCell()
@property(nonatomic,strong)UIView *vwLine;
@property(nonatomic,strong)UIImageView *iconV;

@property(nonatomic,strong)UILabel *titleL;
@property(nonatomic,strong)UILabel *contentL;
@property(nonatomic,strong)UIButton *followB;


@end

@implementation MHFollowTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
         __weak typeof(self) weakSelf = self;
        _iconV = [UIImageView hyb_imageViewWithSuperView:self.contentView constraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(AUTO(15));
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(AUTO(50), AUTO(50)));
        }];
        _iconV.backgroundColor = [UIColor grayColor];
        _iconV.layer.cornerRadius = AUTO(25);
        
        _followB = [UIButton hyb_buttonWithSuperView:self.contentView constraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(AUTO(80), AUTO(34)));
            make.right.mas_equalTo(-AUTO(15));
            make.centerY.equalTo(self.contentView.mas_centerY);
        } touchUp:^(UIButton *sender) {
            
        }];
        _followB.backgroundColor = [UIColor colorWithRed:195.0/255 green:195.0/255 blue:195.0/255 alpha:0.5];
        [_followB setTitleColor:SK_COLOR_BASE_TITLEMAIN forState:UIControlStateNormal];
        [_followB setTitle:@"已关注" forState:UIControlStateNormal];
        _followB.layer.cornerRadius = AUTO(5);
        _followB.titleLabel.font = FONT(AUTO(13));
        
        _titleL = [UILabel hyb_labelWithFont:AUTO(15) superView:self.contentView constraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.iconV.mas_right).offset(AUTO(10));
            make.right.equalTo(weakSelf.followB.mas_left).offset(-AUTO(10));
            make.top.mas_equalTo(AUTO(15));
            make.height.mas_equalTo(AUTO(25));
        }];
        _titleL.textColor = SK_COLOR_BASE_TITLEMAIN;
        
        _contentL = [UILabel hyb_labelWithFont:AUTO(15) superView:self.contentView constraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.iconV.mas_right).offset(AUTO(10));
            make.right.equalTo(weakSelf.followB.mas_left).offset(-AUTO(10));
            make.top.equalTo(weakSelf.titleL.mas_bottom).offset(AUTO(5));
            make.height.mas_equalTo(AUTO(25));
        }];
        _contentL.textColor = SK_COLOR_BASE_TITLELESS;
       
        
    }
    return self;
}


-(void)setModel:(id)model indexPath:(NSIndexPath *)indexPath{
    MHFollowModel *followM = (MHFollowModel *)model;
    _titleL.text = followM.title;
     _contentL.text = @"简介";
    
    if (indexPath.row == 0) {
        _vwLine.hidden = YES;
    }else{
        _vwLine.hidden = NO;
    }
}

@end
