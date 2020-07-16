//
//  MHCourseMultipleViewController.m
//  App
//
//  Created by dayewang on 2020/7/3.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import "MHCourseMultipleViewController.h"
#import "MHPageTitleView.h"
#import "MHPageContentView.h"
#import "MHCourseSelectTitleViewController.h"

@interface MHCourseMultipleViewController () <PageContentViewDelegate,PageTitleViewDelegate>
@property (nonatomic,strong) NSMutableArray *childVcs;
@property (nonatomic,strong) MHPageTitleView *titleView;
@property (nonatomic,strong) MHPageContentView *pageContentView;

@end

@implementation MHCourseMultipleViewController

// 懒加载初始化数组
- (NSMutableArray *)childVcs
{
    if (!_childVcs) {
        self.childVcs = [NSMutableArray arrayWithCapacity:2];
    }
    return _childVcs;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // 不需要调整UIScrollView的内边距
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
       //设置导航栏背景图片为一个无图的image，导航栏会加载空imgae，就自然透明掉了
       [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
   //    同理透明掉导航栏下划线
       [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    // 关闭滑动切换抽屉
       self.drawVC.slideEnabled = NO;
}

- (void)setupUI {
    // 添加titleView
    NSArray *titlesArr = @[@"视频课程",@"音频课程"];
    
    MHPageTitleView *titleView = [[MHPageTitleView alloc] initWithFrame:CGRectMake(0, 0, AUTO(200), 44) titles:titlesArr index:0];
    titleView.delegate = self;
    self.navigationItem.titleView = titleView;
    self.titleView = titleView;
    // 添加pageContentView
    [self addPageContentView];
    
}

- (void)addPageContentView
{
    CGRect contentViewFrame = CGRectMake(0, 0, DEVICEWIDTH, DEVICEHEIGH);
    
    MHCourseSelectTitleViewController *vc = [[MHCourseSelectTitleViewController alloc]init];
    [self.childVcs addObject:vc];
    
    MHCourseSelectTitleViewController *vc1 = [[MHCourseSelectTitleViewController alloc]init];
    [self.childVcs addObject:vc1];
   

    
    MHPageContentView *pageContentView = [[MHPageContentView alloc] initWithFrame:contentViewFrame childVcs:self.childVcs parentViewController:self index:0];
    pageContentView.pageCount= 2; //设置左右滚动页面的页数
    pageContentView.delegate = self;
    self.pageContentView = pageContentView;
    [self.view addSubview:pageContentView];
}

#pragma mark ----- 代理
- (void)pageContentViewProgress:(CGFloat)progress beforeIndex:(NSInteger)beforIndex targetIndex:(NSInteger)targetIndex
{
    [self.titleView setTitleChangeProgress:progress beforeIndex:beforIndex targetIndex:targetIndex];
}

- (void)pageTitleViewCurrentIndex:(NSInteger)currentIndex
{
    [self.pageContentView setPageContentViewChangeCurrentIndex:currentIndex];
}

@end
