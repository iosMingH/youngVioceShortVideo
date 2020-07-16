//
//  MHMyOrderViewController.m
//  App
//
//  Created by dayewang on 2020/7/8.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import "MHMyOrderViewController.h"
#import "EScrollPageView.h"
#import "MHMyOrderView.h"
#define HEIGHT_CHOOSETITLE  50
@interface MHMyOrderViewController ()
@property(nonatomic,strong)SearchView *searchV;
@property(nonatomic,retain)EScrollPageView *pageView;
@end

@implementation MHMyOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"我的订单";
    
    self.view.backgroundColor = [UIColor grayColor];
    
    _searchV = [SearchView creatWithPlaceholder:@"输入课程关键字搜索" superView:self.view block:^(NSString *result) {
              NSLog(@"result=%@",result);
          }];
    [self pageView];
}

- (EScrollPageView *)pageView{
    if (_pageView == nil) {
        CGFloat statusBarH = 50;
        //每一项的view子类需要继承EScrollPageItemBaseView实现相关界面
        
        NSArray *titles = @[@"全部",@"待付款",@"待发货",@"待收货",@"待评价"];
        NSMutableArray *vs = [[NSMutableArray alloc]init];
        for (int idx = 0; idx < titles.count; idx ++) {
          EScrollPageItemBaseView *view = [[MHMyOrderView alloc] initWithPageTitle:titles[idx]];
            [vs  addObject:view];
        }
        
        EScrollPageParam *param = [[EScrollPageParam alloc] init];
        //头部高度
        param.headerHeight = HEIGHT_CHOOSETITLE;
        //默认第3个
        param.segmentParam.startIndex = 0;
        //排列类型
        param.segmentParam.type = EPageContentLeft;
        //每个宽度，在type == EPageContentLeft，生效
        param.segmentParam.itemWidth = AUTO(68);
        //底部线颜色
        param.segmentParam.lineColor = SK_COLOR_BASE_TITLEREMARK;
        //背景颜色
        param.segmentParam.bgColor = 0x000000;
        //正常字体颜色
        param.segmentParam.textColor = 0xA9A9A9;
        //选中的颜色
        param.segmentParam.textSelectedColor = 0xffffff;
        param.segmentParam.botLineColor = 0xC0C0C0;
        _pageView = [[EScrollPageView alloc] initWithFrame:CGRectMake(0, statusBarH, self.view.frame.size.width, [UIScreen mainScreen].bounds.size.height-statusBarH-HEIGHT_CHOOSETITLE) dataViews:vs setParam:param];
        [self.view addSubview:_pageView];
    }
    return _pageView;
}

@end
