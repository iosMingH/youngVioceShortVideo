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
//工具栏 热门排序  价钱排序   从新到旧   等

#define KY_MTITLE @"key_title"
#define KY_MMARK  @"key_mark"
#define KY_MIMAGE @"key_image"

@interface MHCourseSortView ()
@property(nonatomic,strong)UILabel *titleL;
 @property(nonatomic,strong)NSArray* menusData;
@end

@implementation MHCourseSortView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = SK_COLOR_BASE_SEBACKGROUND;
        [self initData];
        [self initView11];
    }
    return self;
}

- (void)initData{
    self.menusData = @[
    @{KY_MTITLE:@"热门排序",
      KY_MMARK:@"100",
      KY_MIMAGE:@""},
    @{KY_MTITLE:@"价钱排序",
      KY_MMARK:@"200",
      KY_MIMAGE:@""},
    @{KY_MTITLE:@"从新到旧",
    KY_MMARK:@"300",
    KY_MIMAGE:@""},
    @{KY_MTITLE:@"价钱排序",
    KY_MMARK:@"400",
    KY_MIMAGE:@""}
    ];
}

- (void)initView11{
    __weak typeof(self) weakSelf = self;
    
    UIView *toolV = [UIView hyb_viewWithSuperView:self.contentView constraints:^(MASConstraintMaker *make) {
         make.edges.equalTo(weakSelf.contentView);
        }];
        [toolV layoutIfNeeded];
        CGFloat toolW = DEVICEWIDTH/self.menusData.count;
   
    //      NSArray *titleA = @[@"申请开店",@"课程订单",@"邀请好友"];
            for (int i = 0; i < self.menusData.count; i++) {
            NSDictionary* item = [self.menusData objectAtIndex:i];
            UIView *titleV = [UIView hyb_viewWithSuperView:toolV constraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(0);
                    make.height.equalTo(toolV);
                    make.width.mas_equalTo(toolW);
                    make.left.mas_equalTo(i*toolW);
                } onTaped:^(UITapGestureRecognizer *sender) {
                    [self toolAction:sender];
                    
                }];
                titleV.tag = [[item objectForKey:KY_MMARK] integerValue];
                titleV.backgroundColor = SK_COLOR_BASE_SEBACKGROUND;
              
                
                UILabel *titleL = [UILabel hyb_labelWithText:[item objectForKey:KY_MTITLE]  font:AUTO(12) superView:titleV constraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(AUTO(10));
                    make.right.mas_equalTo(-AUTO(10));
                    make.centerY.equalTo(titleV);
                    make.height.mas_equalTo(AUTO(32));
                    
                }];
                 [titleL layoutIfNeeded];
                titleL.textColor = [UIColor whiteColor];
                titleL.layer.backgroundColor = SK_COLOR_BASE_TRANSPARENT.CGColor;
                titleL.layer.cornerRadius = titleL.height/2;
//                titleL.layer.masksToBounds = YES;
                titleL.textAlignment = NSTextAlignmentCenter;
//                titleL.backgroundColor = SK_COLOR_BASE_TRANSPARENT;
                
            }
        
}


-(void)setModel:(id)model section:(NSInteger )section{
   
}

- (void)toolAction:(UITapGestureRecognizer *)sender
{
    NSInteger tag = [sender view].tag;
    NoticeModel* model = [[NoticeModel alloc]init:tag msg:nil data:nil];
    NSString* targer = @"MHMyCourseViewController";
    [[NSNotificationCenter defaultCenter] postNotificationName:targer object:nil userInfo:[model mj_keyValues]];
                
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
