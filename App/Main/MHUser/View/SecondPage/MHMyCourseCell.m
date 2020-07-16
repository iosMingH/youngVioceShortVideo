//
//  MHMyCourseCell.m
//  App
//
//  Created by dayewang on 2020/7/6.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import "MHMyCourseCell.h"
#import "MHMyCourseModel.h"

@interface MHMyCourseCell()
@property(nonatomic,strong)UIImageView *coverI;

@property(nonatomic,strong)UILabel *titleL;
@property(nonatomic,strong)UILabel *contentL;
@property(nonatomic,strong)UILabel *remarkL;
@end

@implementation MHMyCourseCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        self.contentView.backgroundColor = [UIColor blackColor];
//        self.contentView.backgroundColor = SK_COLOR_BASE_SEBACKGROUND;
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
        _remarkL.textColor = SK_COLOR_BASE_TITLEREMARK;
        _remarkL.font = kBoldFont(AUTO(18));
        _remarkL.textAlignment = NSTextAlignmentRight;
        
        
    }
    return self;
}
-(void)setModel:(id)model indexPath:(NSIndexPath *)indexPath{
    MHMyCourseModel *messagem = (MHMyCourseModel *)model;
    _titleL.text = messagem.title;
    _contentL.text = messagem.content;
    _remarkL.text = messagem.remark;
}
@end


//我的课程 工具栏 热门排序  价钱排序   从新到旧   等

#define KY_MTITLE @"key_title"
#define KY_MMARK  @"key_mark"
#define KY_MIMAGE @"key_image"

@interface MHMyCourseTitleView ()
@property(nonatomic,strong)UILabel *titleL;
 @property(nonatomic,strong)NSArray* menusData;
@end

@implementation MHMyCourseTitleView

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
    
//         self.titleL = [UILabel hyb_labelWithFont:AUTO(18) superView:self.contentView constraints:^(MASConstraintMaker *make) {
//             make.left.mas_equalTo(15);
//             make.right.mas_equalTo(-15);
//             make.top.mas_equalTo(15);
//             make.height.mas_equalTo(40);
//         }];
//         self.titleL.text = @"排序";
//         self.titleL.font = FONT(20);
//         self.titleL.textColor = [UIColor orangeColor];
//         self.titleL.textAlignment = NSTextAlignmentCenter;
    
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
                titleL.layer.cornerRadius = titleL.height/2;
                titleL.textAlignment = NSTextAlignmentCenter;
                titleL.backgroundColor = SK_COLOR_BASE_TRANSPARENT;
                
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
