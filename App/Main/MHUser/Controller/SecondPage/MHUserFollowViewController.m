//
//  MHUserFollowViewController.m
//  App
//
//  Created by Pro on 2020/6/30.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import "MHUserFollowViewController.h"
#import "MHPageTitleView.h"
#import "MHPageContentView.h"
#import "MHFollowViewController.h"


@interface MHUserFollowViewController () <PageContentViewDelegate,PageTitleViewDelegate>
@property (nonatomic,strong) NSMutableArray *childVcs;
@property (nonatomic,strong) MHPageTitleView *titleView;
@property (nonatomic,strong) MHPageContentView *pageContentView;

@end

@implementation MHUserFollowViewController

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
    self.title = @"用户昵称";
    // 不需要调整UIScrollView的内边距
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)setupUI {
    // 添加titleView
    NSArray *titlesArr = @[@"关注",@"粉丝"];
    UIView *topB = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEVICEWIDTH, 44)];
    [self.view addSubview:topB];
    topB.backgroundColor = [UIColor blackColor];
    MHPageTitleView *titleView = [[MHPageTitleView alloc] initWithFrame:CGRectMake(0, 0, 250, 44) titles:titlesArr index:self.tabIndex];
    titleView.delegate = self;
    [topB addSubview:titleView];
    [titleView setScrollLineColor:[UIColor yellowColor]];
    titleView.centerX = self.view.centerX;
//     self.navigationItem.titleView = titleView;
    self.titleView = titleView;
    // 添加pageContentView
    [self addPageContentView];
    
}

- (void)addPageContentView
{
    CGRect contentViewFrame = CGRectMake(0, 44, DEVICEWIDTH, DEVICEHEIGH);
    
    MHFollowViewController *vc = [[MHFollowViewController alloc]init];
    [self.childVcs addObject:vc];
    
    MHFollowViewController *vc1 = [[MHFollowViewController alloc]init];
    [self.childVcs addObject:vc1];
   
    MHPageContentView *pageContentView = [[MHPageContentView alloc] initWithFrame:contentViewFrame childVcs:self.childVcs parentViewController:self index:self.tabIndex];
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
