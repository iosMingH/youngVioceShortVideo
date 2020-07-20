//
//  MHEditInfoCell.m
//  App
//
//  Created by dayewang on 2020/7/1.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import "MHEditInfoCell.h"

@implementation MHEditInfoCell

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
    self.contentView.backgroundColor =SK_COLOR_BASE_SEBACKGROUND;
    self.titleL = [[UILabel alloc]init];
    [self.contentView addSubview:self.titleL];
    self.titleL.textColor = SK_COLOR_BASE_TITLEMAIN;
    self.titleL.font = FONT(AUTO(14));
    
    self.contentT = [[UITextField alloc]init];
    [self.contentView addSubview:self.contentT];
    self.contentT.textColor = SK_COLOR_BASE_TITLEMAIN;
    self.contentT.font = FONT(AUTO(14));
    self.contentT.textAlignment = NSTextAlignmentRight;
    
}

-(void)initLayout{
    __weak typeof(self)wkThis = self;
    
    //
    [self.titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SK_MARGIN);
        make.top.and.bottom.mas_equalTo(0);
        make.width.mas_equalTo(AUTO(60));
    }];
    
    UIImageView *iconV = [UIImageView hyb_imageViewWithImage:@"p_arrow" superView:self.contentView constraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(6, 11));
        make.centerY.equalTo(wkThis.contentView);
        make.right.mas_equalTo(-AUTO(20));
    }];
    
    [self.contentT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wkThis.titleL.mas_right);
        make.top.and.bottom.mas_equalTo(0);
        make.right.equalTo(iconV.mas_left).offset(-AUTO(10));
    }];

}

- (void)setModel:(MHEditInfoModel *)model 
{
    _model = model;
    self.titleL.text = model.title;
    self.contentT.text = model.content;
}

@end
