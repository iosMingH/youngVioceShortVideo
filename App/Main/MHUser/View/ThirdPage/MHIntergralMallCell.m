//
//  MHIntergralMallCell.m
//  App
//
//  Created by dayewang on 2020/7/6.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import "MHIntergralMallCell.h"
#import "MHIntegralModel.h"

@interface MHIntergralMallCell()
@property(nonatomic,strong)UIImageView *coverI;

@property(nonatomic,strong)UILabel *titleL;
@property(nonatomic,strong)UILabel *contentL;
@property(nonatomic,strong)UILabel *remarkL;
@end

@implementation MHIntergralMallCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        self.contentView.backgroundColor = [UIColor blackColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
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
        _titleL.textColor = SK_COLOR_BASE_TEXT_BLACK_DEEP;
        
        _contentL = [UILabel hyb_labelWithFont:AUTO(12) superView:self.contentView constraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.coverI.mas_right).offset(10);
            make.bottom.mas_equalTo(-15);
            make.width.mas_equalTo(AUTO(100));
        }];
        _contentL.textColor = SK_COLOR_BASE_TEXT_GRAY_DEEP;
        
        _remarkL = [UILabel hyb_labelWithFont:AUTO(18) superView:self.contentView constraints:^(MASConstraintMaker *make) {
                   make.right.mas_equalTo(-15);
                   make.bottom.mas_equalTo(-10);
                   make.width.mas_equalTo(AUTO(100));
               }];
        _remarkL.textColor = [UIColor orangeColor];
        _remarkL.textAlignment = NSTextAlignmentRight;
        
        
    }
    return self;
}
-(void)setModel:(id)model indexPath:(NSIndexPath *)indexPath{
    MHIntegralModel *messagem = (MHIntegralModel *)model;
    _titleL.text = messagem.title;
    _contentL.text = messagem.content;
    _remarkL.text = messagem.remark;
}
@end

//轮播图
#import "SDCycleScrollView.h"

@interface MHIntergralMallHeadView ()<SDCycleScrollViewDelegate>
@end

@implementation MHIntergralMallHeadView

-(void)initControl{
           // 情景二：采用网络图片实现
               NSArray *imagesURLStrings = @[
                                      @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                                      @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                                      @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
                                      ];

                CGFloat w = self.bounds.size.width;

//            UIScrollView *containerView = [UIScrollView hyb_viewWithSuperView:self constraints:^(MASConstraintMaker *make) {
//                    make.left.mas_equalTo(0);
//                    make.right.mas_equalTo(0);
//                    make.top.mas_equalTo(15);
//                    make.height.mas_equalTo(200);
//            }];
            UIScrollView *containerView = [[UIScrollView alloc]initWithFrame:CGRectMake(15, 0, DEVICEWIDTH-30, AUTO(180))];
            [self addSubview:containerView];
            containerView.contentSize = CGSizeMake(self.frame.size.width, AUTO(180));
            [self addSubview:containerView];
//            containerView.backgroundColor = [UIColor yellowColor];

    //        // 网络加载 --- 创建带标题的图片轮播器
            SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 10, w, AUTO(170)) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];

//            cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    //        cycleScrollView2.titlesGroup = titles;
            cycleScrollView2.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
            [containerView addSubview:cycleScrollView2];

            //         --- 模拟加载延迟
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                cycleScrollView2.imageURLStringsGroup = imagesURLStrings;
            });
            
}

#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", (long)index);
    
}

-(void)setModel:(id)model section:(NSInteger )section{
    
}

@end
