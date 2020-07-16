//
//  MHMyOrderDetailCell.m
//  App
//
//  Created by dayewang on 2020/7/14.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import "MHMyOrderDetailCell.h"
#import "MHMyOrderDetailModel.h"

@interface MHMyOrderDetailCell()
@property(nonatomic,strong)UILabel *titleL;
@property(nonatomic,strong)UILabel *contentL;
@property(nonatomic,strong)UIView *vwLine;

@end

@implementation MHMyOrderDetailCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _vwLine = [UIView hyb_addBottomLineToView:self.contentView height:0.5 color:kLineColor];
        __weak typeof(self) weakSelf = self;
       
        _titleL = [UILabel hyb_labelWithFont:AUTO(15) superView:self.contentView constraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SK_MARGINLR);
            make.width.equalTo(weakSelf.contentView).multipliedBy(0.5);
            make.bottom.and.top.mas_equalTo(0);
        }];
        _titleL.textColor = SK_COLOR_BASE_TEXT_GRAY;
        
        _contentL = [UILabel hyb_labelWithFont:AUTO(15) superView:self.contentView constraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-SK_MARGINLR);
            make.width.equalTo(weakSelf.contentView).multipliedBy(0.5);
            make.bottom.and.top.mas_equalTo(0);
        }];
        _contentL.textColor = SK_COLOR_BASE_TEXT_BLACK_DEEP;
        _contentL.textAlignment = NSTextAlignmentRight;
        
    }
    return self;
}
-(void)setModel:(id)model indexPath:(NSIndexPath *)indexPath{
    MHMyOrderDetailModel *messageModel = (MHMyOrderDetailModel *)model;
//    _titleL.text = messageModel.title;
    _contentL.text = messageModel.content;
    
    switch (indexPath.row) {
        case 0:
        {
            _titleL.text = @"下单状态";
        }
            break;
        case 1:
        {
            _titleL.text = @"下单时间";
        }
            break;
        case 2:
        {
            _titleL.text = @"付款时间";
        }
            break;
        case 3:
        {
            _titleL.text = @"商品总价";
        }
            break;
        case 4:
        {
            _titleL.text = @"实付价";
            _contentL.textColor = SK_COLOR_BASE_TEXT_ORANGE;
            _contentL.font = FONT(AUTO(18));
        }
            break;
            
        default:
            break;
    }
    
}
@end




//**************商品信息


@interface MHMyOrderDetailInfoCell()
@property(nonatomic,strong)UILabel *titleL;
@property(nonatomic,strong)UILabel *contentL;
@property(nonatomic,strong)UILabel *remarkL;
@property(nonatomic,strong)UIImageView *iconV;
@property(nonatomic,strong)UIView  *vwLine;

@end

@implementation MHMyOrderDetailInfoCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        __weak typeof(self) weakSelf = self;
        _vwLine = [UIView hyb_addBottomLineToView:self.contentView height:0.5 color:kLineColor];
        _iconV = [UIImageView hyb_imageViewWithSuperView:self.contentView constraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(AUTO(10));
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(AUTO(100), AUTO(70)));
        }];
        _iconV.backgroundColor = [UIColor grayColor];
        _iconV.layer.cornerRadius = AUTO(5);
        
        _titleL = [UILabel hyb_labelWithFont:AUTO(15) superView:self.contentView constraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.iconV.mas_right).offset(AUTO(10));
            make.right.equalTo(weakSelf.contentView).offset(-AUTO(10));
            make.top.mas_equalTo(AUTO(10));
            make.height.mas_equalTo(AUTO(50));
        }];
        _titleL.textColor = SK_COLOR_BASE_TEXT_BLACK_DEEP;
        _titleL.numberOfLines = 2;
        
        _contentL = [UILabel hyb_labelWithFont:AUTO(15) superView:self.contentView constraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.iconV.mas_right).offset(AUTO(10));
            make.width.mas_equalTo(AUTO(100));
            make.bottom.mas_equalTo(-AUTO(20));
            make.height.mas_equalTo(AUTO(25));
        }];
        _contentL.textColor = SK_COLOR_BASE_TEXT_GRAY;
        
        _remarkL = [UILabel hyb_labelWithFont:AUTO(15) superView:self.contentView constraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-AUTO(10));
            make.width.mas_equalTo(AUTO(100));
            make.bottom.mas_equalTo(-AUTO(20));
            make.height.mas_equalTo(AUTO(25));
        }];
        _remarkL.textColor = SK_COLOR_BASE_TEXT_GRAY;
        _remarkL.textAlignment = NSTextAlignmentRight;
        
    }
    return self;
}
-(void)setModel:(id)model indexPath:(NSIndexPath *)indexPath{
    MHMyOrderDetailInfoModel *bModel = (MHMyOrderDetailInfoModel *)model;
    _titleL.text = bModel.title;
    _contentL.text = bModel.content;
    _remarkL.text = bModel.remark;
    
}
@end




//商品信息标题
@interface MHMyOrderDetailTitleHeadView ()
@property(nonatomic,strong)UILabel *titleL;
@property(nonatomic,strong)UIButton *contentBtn;
@end

@implementation MHMyOrderDetailTitleHeadView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        __weak typeof(self) weakSelf = self;
        
        [UIView hyb_addBottomLineToView:self.contentView height:0.5 color:kLineColor];
        
        self.titleL = [UILabel hyb_labelWithFont:AUTO(15) superView:self.contentView constraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SK_MARGINLR);
            make.width.mas_equalTo(weakSelf.contentView).multipliedBy(0.5);
            make.top.and.bottom.mas_equalTo(0);
        }];
//        self.titleL.text = @"猜你喜欢";
        self.titleL.textColor = SK_COLOR_BASE_TEXT_GRAY;
        
        
        
        UIImageView *iconV = [UIImageView hyb_imageViewWithImage:@"p_arrow01" superView:self.contentView constraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-AUTO(SK_MARGINLR));
            make.size.mas_equalTo(CGSizeMake(AUTO(10), AUTO(18)));
            make.centerY.equalTo(self.contentView);
        }];
//         iconV.backgroundColor = [UIColor grayColor];
        

        
        self.contentBtn = [UIButton hyb_buttonWithSuperView:self.contentView constraints:^(MASConstraintMaker *make) {
            make.right.equalTo(iconV.mas_left).offset(-AUTO(10));
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        } touchUp:^(UIButton *sender) {
            NSInteger tag = sender.tag;
            NoticeModel* model = [[NoticeModel alloc]init:tag msg:nil data:nil];
            NSString* targer = @"MHMyOrderDetailViewController";
            [[NSNotificationCenter defaultCenter] postNotificationName:targer object:nil userInfo:[model mj_keyValues]];
        }];
        self.contentBtn.titleLabel.font = FONT(AUTO(15));
//        [self.contentBtn setTitle:@"查看全部课程" forState:UIControlStateNormal];
        [self.contentBtn setTitleColor:SK_COLOR_BASE_TEXT_BLACK_DEEP forState:UIControlStateNormal];
         self.contentBtn.tag = 100;
        
       
    }
    return self;
}

-(void)setModel:(id)model section:(NSInteger )section{
   
    self.titleL.text = @"店铺名称";
    [self.contentBtn setTitle:@"小二郎教育机构" forState:UIControlStateNormal];
   

}

@end


