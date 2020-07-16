//
//  MHSettingCell.m
//  App
//
//  Created by dayewang on 2020/7/2.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import "MHSettingCell.h"

@implementation MHSettingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initControl];
        [self initLayout];
    }
    return self;
}


-(void)initControl{
    self.contentView.backgroundColor =HEXCOLOR(0x282525);
    
    UIImageView *iconV = [[UIImageView alloc]init];
    [self.contentView addSubview:iconV];
    iconV.contentMode = UIViewContentModeScaleAspectFit;
     self.iconV = iconV;
    
    self.titleL = [[UILabel alloc]init];
    [self.contentView addSubview:self.titleL];
    self.titleL.textColor = SK_COLOR_BASE_TITLEMAIN;
    self.titleL.font = FONT(AUTO(14));
    
//    self.contentL = [[UILabel alloc]init];
//    [self.contentView addSubview:self.contentL];
//    self.contentL.textColor = SK_COLOR_BASE_TITLEMAIN;
//    self.contentL.font = FONT(AUTO(14));
//    self.contentL.textAlignment = NSTextAlignmentRight;
    
}

-(void)initLayout{
    __weak typeof(self)wkThis = self;
    
    [self.iconV  mas_makeConstraints:^(MASConstraintMaker *make) {
         make.size.mas_equalTo(CGSizeMake(16, 16));
         make.centerY.equalTo(wkThis.contentView);
         make.left.mas_equalTo(AUTO(SK_MARGINLR));
     }];
    
    //
    [self.titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wkThis.iconV.mas_right).offset(AUTO(10));
        make.top.and.bottom.mas_equalTo(0);
        make.width.mas_equalTo(AUTO(60));
    }];
    


}

-(void)setModel:(id)model indexPath:(NSIndexPath *)indexPath
{
    MHSettingModel *cellModel = (MHSettingModel *)model;
//    _model = model;
    self.titleL.text = cellModel.title;
    self.iconV.image = IMG(cellModel.icon);
}

@end
