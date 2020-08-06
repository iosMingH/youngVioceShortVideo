//
//  MHAddAddressCell.m
//  App
//
//  Created by dayewang on 2020/7/3.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import "MHAddAddressCell.h"

@implementation MHAddAddressCell

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
    
    [self.contentT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wkThis.titleL.mas_right);
        make.top.and.bottom.mas_equalTo(0);
        make.right.mas_equalTo(-AUTO(30));
    }];
    
     [UIImageView hyb_imageViewWithImage:@"p_arrow" superView:self.contentView constraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(AUTO(6), AUTO(11)));
        make.centerY.equalTo(wkThis.contentView);
        make.right.mas_equalTo(-AUTO(20));
    }];
     

}

- (void)setModel:(MHAddAddressModel *)model
{
    _model = model;
    self.titleL.text = model.title;
//    self.contentT.placeholder = model.content;
    
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:model.content attributes:@{NSForegroundColorAttributeName:SK_COLOR_BASE_TEXT_GRAY,
        NSFontAttributeName:self.contentT.font
    }];
     self.contentT.attributedPlaceholder = attrString;
}

@end
