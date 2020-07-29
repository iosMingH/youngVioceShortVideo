//
//  MHPublishVideoCell.m
//  App
//
//  Created by dayewang on 2020/7/27.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import "MHPublishVideoCell.h"
#import "MHPublishAddTopicModel.h"


//**************话题
@interface MHPublishVideoCell ()



@end

@implementation MHPublishVideoCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = SK_COLOR_BASE_TRANSPARENT;
        _lblName = [UILabel hyb_labelWithFont:NSIZE superView:self.contentView constraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];

        _lblName.textColor = SK_COLOR_BASE_TITLEMAIN;
        _lblName.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}
-(void)setModel:(id)model indexPath:(NSIndexPath *)indexPath{
    MHPublishAddTopicModel *bModel = (MHPublishAddTopicModel *)model;
    _lblName.text = bModel.title;
    
}
@end






//*************** 视频描述  图片
@interface MHPublishHeadView ()
@property(nonatomic,strong)UITextView *textT;

@end

@implementation MHPublishHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self){
        
        self.backgroundColor = [UIColor blackColor];
        
        UIImageView *coverI = [UIImageView hyb_viewWithSuperView:self constraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-AUTO(10));
            make.size.mas_equalTo(CGSizeMake(AUTO(98), AUTO(128)));
            make.centerY.equalTo(self);
        }];
        coverI.backgroundColor = [UIColor grayColor];
        coverI.layer.cornerRadius = 5;

        self.textT = [UITextView hyb_viewWithSuperView:self constraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SK_MARGINLR);
            make.right.equalTo(coverI.mas_left).offset(-10);
            make.top.mas_equalTo(SK_MARGINLR);
            make.bottom.mas_equalTo(-SK_MARGINLR);
        }];
//        self.textT.placeholder = @"输入视频描述...";
        self.textT.backgroundColor = [UIColor blackColor];
        self.textT.textColor = SK_COLOR_BASE_TITLEMAIN;
        NSAttributedString* attributedString = [[NSAttributedString alloc] initWithString:@"输入视频描述..." attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:AUTO(14)],NSForegroundColorAttributeName:[UIColor grayColor]}];
         self.textT.attributedPlaceholder = attributedString;
        
        
        
    }
    return self;
}

-(void)setModel:(id)model indexPath:(NSIndexPath *)indexPath{
    
}

@end







//*****************标题
@interface MHPublishTitleHeadView ()
@property(nonatomic,strong)UILabel *titleL;
@property (nonatomic, assign) NSInteger index;

@end

@implementation MHPublishTitleHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self){
        
       UIView *bgView = [UIView hyb_viewWithSuperView:self constraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        } onTaped:^(UITapGestureRecognizer *sender) {
            
            NSInteger tag = self.index;
            NoticeModel* model = [[NoticeModel alloc]init:tag msg:nil data:nil];
            NSString* targer = @"MHPublishVideoViewControl";
            [[NSNotificationCenter defaultCenter] postNotificationName:targer object:nil userInfo:[model mj_keyValues]];
            
        }];
        bgView.backgroundColor = SK_COLOR_BASE_SEBACKGROUND;
        
        self.titleL = [UILabel hyb_labelWithFont:NSIZE superView:self constraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SK_MARGINLR);
            make.centerY.equalTo(self);
            make.width.equalTo(self).multipliedBy(0.5);
        }];
        self.titleL.textColor = SK_COLOR_BASE_TITLEMAIN;

        [UIImageView hyb_imageViewWithImage:@"p_arrow" superView:self constraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-SK_MARGINLR);
            make.size.mas_equalTo(CGSizeMake(6, 11));
            make.centerY.equalTo(self);
        }];
    }
    return self;
}


-(void)setModel:(id)model indexPath:(NSIndexPath *)indexPath{
    
    self.index = 100 + indexPath.section;
    if (indexPath.section == 1) {
        self.titleL.text = @"添加话题";
    }else{
         self.titleL.text = @"选择关联课程";
    }
}

@end
