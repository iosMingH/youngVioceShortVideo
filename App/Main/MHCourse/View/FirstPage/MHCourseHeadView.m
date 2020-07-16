//
//  MHCourseHeadView.m
//  App
//
//  Created by Pro on 2020/6/28.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import "MHCourseHeadView.h"
#import "SDCycleScrollView.h"

@interface MHCourseHeadView ()<SDCycleScrollViewDelegate>
@end

@implementation MHCourseHeadView

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
            UIScrollView *containerView = [[UIScrollView alloc]initWithFrame:CGRectMake(AUTO(15), AUTO(10), DEVICEWIDTH-AUTO(30), AUTO(200))];
            [self addSubview:containerView];
            containerView.contentSize = CGSizeMake(self.frame.size.width, AUTO(200));
            [self addSubview:containerView];
            containerView.backgroundColor = [UIColor yellowColor];

    //        // 网络加载 --- 创建带标题的图片轮播器
            SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, w, AUTO(200)) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];

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
