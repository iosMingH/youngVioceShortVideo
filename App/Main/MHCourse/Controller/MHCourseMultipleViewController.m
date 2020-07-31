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
#import "AlivcQuVideoModel.h"
#import "MBProgressHUD+AlivcHelper.h"


#import "NSString+AlivcHelper.h"
#import "AlivcShortVideoElasticView.h"
#import "AlivcShortVideoRoute.h"
#import "AlivcShortVideoTabBar.h"
#import "AlivcDefine.h"
#import "MHShortVideoPublishManager.h"
#import "AlivcMacro.h"
#import "AlivcImage.h"

@interface MHCourseMultipleViewController () <PageContentViewDelegate,PageTitleViewDelegate,AlivcShortVideoElasticViewDelegate>
@property (nonatomic,strong) NSMutableArray *childVcs;
@property (nonatomic,strong) MHPageTitleView *titleView;
@property (nonatomic,strong) MHPageContentView *pageContentView;

/**
 渐变图层
 */
@property (strong, nonatomic) CAGradientLayer *gradientLayer;

/**
 弹层视图
 */
@property (nonatomic, strong) AlivcShortVideoElasticView *elasticView;


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
    [self addNotification];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
     self.navigationController.navigationBar.translucent = YES;
       //设置导航栏背景图片为一个无图的image，导航栏会加载空imgae，就自然透明掉了
       [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
   //    同理透明掉导航栏下划线
       [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    self.navigationController.navigationBar.hidden = NO;
    // 关闭滑动切换抽屉
       self.drawVC.slideEnabled = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = NO;
    
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

#pragma mark - Getter
- (AlivcShortVideoElasticView *)elasticView{
    if (!_elasticView) {
        _elasticView = [[AlivcShortVideoElasticView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        _elasticView.delegate = self;
    }
    return _elasticView;
}

-(void)addNotification{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(enterMask) name:AlivcNotificationQuPlay_EnterMask object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(quitMask) name:AlivcNotificationQuPlay_QutiMask object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(publishSuccess) name:AlivcNotificationVideoPublishSuccess object:nil];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark - Custom Delegate
#pragma mark - AlivcShortVideoElasticViewDelegate
/**
 视频拍摄按钮点击回调
 
 @param elasticView 对应的UI容器视图
 @param button 拍摄按钮
 */
- (void)shortVideoElasticView:(AlivcShortVideoElasticView *)elasticView shootButtonTouched:(UIButton *)button{
    if (![self judgeIsPublishing]) {
        AliyunMediaConfig *defauleMedia = [AliyunMediaConfig defaultConfig];
        defauleMedia.minDuration = 2;
        defauleMedia.maxDuration = 59;
        defauleMedia.gop = 30;
        [[AlivcShortVideoRoute shared]registerMediaConfig:defauleMedia];
        UIViewController *record = [[AlivcShortVideoRoute shared] alivcViewControllerWithType:AlivcViewControlRecord];
        [self.navigationController pushViewController:record animated:YES];
    }
}

/**
 视频编辑按钮点击回调
 
 @param elasticView 对应的UI容器视图
 @param button 视频编辑按钮
 */
- (void)shortVideoElasticView:(AlivcShortVideoElasticView *)elasticView editButtonTouched:(UIButton *)button{
    if (![self judgeIsPublishing]) {
        AliyunMediaConfig *defauleMedia = [AliyunMediaConfig defaultConfig];
        [[AlivcShortVideoRoute shared]registerHasRecordMusic:NO];
        [[AlivcShortVideoRoute shared]registerMediaConfig:defauleMedia];
        UIViewController *editVideoSelectVC = [[AlivcShortVideoRoute shared]alivcViewControllerWithType:AlivcViewControlEditVideoSelect];
        [editVideoSelectVC setValue:@1 forKey:@"isOriginal"];
        [self.navigationController pushViewController:editVideoSelectVC animated:YES];
    }
}

/**
 判断当前视频发布的状态
 
 @return 是否在发布中
 */
- (BOOL)judgeIsPublishing{
    if ([MHShortVideoPublishManager shared].currentStatus == AlivcPublishStatusPublishing) {
        [MBProgressHUD showMessage:NSLocalizedString(@"视频还在处理中" , nil) inView:self.view];
        return YES;
    }else{
        return NO;
    }
}


/**
 隐藏上传视图，如果有的话
 */
- (void)hideUploadProgressView{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"AlivcNotificationHideUploadProgress" object:nil];
}

#pragma mark - Notification Response
- (void)enterMask{
    //UI 变化
    [self.elasticView enterEditStatus:YES inView:self.view];
}

- (void)quitMask{
    //UI 变化
    [self.elasticView enterEditStatus:NO inView:self.view];
}

- (void)publishSuccess{
    [MBProgressHUD showMessage:NSLocalizedString(@"发布成功，已进入审核通道" , nil) inView:self.view];
}

@end
