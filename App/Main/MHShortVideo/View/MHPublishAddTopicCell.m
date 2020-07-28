//
//  MHPublishAddTopicCell.m
//  App
//
//  Created by dayewang on 2020/7/28.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import "MHPublishAddTopicCell.h"
#import "MHPublishAddTopicModel.h"
@interface MHPublishAddTopicCell()
@property(nonatomic,strong)UILabel *titleL;
@property(nonatomic,strong)UIImageView *iconV;

@end

@implementation MHPublishAddTopicCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        __weak typeof(self) weakSelf = self;
        _iconV = [UIImageView hyb_imageViewWithSuperView:self.contentView constraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-AUTO(15));
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(AUTO(5), AUTO(9)));
        }];
        _iconV.image = IMG(@"p_arrow");
        
        _titleL = [UILabel hyb_labelWithFont:AUTO(15) superView:self.contentView constraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SK_MARGINLR);
            make.right.equalTo(weakSelf.iconV.mas_left).offset(-AUTO(10));
            make.centerY.equalTo(self);
            make.height.mas_equalTo(AUTO(25));
        }];
        _titleL.textColor = SK_COLOR_BASE_TEXT_GRAY_DEEP;
        
    }
    return self;
}
-(void)setModel:(id)model indexPath:(NSIndexPath *)indexPath{
    MHPublishAddTopicModel *bModel = (MHPublishAddTopicModel *)model;
    _titleL.text = LSString(@"#%@",bModel.title);
}

@end
