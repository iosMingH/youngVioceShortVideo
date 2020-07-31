//
//  MHHomeVideoViewController.m
//  App
//
//  Created by Pro on 2020/6/1.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import "MHHomeVideoViewController.h"
#import "MHPageTitleView.h"
#import "MHPageContentView.h"
#import "MHShortVideoLivePlayViewController.h"
#import "MHFollowVideoViewController.h"
#import "MHSameCityViewController.h"


@interface MHHomeVideoViewController () <PageContentViewDelegate,PageTitleViewDelegate>
@property (nonatomic,strong) NSMutableArray *childVcs;
@property (nonatomic,strong) MHPageTitleView *titleView;
@property (nonatomic,strong) MHPageContentView *pageContentView;

@end

@implementation MHHomeVideoViewController

// 懒加载初始化数组
- (NSMutableArray *)childVcs
{
    if (!_childVcs) {
        self.childVcs = [NSMutableArray arrayWithCapacity:3];
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
    //显示系统的导航栏  ----------- MH
    self.navigationController.navigationBarHidden = NO;
     self.navigationController.navigationBar.translucent = YES;
       //设置导航栏背景图片为一个无图的image，导航栏会加载空imgae，就自然透明掉了
       [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
   //    同理透明掉导航栏下划线
       [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    // 关闭滑动切换抽屉
    self.drawVC.slideEnabled = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = NO;
    
}

- (void)setupUI {
    // 添加titleView
    NSArray *titlesArr = @[@"同城",@"关注",@"推荐"];
    
    MHPageTitleView *titleView = [[MHPageTitleView alloc] initWithFrame:CGRectMake(0, 0, AUTO(250), 44) titles:titlesArr index:2];
    titleView.delegate = self;
    self.navigationItem.titleView = titleView;
    self.titleView = titleView;
    // 添加pageContentView
    [self addPageContentView];
    
}

- (void)addPageContentView
{
    CGRect contentViewFrame = CGRectMake(0, 0, DEVICEWIDTH, DEVICEHEIGH);
    
    MHSameCityViewController *vc = [[MHSameCityViewController alloc]init];
//     MHShortVideoLivePlayViewController *vc = [[MHShortVideoLivePlayViewController alloc]init];
    [self.childVcs addObject:vc];
    
    MHFollowVideoViewController *vc1 = [[MHFollowVideoViewController alloc]init];
//     MHShortVideoLivePlayViewController *vc1 = [[MHShortVideoLivePlayViewController alloc]init];
    [self.childVcs addObject:vc1];
   
    MHShortVideoLivePlayViewController *vc2 = [[MHShortVideoLivePlayViewController alloc]init];
    [self.childVcs addObject:vc2];
    
 
    
    MHPageContentView *pageContentView = [[MHPageContentView alloc] initWithFrame:contentViewFrame childVcs:self.childVcs parentViewController:self index:2];
    pageContentView.pageCount= 3; //设置左右滚动页面的页数
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


#pragma mark - notice
- (void)eventNotice:(NSNotification *)info
{
    NoticeModel *model = [NoticeModel mj_objectWithKeyValues:[info userInfo]];
    switch (model.code) {
 //     微信好友分享
        case 100:
        {
            TOAST(@" 微信好友分享");
        }
            break;
//         朋友圈分享
        case 200:
        {
            TOAST(@" 朋友圈");
        }
            break;
        default:
            break;
    }
    
}


@end
