//
//  MHCourseTableViewCell.m
//  App
//
//  Created by Pro on 2020/6/28.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import "MHCourseTableViewCell.h"
#import "MHCourseModel.h"

//*********** 课程展示CELL
@interface MHCourseTableViewCell()
@property(nonatomic,strong)UIView *vwLine;

@end

@implementation MHCourseTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor blackColor];
         __weak typeof(self) weakSelf = self;
//        _vwLine = [UIView hyb_addTopLineToView:self.contentView height:0.5 color:kLineColor];
        
        _coverI = [UIImageView hyb_viewWithSuperView:self.contentView constraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(10);
            make.width.mas_equalTo(AUTO(120));
            make.bottom.mas_equalTo(-10);
        }];
        _coverI.backgroundColor = [UIColor grayColor];
        
        _titleL = [UILabel hyb_labelWithFont:NSIZE superView:self.contentView constraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.coverI.mas_top).offset(0);
            make.left.equalTo(weakSelf.coverI.mas_right).offset(10);
            make.right.mas_equalTo(-10);
        }];
        _titleL.numberOfLines = 2;
        _titleL.textColor = SK_COLOR_BASE_TITLEMAIN;
        
        _contentL = [UILabel hyb_labelWithFont:AUTO(12) superView:self.contentView constraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.coverI.mas_right).offset(10);
            make.bottom.mas_equalTo(-15);
            make.width.mas_equalTo(AUTO(100));
        }];
        _contentL.textColor = SK_COLOR_BASE_TITLELESS;
        
        _remarkL = [UILabel hyb_labelWithFont:AUTO(18) superView:self.contentView constraints:^(MASConstraintMaker *make) {
                   make.right.mas_equalTo(-15);
                   make.bottom.mas_equalTo(-10);
                   make.width.mas_equalTo(AUTO(100));
               }];
        _remarkL.textAlignment = NSTextAlignmentRight;
        _remarkL.textColor = SK_COLOR_BASE_ORANGE;
        
        
    }
    return self;
}
-(void)setModel:(id)model indexPath:(NSIndexPath *)indexPath{
    MHCourseModel *messagem = (MHCourseModel *)model;
    _titleL.text = messagem.title;
    _contentL.text = messagem.content;
    _remarkL.text = messagem.remark;
    
    
    if (indexPath.row == 0) {
        _vwLine.hidden = YES;
    }else{
        _vwLine.hidden = NO;
    }
}

@end



//*********** 推荐视图

@interface MHCourseTitleView ()
@property(nonatomic,strong)UILabel *titleL;
@end

@implementation MHCourseTitleView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
//        self.contentView.backgroundColor = [UIColor redColor];
        __weak typeof(self) weakSelf = self;
        self.titleL = [UILabel hyb_labelWithFont:AUTO(18) superView:self.contentView constraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.top.mas_equalTo(15);
            make.height.mas_equalTo(40);
        }];
        self.titleL.text = @"本周精选课";
        self.titleL.font = FONT(20);
        self.titleL.textColor = [UIColor orangeColor];
        self.titleL.textAlignment = NSTextAlignmentCenter;
        
       UIImageView *image = [UIImageView hyb_imageViewWithSuperView:self.contentView constraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.equalTo(weakSelf.titleL.mas_bottom).offset(10);
           make.right.mas_equalTo(-15);
           make.bottom.mas_equalTo(-10);
        }];
        image.backgroundColor = [UIColor grayColor];
        
    }
    return self;
}

-(void)setModel:(id)model section:(NSInteger )section{
   
}

@end







//************排序
@interface MHCourseSortView ()
@property(nonatomic,strong)UILabel *titleL;
@end

@implementation MHCourseSortView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
//        self.contentView.backgroundColor = [UIColor redColor];
//        __weak typeof(self) weakSelf = self;
        self.titleL = [UILabel hyb_labelWithFont:AUTO(18) superView:self.contentView constraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.top.mas_equalTo(15);
            make.height.mas_equalTo(40);
        }];
        self.titleL.text = @"排序";
        self.titleL.font = FONT(20);
        self.titleL.textColor = [UIColor orangeColor];
        self.titleL.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

-(void)setModel:(id)model section:(NSInteger )section{
   
}

@end





//*********** 课程介绍推荐图


@interface MHCourseIntroduceHeadView ()
@property(nonatomic,strong)UIImageView *imageView;
@end

@implementation MHCourseIntroduceHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
      UIImageView *imagview = [UIImageView hyb_imageViewWithSuperView:self constraints:^(MASConstraintMaker *make) {
              make.edges.mas_equalTo(UIEdgeInsetsMake(10, 10, 10, 10));
          } onTaped:^(UITapGestureRecognizer *sender) {
                  
          }];
        imagview.backgroundColor = [UIColor grayColor];
    }
    return self;
}

-(void)setModel:(id)model section:(NSInteger )section{
   
}

@end




//*********** 课程介绍标题
@interface MHCourseIntroduceHeadTitleView ()
@property(nonatomic,strong)UILabel *titleL;
@end

@implementation MHCourseIntroduceHeadTitleView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
//        __weak typeof(self) weakSelf = self;
        
        UIView *spaceView = [UIView hyb_viewWithSuperView:self.contentView constraints:^(MASConstraintMaker *make) {
            make.left.and.right.mas_equalTo(0);
            make.height.mas_equalTo(10);
            make.top.mas_equalTo(0);
        }];
        spaceView.backgroundColor = SK_COLOR_BASE_BACKGROUND;
        
        UIView *vLine = [UIView hyb_viewWithSuperView:self.contentView constraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SK_MARGINLR);
            make.width.mas_equalTo(3);
            make.top.mas_equalTo(20);
            make.height.mas_equalTo(15);
        }];
        vLine.backgroundColor = [UIColor orangeColor];
        
        self.titleL = [UILabel hyb_labelWithFont:AUTO(15) superView:self.contentView constraints:^(MASConstraintMaker *make) {
            make.left.equalTo(vLine).offset(10);
            make.right.mas_equalTo(-15);
            make.top.mas_equalTo(10);
            make.bottom.mas_equalTo(0);
        }];
        self.titleL.text = @"猜你喜欢";
        self.titleL.textColor = SK_COLOR_BASE_SEBACKGROUND;
    }
    return self;
}

-(void)setModel:(id)model section:(NSInteger )section{
   
}

@end
