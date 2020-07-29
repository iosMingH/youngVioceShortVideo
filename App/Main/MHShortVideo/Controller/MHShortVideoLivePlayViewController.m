//
//  MHShortVideoLivePlayViewController.m
//  App
//
//  Created by Pro on 2020/3/26.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import "MHShortVideoLivePlayViewController.h"
#import <AliyunPlayer/AliyunPlayer.h>
#import "AlivcQuVideoModel.h"
#import "MHShortVideoCoverCell.h"
#import "AlivcShortVideoElasticView.h"
#import "AlivcShortVideoTabBar.h"
#import "AlivcShortVideoMaskView.h"
#import "UIColor+AlivcHelper.h"
//#import "AlivcShortVideoMenuView.h"
#import "AlivcShortVideoPlayerManager.h"
#import <Photos/Photos.h>
#import <AliyunMediaDownloader/AliyunMediaDownloader.h>
#import "AlivcShortVideoProgress.h"
#import "MBProgressHUD+AlivcHelper.h"
#import "AliyunReachability.h"
#import "AlivcDefine.h"
#import "MHShortVideoPublishManager.h"
#import "AlivcShortVideoUploadProgressView.h"
#import "AliVideoClientUser.h"
#import "MHShortVideoServerManager.h"
#import "AlivcAlertView.h"
#import "AliyunMediaConfig.h"
#import "AlivcShortVideoRoute.h"
#import "MHShortVideoPlayCollectionViewDataSource.h"
#import <MJRefresh/MJRefresh.h>
#import "NSData+AlivcHelper.h"

#import "AlivcMacro.h"
#import "AlivcImage.h"
#import "NSString+URL.h"
#import "SCLoginController.h"
#import "MHHomeVideoViewController.h"

#if __has_include(<AliyunVideoSDKPro/AliyunVideoSDKInfo.h>)
#import <AliyunVideoSDKPro/AliyunVideoSDKInfo.h>
#endif


#define downloadPath NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject

typedef NS_ENUM(NSUInteger,AlivcPlayerControllerState) {
    AlivcPlayerControllerStateActive =  0,                  //正常状态
    AlivcPlayerControllerStateShowMask = 1 << 0,            //显示maskView
    AlivcPlayerControllerStateEnterbackground = 1 << 1      //进入后台
};

#define VIDEOPAGESIZE 10

@interface MHShortVideoLivePlayViewController ()<AlivcShortVideoElasticViewDelegate,MHShortVideoMenuViewDelegate,AMDDelegate,AlivcShortVideoProgressDelegate,MHShortVideoPublishManagerDelegate,UICollectionViewDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) AlivcShortVideoPlayerManager *playerManager;

/**
 点击tabbar中间按钮的弹出层
 */

@property (nonatomic, strong) AlivcShortVideoElasticView *elasticView;

///**
// 底部弹出菜单view
// */
//@property (nonatomic, strong)AlivcShortVideoMenuView *menuView;

/**
 下载类
 */
@property (nonatomic, strong) AliMediaDownloader *downloader;

/**
 网络监听
 */
@property (nonatomic, strong) AliyunReachability *reachability;

/**
 上传进度视图
 */
@property (nonatomic, strong) AlivcShortVideoUploadProgressView *uploadProgress;

/**
 上传视频信息的参数
 */
@property (nonatomic, strong, nullable) NSDictionary *publishParamDic;

/**
 上传错误视图
 */
@property (nonatomic, strong, nullable) AlivcAlertView *publishErrprView;


/**
 初始化视频列表
 */
@property (nonatomic, strong) NSArray *defaultVideoList;

/**
 开始播放的位置
 */
@property (nonatomic, assign) NSInteger startPlayIndex;

/**
 控制器状态
 */
@property (nonatomic, assign) AlivcPlayerControllerState controllerState;

/**
 返回前台的时候 是否需要继续播放
 */
@property (nonatomic, assign) BOOL shouldResumeWhenActive;

/**
 是否播放自己的视频
 */
@property (nonatomic, assign) BOOL shouldplaySelfVideo;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) MHShortVideoPlayCollectionViewDataSource *collectionViewDataSource;
/**
 分页对象
 */
@property (nonatomic, copy) NSString *lastVid;

/**
 sts相关
 */
@property (nonatomic, copy) NSString *accessKeyId;
@property (nonatomic, copy) NSString *accessKeySecret;
@property (nonatomic, copy) NSString *securityToken;
@property (nonatomic, copy) NSString *region;

@property (nonatomic, assign) BOOL isLoading;
/**
 正在显示的indexPath
 */
@property (nonatomic, strong) NSIndexPath *indexPath;


@property (nonatomic, assign) BOOL isDragging;

@property(nonatomic,strong)UIView *shortVideoView;

@property(nonatomic,strong)UIView *otherView;


//token
@property (nonatomic, copy) NSString *userToken;
@property (nonatomic, copy) NSString *getVideoID;

@property (nonatomic, assign) NSInteger pageNum;

@property (nonatomic, assign) NSInteger selfPageNum;

//推荐作品列表还有更多的吗
@property (nonatomic, assign) BOOL reHasMore;

//个人作品列表还有更多的吗
@property (nonatomic, assign) BOOL selfHasMore;


@end

static NSString *CELLID = @"MHShortVideoCoverCell";

@implementation MHShortVideoLivePlayViewController

#pragma mark - init
-(instancetype)initWithVideoList:(NSArray <AlivcQuVideoModel *>*)videoList
                  startPlayIndex:(NSInteger )startPlayIndex {
    self = [super init];
    if (self) {
        if(videoList.count) {
            //如果视频数组有值 则播放该数组的视频 不去加载推荐的视频
            self.defaultVideoList = videoList;
            self.shouldplaySelfVideo = YES;
            self.startPlayIndex = startPlayIndex;
         //从个人作品页点击进来 判断从第几页开始 +1
            self.selfPageNum = ceil(self.startPlayIndex /VIDEOPAGESIZE)+ 1;
            self.selfHasMore = YES;
        }
    }
    return self;
}

#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
 
    
     self.userToken = [FUCacheManager read:COMMON_USER_TOKEN];
    self.pageNum = 1;
    [self initUI];
    [self initMaskViews];
     [self addPublishVideoNotification];
    [self addNetWorkingNotification];
    [self loadData];
//    self.reHasMore = YES;
    
    //设置log等级
#if __has_include(<AliyunVideoSDKPro/AliyunVideoSDKInfo.h>)
    [AliyunVideoSDKInfo setLogLevel:kAlivcLogLevel];
#endif
}
//MHHomeVideoViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
     if ([self.navigationController.viewControllers.firstObject isKindOfClass: NSClassFromString(@"MHUserViewController")]) {
           self.navigationController.navigationBar.hidden = YES;
     }else{
          self.navigationController.navigationBar.hidden = NO;
     }
        //设置导航栏背景图片为一个无图的image，导航栏会加载空imgae，就自然透明掉了
//        [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
//    //    同理透明掉导航栏下划线
//        [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];

     [self becomeActive];
    [self addNotification];
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//     if (![self.navigationController.viewControllers.firstObject isKindOfClass: NSClassFromString(@"MHHomeVideoViewController")]) {
//           self.navigationController.navigationBar.hidden = YES;
//     }else{
//          self.navigationController.navigationBar.hidden = NO;
//     }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
     [self resignActive];
    [self removeObserver];
    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
    
//     self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)dealloc
{
    [self.playerManager.listPlayer destroy];
    [self removeAllNotification];
    NSLog(@"%s",__func__);
}

#pragma mark - private methods

#pragma mark - UI
- (void)initUI{
    [self initCollectionView];
    self.playerManager = [[AlivcShortVideoPlayerManager alloc] initWithVC:self];
}

- (void)initCollectionView {
    if (@available(iOS 11.0, *)) {
        self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
         self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.view addSubview:self.collectionView];
     self.collectionView.scrollsToTop = NO;
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self.collectionViewDataSource;
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    layout.itemSize = self.view.bounds.size;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.collectionView registerNib:[UINib nibWithNibName:CELLID bundle:nil] forCellWithReuseIdentifier:CELLID];
    
    //播放自己的视频不需要下拉刷新
    if (!self.shouldplaySelfVideo) {
        MJRefreshNormalHeader *refreshHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
        refreshHeader.lastUpdatedTimeLabel.hidden =  YES;
        refreshHeader.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
        self.collectionView.mj_header = refreshHeader;
    }
}


- (void)initMaskViews {

    if (![self.navigationController.viewControllers.firstObject isKindOfClass: NSClassFromString(@"MHHomeVideoViewController")]){
        //返回按钮
        UIButton *backButton = [[UIButton alloc]init];
        [backButton addTarget:self action:@selector(backButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
        [backButton setImage:[AlivcImage imageInSmartVideoNamed:@"avcBackIcon"] forState:UIControlStateNormal];
        [backButton sizeToFit];
        backButton.center = CGPointMake(15 + backButton.frame.size.width / 2, SafeTop + 22);
        [self.view addSubview:backButton];
    }
    
}

- (void)addNotification {
    
    //微信分享
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(actionWX:) name:@"notificationShareWX" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(enterMask) name:AlivcNotificationQuPlay_EnterMask object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(quitMask) name:AlivcNotificationQuPlay_QutiMask object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(becomeActive)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(resignActive)
                                                 name:UIApplicationWillResignActiveNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged)
                                                 name:AliyunSVReachabilityChangedNotification
                                             object:nil];
    
    //添加喜欢视频
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(addLikeAction) name:@"notification_addLikeVideo" object:nil];
      //取消喜欢视频
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(cancelLikeAction) name:@"notification_cancelLikeVideo" object:nil];

}

- (void)addPublishVideoNotification {
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(startPublish) name:AlivcNotificationVideoStartPublish object:nil];
    //进入个人中心的视频播放的的时候，隐藏上传封面
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(hideUploadProgress) name:@"AlivcNotificationHideUploadProgress" object:nil];
    //退出个人中心的视频播放的的时候，显示上传封面
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showUploadProgress) name:@"AlivcNotificationShowUploadProgress" object:nil];
}


- (void)addNetWorkingNotification {
    self.reachability = [AliyunReachability reachabilityForInternetConnection];
    [self.reachability startNotifier];
    [self reachabilityChanged];
}

- (void)removeObserver {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AlivcNotificationQuPlay_EnterMask object:nil];
      [[NSNotificationCenter defaultCenter] removeObserver:self name:AlivcNotificationQuPlay_QutiMask object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
      [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillResignActiveNotification object:nil];
    
    //添加喜欢视频
    [[NSNotificationCenter defaultCenter]removeObserver:self  name:@"notification_addLikeVideo" object:nil];
    //取消喜欢视频
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"notification_cancelLikeVideo" object:nil];

    //微信分享
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"notificationShareWX" object:nil];
}
- (void)removeAllNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/**
 相册没有授权弹出提示框
 */
- (void)showPhotoLibUnAuthAlert{
    __weak typeof(self) weakSelf = self;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:NSLocalizedString(@"请在iPhone的“设置-隐私-照片”选项中，允许访问你的手机相册。" , nil) preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"好的" , nil) style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction *settingAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"去设置" , nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf goSetting];
    }];
    
    [alert addAction:cancelAction];
    [alert addAction:settingAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}


/**
 跳转到设置界面
 */
- (void)goSetting{
    [[UIApplication sharedApplication] openURL:
     [NSURL URLWithString:UIApplicationOpenSettingsURLString]];
}

- (void)downloadVideoWithVideoId:(NSString *)videoId {
    //1.initSource
    AVPVidStsSource *source = [[AVPVidStsSource alloc] initWithVid:videoId
                                                       accessKeyId:self.accessKeyId
                                                   accessKeySecret:self.accessKeySecret
                                                     securityToken:self.securityToken
                                                            region:self.region];
    //2.initDownloader
    AliMediaDownloader *downloader = [[AliMediaDownloader alloc] init];
    self.downloader = downloader;
    [downloader setSaveDirectory:downloadPath];
    [downloader setDelegate:self];
    [downloader prepareWithVid:source];
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

#pragma mark - NETWORK
- (void)loadData {
    self.pageNum = 1;
//    self.reHasMore = YES;
    [self fetchSTS];
}

//刷新数据
- (void)loadNewVideo {
    
    if( self.shouldplaySelfVideo) {
        self.collectionViewDataSource.videoList = self.defaultVideoList.mutableCopy;
        [self fetchedNewVideos:self.defaultVideoList];
        [self moveToIndex:self.startPlayIndex];

    }else {
        self.pageNum = 1;
        self.lastVid = @"";
        [self fetchVideo:self.userToken];
    }
      
}

//获取更多数据
- (void)loadMoreVideo {
    
//        if (!self.userToken) {
//            [MBProgressHUD showMessage:NSLocalizedString(@"请先登录", nil) inView:self.view];
//            return;
//        }
       
        if (self.shouldplaySelfVideo) {
            
            if (self.selfHasMore) {
                self.selfPageNum ++;
                [self fetchSelfVideos:self.userToken];
            }
              
        }else{
            if (self.reHasMore) {
                self.pageNum ++;
                self.lastVid = self.collectionViewDataSource.videoList.lastObject.ID;
                [self fetchVideo:self.userToken];
            }
           
        }
}

// 获取播放的sts校验数据
- (void)fetchSTS
{
    /**
    获取播放的sts校验数据

    @param token 用户token
    @param success 成功
    @param failure 失败
    */
      __weak typeof(self) weakSelf = self;

    
    [MHShortVideoServerManager dayeServerGetSTSWithToken:self.userToken
                                               success:^(NSString * _Nonnull accessKeyId,
                                                         NSString * _Nonnull accessKeySecret,
                                                         NSString * _Nonnull securityToken) {
                                                   weakSelf.accessKeyId = accessKeyId;
                                                   weakSelf.accessKeySecret = accessKeySecret;
                                                   weakSelf.securityToken = securityToken;
                                                   weakSelf.region = @"cn-shanghai";
        
                                                      [weakSelf loadNewVideo];
                                        
                                               } failure:^(NSString * _Nonnull errorString) {
                                                   [MBProgressHUD showMessage:errorString inView:weakSelf.view];
                                                   [weakSelf.collectionView.mj_header endRefreshing];
                                               }];
    
   
}


///获取视频
/// @param token
- (void)fetchVideo:(NSString *)token {
    __weak typeof(self) weakSelf = self;
    self.isLoading = YES;
//    [FUPROGRESS_HUD loading:@"加载中..."];
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    /**
    请求推荐的视频列表

    @param token 用户token
    @param index 起始页
    @param count 页面条数
    @param videoId 本次查询的视频id所在的位置为起点，不包含此视频id，有值的时候index不起作用,此id是ID，数据库递增的标识
    @param success 成功
    @param failure 失败
    */
    
    [MHShortVideoServerManager dayeServerGetRecommendVideoListWithToken:token
                                                               pageIndex:self.pageNum
                                                                pageSize:VIDEOPAGESIZE  lastEndVideoId:self.lastVid
                                                                 success:^(NSArray<AlivcQuVideoModel *> * _Nonnull videoList,
                                                                           NSInteger allVideoCount) {
        NSLog(@"videoList=%@",videoList);
           [weakSelf dealWithData:videoList countNum:allVideoCount lastVideoId:weakSelf.lastVid];
           if (self.pageNum*VIDEOPAGESIZE > allVideoCount) {
               weakSelf.reHasMore = NO;
           }else{
               weakSelf.reHasMore = YES;
           }
         } failure:^(NSString * _Nonnull errorString) {
           weakSelf.isLoading = NO;
           [MBProgressHUD showMessage:errorString inView:weakSelf.view];
           [weakSelf.collectionView.mj_header endRefreshing];
        }];
}

- (void)fetchSelfVideos:(NSString *)token {
    __weak typeof(self) weakSelf = self;
    self.isLoading = YES;
    NSString *lastVid = self.collectionViewDataSource.videoList.lastObject.ID;
    
    /**
    请求个人的视频列表
    
    @param token 用户token
    @param index 起始页
    @param count 页面条数
    @param videoId 本次查询的视频id所在的位置为起点，不包含此视频id，有值的时候index不起作用,此id是ID，数据库递增的标识
    @param success 成功
    @param failure 失败
    */
    [MHShortVideoServerManager dayeServerGetPersonalVideoListWithToken:token
                                                           pageIndex:self.selfPageNum
                                                            pageSize:VIDEOPAGESIZE
                                                      lastEndVideoId:lastVid success:^(NSArray<AlivcQuVideoModel *> * _Nullable videoList, NSInteger allVideoCount) {
                    [weakSelf dealWithData:videoList countNum:allVideoCount lastVideoId:lastVid];
                        if (self.selfPageNum*VIDEOPAGESIZE > allVideoCount) {
                            weakSelf.selfHasMore = NO;
                        }
            } failure:^(NSString * _Nonnull errorString) {
    weakSelf.isLoading = NO;
    [MBProgressHUD showMessage:errorString inView:weakSelf.view];
                                                      }];
}


- (void)dealWithData:(NSArray<AlivcQuVideoModel *> *) videoList countNum:(NSInteger) allVideoCount lastVideoId:(NSString *)lastVid {
    self.isLoading = NO;
    [self.collectionView.mj_header endRefreshing];
    
    //数据库ID转成字符型
    NSString *lastoneId = [NSString stringWithFormat:@"%@",lastVid];
    
    if (lastoneId == nil || lastoneId.length == 0) {
        self.collectionViewDataSource.videoList = videoList.mutableCopy;
       
        [self fetchedNewVideos:videoList];
        self.collectionView.contentInset = UIEdgeInsetsZero;
        [self.collectionView reloadData];
        [self.collectionView layoutSubviews];
        [self scrollViewDidEndDecelerating:self.collectionView];
    }else{
        
//        NSMutableArray *indexPaths = @[].mutableCopy;
//        for (int i = 0; i < videoList.count; i++) {
//            NSInteger index = self.collectionViewDataSource.videoList.count - 1 + i;
//            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0] ;
//            [indexPaths addObject:indexPath];
//        }
//
//        [self.collectionViewDataSource.videoList addObjectsFromArray:videoList];
//        [self fetchedMoreVideos:videoList];
//
//        [self.collectionView performBatchUpdates:^{
//            [self.collectionView insertItemsAtIndexPaths:indexPaths];
//        } completion:^(BOOL finished) {
//        }];
        
          NSMutableArray *indexPaths = @[].mutableCopy;
          NSMutableArray *moreVideoList = [[NSMutableArray alloc]init];
          NSMutableArray *videoIdArr = [[NSMutableArray alloc]init];
        if (self.shouldplaySelfVideo) {
            
            [self.collectionViewDataSource.videoList enumerateObjectsUsingBlock:^(AlivcShortVideoBasicVideoModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

                AlivcQuVideoModel *model = (AlivcQuVideoModel *)obj;
                //数据库ID转成字符型
                  NSString *videoId1 = [NSString stringWithFormat:@"%@",model.ID];
                [videoIdArr addObject:videoId1];

            }];
            
            for (AlivcQuVideoModel *model in videoList) {
                //数据库ID转成字符型
                NSString *videoId2 = [NSString stringWithFormat:@"%@",model.ID];
                if (![videoIdArr containsObject:videoId2]) {
                     [moreVideoList addObject:model];
                }
            }
            
            [self.collectionViewDataSource.videoList addObjectsFromArray:moreVideoList];
            [self fetchedMoreVideos:moreVideoList];
            
        }else{
          
             for (int i = 0; i < videoList.count; i++) {
                 NSInteger index = self.collectionViewDataSource.videoList.count - 1 + i;
                 NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0] ;
                 [indexPaths addObject:indexPath];
             }

             [self.collectionViewDataSource.videoList addObjectsFromArray:videoList];
             [self fetchedMoreVideos:videoList];
        }
        
               [self.collectionView performBatchUpdates:^{
                   [self.collectionView insertItemsAtIndexPaths:indexPaths];
               } completion:^(BOOL finished) {
               }];
    }
}

#pragma mark - player function   播放视频
- (void)fetchedNewVideos:(NSArray<AlivcQuVideoModel *> *)videos {
    [self.playerManager stop];
    [self.playerManager clear];
        
    [self.playerManager updateAccessId:self.accessKeyId accessKeySecret:self.accessKeySecret securityToken:self.securityToken region:self.region];
    [self.playerManager addPlayList:videos];
}

- (void)fetchedMoreVideos:(NSArray<AlivcQuVideoModel *> *)videos {
    
   [self.playerManager updateAccessId:self.accessKeyId accessKeySecret:self.accessKeySecret securityToken:self.securityToken region:self.region];
    [self.playerManager addPlayList:videos];
}


- (void)showAtIndex:(NSInteger)index cell:(MHShortVideoCoverCell *)cell {
    //如果是当前视频 return
    if (self.playerManager.currentIndex == index) {
        return;
    }
    
    if(cell) {
        [self.playerManager removePlayView];
        [cell addPlayer:self.playerManager.listPlayer];
        [self.playerManager playAtIndex:index];
    }
}

- (void)endDisplayingCell:(MHShortVideoCoverCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item == self.playerManager.currentIndex) {
        [self.playerManager removePlayView];
    
    }
}
- (void)didClickPlayerAtIndex:(NSInteger)index {
    switch (self.playerManager.playerStatus) {
        case AVPStatusStarted:
            [self.playerManager pause];
            break;
        case AVPStatusPaused:
            [self.playerManager resume];
            break;
        case AVPStatusPrepared:
            [self.playerManager resume];
            break;
        default:
            break;
    }
}

//移除一个视频
- (void)removePlayItem:(NSInteger)index{
    [self.collectionViewDataSource  removeVideoAtIndex:index];
    [self.playerManager removeVideoAtIndex:index];
    NSInteger count =  self.collectionViewDataSource.videoList.count;
    if (count) {
        if (index <= count -1) {
            [self moveToIndex:index];
        }else {
            //移动到最后一个
            [self moveToIndex:count -1];
        }
    }else {
        [self.playerManager stop];
        [self.navigationController popViewControllerAnimated:YES];
    }
}


- (void)showCurrentVideo {
    NSInteger index = self.collectionView.contentOffset.y / ScreenHeight;
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
    MHShortVideoCoverCell *cell = (MHShortVideoCoverCell *)
    [self.collectionView cellForItemAtIndexPath:indexPath];
    [self showAtIndex:index cell:cell];
}
//试图移动到哪个位置
- (void)moveToIndex:(NSInteger)index {
    [self.collectionView reloadData];
    [self.collectionView layoutIfNeeded];
    if (self.collectionViewDataSource.videoList.count) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
            [self.collectionView performBatchUpdates:^{
                [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
            } completion:^(BOOL finished) {
                [self  showCurrentVideo];
               
            }];
        });
    }
}

#pragma mark - Delegates
#pragma mark - CollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self didClickPlayerAtIndex:indexPath.item];
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
       self.indexPath = indexPath;
    //如果还剩最后三个并且不在加载中
    if(indexPath.item >= (self.collectionViewDataSource.videoList.count - 3.0) && !self.isLoading) {
//        self.indexPath = indexPath;
        [self loadMoreVideo];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
      NSLog(@"end displaycell");
        [self endDisplayingCell:(MHShortVideoCoverCell *)cell forItemAtIndexPath:indexPath];
//    if (_endDecelaring && self.playerManager.playView.hidden) {x
//        _endDecelaring = NO;
//        NSInteger index = self.collectionView.contentOffset.y / ScreenHeight;
//        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
//        AlivcShortVideoCoverCell *cell = (AlivcShortVideoCoverCell *)
//        [self.collectionView cellForItemAtIndexPath:indexPath];
//        [self showAtIndex:index cell:cell];
//    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (!self.isLoading) {
        [self showCurrentVideo];
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    if (scrollView.contentOffset.y + scrollView.bounds.size.height > scrollView.contentSize.height + 20 && self.collectionViewDataSource.videoList.count > 0) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD showMessage:NSLocalizedString(@"已经是最后一个视频了", nil) inView:self.view];
        });
    }
}

#pragma mark - AMDDelegate
/**
 @brief 下载准备完成事件回调
 @param downloader 下载downloader指针
 @param info 下载准备完成回调，@see AVPMediaInfo
 */
-(void)onPrepared:(AliMediaDownloader*)downloader mediaInfo:(AVPMediaInfo*)info {
    NSLog(@"%s",__func__);
    for (int i = 0; i < info.tracks.count; i++) {
        AVPTrackInfo *trackInfo = info.tracks[i];
        if ([trackInfo.trackDefinition isEqualToString:@"LD"]) {
            [downloader selectTrack:trackInfo.trackIndex];
            [downloader start];
            break;
        }
    }
}

/**
 @brief 错误代理回调
 @param downloader 下载downloader指针
 @param errorModel 播放器错误描述，参考AliVcPlayerErrorModel
 */
- (void)onError:(AliMediaDownloader*)downloader errorModel:(AVPErrorModel *)errorModel {
    NSLog(@"%s",__func__);
    [AlivcShortVideoProgress hideProgressForView:self.view];
    [MBProgressHUD showMessage:errorModel.message inView:self.view];
    
}

/**
 @brief 下载进度回调
 @param downloader 下载downloader指针
 @param percent 下载进度 0-100
 */
- (void)onDownloadingProgress:(AliMediaDownloader*)downloader percentage:(int)percent {
    NSLog(@"%s",__func__);
    [AlivcShortVideoProgress refreshProgress:percent inView:self.view];
}

/**
 @brief 下载完成回调
 @param downloader 下载downloader指针
 */
- (void)onCompletion:(AliMediaDownloader*)downloader {
    NSLog(@"%s",__func__);
    [AlivcShortVideoProgress hideProgressForView:self.view];
    [self saveToAblumWithPath:downloader.downloadedFilePath];
    
}

- (void)saveToAblumWithPath:(NSString *)filePath {
    NSLog(@"趣视频下载功能log:onCompletion");
    __weak typeof(self) weakSelf = self;
    NSURL *photoUrl = [NSURL fileURLWithPath:filePath];
    if (photoUrl) {
        PHPhotoLibrary *libaray = [PHPhotoLibrary sharedPhotoLibrary];
        NSError *error;
        [libaray  performChangesAndWait:^{
            [PHAssetChangeRequest creationRequestForAssetFromVideoAtFileURL:photoUrl];
        } error:&error];
        
        NSString *msg = NSLocalizedString(@"视频已保存到相册" , nil);
        if(error){
            msg = NSLocalizedString(@"保存失败" , nil);
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD showMessage:msg inView:weakSelf.view];
        });
        
    }
}
#pragma mark - AlivcShortVideoProgressDelegate
- (void)shortVideoProgressView:(AlivcShortVideoProgress *)view dismissButtonTouched:(UIButton *)button {
    //取消下载
    [self.downloader stop];
    [AlivcShortVideoProgress hideProgressForView:self.view];
}



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
        [[AlivcShortVideoRoute shared] registerHasRecordMusic:NO];
        [[AlivcShortVideoRoute shared] registerMediaConfig:defauleMedia];
        
        
        UIViewController *editVideoSelectVC = [[AlivcShortVideoRoute shared]alivcViewControllerWithType:AlivcViewControlEditVideoSelect];
        [editVideoSelectVC setValue:@1 forKey:@"isOriginal"];
        [self.navigationController pushViewController:editVideoSelectVC animated:YES];
    }
}


#pragma mark - MHShortVideoMenuViewDelegate
-(void)MHShortVideoMenuViewDownloadAction {
    NSLog(@"下载按钮");
    //判断网络
    AliyunSVNetworkStatus netWorkStatus = [self.reachability currentReachabilityStatus];
    if(netWorkStatus == AliyunSVNetworkStatusNotReachable) {
        [MBProgressHUD showMessage:NSLocalizedString(@"当前无网络,请连网后重试!" , nil) inView:self.view];
        return;
    }
    //判断权限
    __weak typeof(self) weakSelf = self;
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if(status == PHAuthorizationStatusRestricted || status == PHAuthorizationStatusDenied){
        //没有权限 弹出提示框
        [weakSelf showPhotoLibUnAuthAlert];
        return;
    }
    if (status == PHAuthorizationStatusNotDetermined) {
        //请求授权
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusAuthorized) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.36 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [weakSelf downloadVideoWithVideoId:weakSelf.playerManager.playingVideo.videoId];
                    [AlivcShortVideoProgress showInView:weakSelf.view delegate:self];
                });
            }
        }];
        return;
    }
    [self downloadVideoWithVideoId:self.playerManager.playingVideo.videoId];
    [AlivcShortVideoProgress showInView:self.view delegate:self];
}

-(void)MHShortVideoMenuViewDeleteAction {
    AlivcAlertView *alertView = [[AlivcAlertView alloc]initWithAlivcTitle:nil message:NSLocalizedString(@"确认删除吗?" , nil) delegate:self cancelButtonTitle:NSLocalizedString(@"取消" , nil) confirmButtonTitle:NSLocalizedString(@"确认" , nil)];
    [alertView setStyle:AlivcAlertViewStyleWhite];
    alertView.tag = 106;
    [alertView show];
}


#pragma mark - AlivcShortVideoPublishManagerDelegate
- (void)publishManager:(MHShortVideoPublishManager *)manager updateProgress:(CGFloat)progress{
    NSLog(@"趣视频上传测试:%f",progress);
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.uploadProgress setProgress:progress];
    });
}

- (void)publishManager:(MHShortVideoPublishManager *)manager uploadStatusChangedTo:(AlivcPublishStatus)newStatus{
    dispatch_async(dispatch_get_main_queue(), ^{
        switch (newStatus) {
            case AlivcPublishStatusCancel:
                
                [self.uploadProgress removeFromSuperview];
                
                [[NSNotificationCenter defaultCenter]postNotificationName:AlivcNotificationPublishFlowEnd object:nil];
                NSLog(@"趣视频上传测试：AlivcUploadStatusCancel");
                break;
            case AlivcPublishStatusFailure:{
                [self.uploadProgress setShowText:NSLocalizedString(@"发布失败" , nil)];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.uploadProgress removeFromSuperview];
                });
                [self showErrorAlertViewWithString:NSLocalizedString(@"网络中断，发布失败" , nil)];
                NSLog(@"趣视频上传测试：AlivcUploadStatusFailure");
                [[NSNotificationCenter defaultCenter]postNotificationName:AlivcNotificationPublishFlowEnd object:nil];
            }
                break;
            case AlivcPublishStatusPublishing:{
                [self.uploadProgress setShowText:NSLocalizedString(@"后台发布中" , nil)];
            }
                NSLog(@"趣视频上传测试：AlivcUploadStatusUploading");
                break;
            case AlivcPublishStatusSuccess:{
                [self.uploadProgress setProgress:1];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.uploadProgress removeFromSuperview];
                });
                [[NSNotificationCenter defaultCenter]postNotificationName:AlivcNotificationPublishFlowEnd object:nil];
            }
                NSLog(@"趣视频上传测试：AlivcUploadStatusSuccess");
                break;
            default:
                break;
        }
    });
    
}

- (void)publishManager:(MHShortVideoPublishManager *)manager succesWithVid:(NSString *)vid coverImageUrl:(NSString *)imageUrl{
    NSLog(@"manager=%@",manager.coverImage);
     NSLog(@"imageUrl=%@",imageUrl);
    
    
    NSMutableDictionary *mdic = [[NSMutableDictionary alloc]init];
    if (self.userToken) {
        [mdic setObject:self.userToken forKey:@"token"];
    }
    AliyunUploadSVideoInfo *info = [MHShortVideoPublishManager shared].videoInfo;
//    if (info.title) {
//        [mdic setObject:info.title forKey:@"title"];
//    }
//    if (info.desc) {
//        [mdic setObject:info.desc forKey:@"description"];
//    }
    
    if ([FUCacheManager read:COMMON_VIDEO_FILEID]) {
        [mdic setObject:[FUCacheManager read:COMMON_VIDEO_FILEID] forKey:@"id"];
    }
    
    if ([FUCacheManager read:COMMON_VIDEO_FILENAME]) {
        [mdic setObject:[FUCacheManager read:COMMON_VIDEO_FILENAME] forKey:@"fileUrl"];
    }
    
    
    if (vid) {
        [mdic setObject:vid forKey:@"videoId"];
        self.getVideoID = vid;
    }
    if (imageUrl) {
        [mdic setObject:imageUrl forKey:@"coverUrl"];
    }
    //分类等其他信息因为需求原因 一些用不到的值默认为0
//    [mdic setObject:@"0" forKey:@"duration"];
//    [mdic setObject:@"0" forKey:@"size"];
//    [mdic setObject:@"0" forKey:@"tags"];
//    [mdic setObject:@"0" forKey:@"cateId"];
//    [mdic setObject:@"0" forKey:@"cateName"];
    
    //把一些信息反馈到server端
    _publishParamDic = mdic;
   [self publishToAppServerWithDic:mdic];
    
}


//发布视频-------
- (void)publishToAppServerWithDic:(NSDictionary *)paramDic{

//        [MHShortVideoServerManager dayeServerVideoPublishWithDic:paramDic success:^{
//        NSLog(@"插入appserver数据库成功");
//        [self.uploadProgress setShowText:NSLocalizedString(@"发布成功" , nil)];
//        [MBProgressHUD showMessage:NSLocalizedString(@"发布成功，已进入审核通道" , nil) inView:self.view];
//        [[NSNotificationCenter defaultCenter]postNotificationName:AlivcNotificationVideoPublishSuccess object:nil];
//        [[MHShortVideoPublishManager shared]endPublishFlow];
//        _publishParamDic = nil;
//        [FUCacheManager remove:COMMON_VIDEO_FILENAME];
//        [FUCacheManager remove:COMMON_VIDEO_FILEID];
//
//    } failure:^(NSString * _Nonnull errorString) {
//        [self showErrorAlertViewWithString:NSLocalizedString(@"网络错误，发布失败" , nil)];
//        [self.uploadProgress setShowText:NSLocalizedString(@"发布失败" , nil)];
//        NSLog(@"插入appserver数据库失败:%@",errorString);
//    }];
    
    [self.uploadProgress setShowText:NSLocalizedString(@"发布成功" , nil)];
    [MBProgressHUD showMessage:NSLocalizedString(@"发布成功，已进入审核通道" , nil) inView:self.view];
    [[NSNotificationCenter defaultCenter]postNotificationName:AlivcNotificationVideoPublishSuccess object:nil];
    [[MHShortVideoPublishManager shared]endPublishFlow];
    _publishParamDic = nil;
    [FUCacheManager remove:COMMON_VIDEO_FILENAME];
    [FUCacheManager remove:COMMON_VIDEO_FILEID];
    
    kGCDAfter(1, ^{
            [self SkNetSubmitAliVideoPersonAuditRequest];
       });

    
}

//测试审核视频 *************** 到时候要删掉
- (void)SkNetSubmitAliVideoPersonAuditRequest{
    
    SkNetSubmitAliVideoPersonAuditRequest *request = [[SkNetSubmitAliVideoPersonAuditRequest alloc]init];
    request.videoId = self.getVideoID;
    request.videoStatus = @"Normal";
    [SkNetApi request:request success:^(NSDictionary *pDic) {
        TOAST(@"审核成功");
    } failure:^(NSError *pError) {
        
    }];
}


- (void)showErrorAlertViewWithString:(NSString *)errorString{
    AlivcAlertView *alertView = [[AlivcAlertView alloc]initWithAlivcTitle:nil message:errorString delegate:self cancelButtonTitle:NSLocalizedString(@"关闭" , nil) confirmButtonTitle:NSLocalizedString(@"重试" , nil)];
    [alertView show];
    [alertView setStyle:AlivcAlertViewStyleWhite];
    alertView.tag = 102;
    self.publishErrprView = alertView;
}

- (void)showInfoAlertViewWithString:(NSString *)errorString{
    AlivcAlertView *alertView = [[AlivcAlertView alloc]initWithAlivcTitle:nil message:errorString delegate:self cancelButtonTitle:nil confirmButtonTitle:NSLocalizedString(@"确定" , nil)];
    [alertView show];
    [alertView setStyle:AlivcAlertViewStyleWhite];
}


#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 101 && buttonIndex == 0) {
        //取消上传
        [[MHShortVideoPublishManager shared]cancelPublish];
        [self.uploadProgress removeFromSuperview];
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    if (alertView.tag == 102) {
        if (buttonIndex == 1) {
            //重试
            [self retryPublish];
        }else{
            //取消上传
            [[MHShortVideoPublishManager shared]cancelPublish];
        }
        
    }
    if (alertView.tag == 106 && buttonIndex == 1) {
        NSString *token = self.userToken;
        
        NSString *videoId =[self.playerManager playingVideo].videoId;
//        NSString *userId = [AliVideoClientUser shared].userID;
        __weak typeof(self) weakSelf = self;
        if (videoId) {
            [MHShortVideoServerManager dayeServerDeletePersonalVideoWithToken:token videoId:videoId userId:@"" success:^{
                NSLog(@"删除视频成功");
                NSDictionary *dic = @{MHNotificationDeleveVideoSuccess:[self.playerManager playingVideo]};
                //移除当前播放视频
                [weakSelf removePlayItem:weakSelf.playerManager.currentIndex];
                [[NSNotificationCenter defaultCenter]postNotificationName:MHNotificationDeleveVideoSuccess object:nil userInfo:dic];
            } failure:^(NSString * _Nonnull errorString) {
                [MBProgressHUD showMessage:errorString inView:self.view];
            }];
            
        }else{
            [MBProgressHUD showMessage:[@"缺少必要的参数" localString] inView:self.view];
        }
    }
}

#pragma mark - Actions

- (void)becomeActive {
    self.controllerState = self.controllerState & AlivcPlayerControllerStateShowMask;
    if (self.shouldResumeWhenActive) {
        [self.playerManager resume];
    }
    NSIndexPath *firstIndexPath = [[self.collectionView indexPathsForVisibleItems] firstObject];
    if (self.playerManager.currentIndex != firstIndexPath.item && self.playerManager.currentIndex >= 0) {
    
        [self.collectionView setContentOffset:[self.collectionView.collectionViewLayout layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:self.playerManager.currentIndex inSection:0]].frame.origin animated:NO];

    }
    if (self.isDragging || self.playerManager.playView.isHidden) {
        self.isDragging = NO;
        self.playerManager.currentIndex = -1;
        [self showCurrentVideo];
    }

}

- (void)resignActive {
    self.controllerState = self.controllerState | AlivcPlayerControllerStateEnterbackground;
    if(self.playerManager.playerStatus == AVPStatusStarted) {
        self.shouldResumeWhenActive = YES;
    }else {
        self.shouldResumeWhenActive = NO;
    }
    [self.playerManager pause];
    if(self.collectionView.isDragging) {
        self.isDragging = YES;
    }
    
}

- (void)enterMask {
    self.controllerState = self.controllerState | AlivcPlayerControllerStateShowMask;
    [self.playerManager pause];
    [self.elasticView enterEditStatus:YES inView:self.view];
}

- (void)quitMask {
    self.controllerState = self.controllerState & AlivcPlayerControllerStateEnterbackground;
    [self.playerManager resume];
    [self.elasticView enterEditStatus:NO inView:self.view];
}

- (void)backButtonTouched:(UIButton *)sender {
    [self.playerManager stop];
    [self.playerManager clear];
    [self.navigationController popViewControllerAnimated:YES];
}


//添加喜欢视频
-(void)addLikeAction{
    [self Net_addUserCollection];
   
}

//取消喜欢视频
-(void)cancelLikeAction{
    [self Net_delUserCollection];

}

//网络状态判定
- (void)reachabilityChanged{
    AliyunSVNetworkStatus status = [self.reachability currentReachabilityStatus];
    switch (status) {
        case AliyunSVNetworkStatusNotReachable://由播放器底层判断是否有网络
            [MBProgressHUD showMessage:NSLocalizedString(@"请检查网络连接!" , nil) inView:self.view];
            break;
        case AliyunSVNetworkStatusReachableViaWiFi:
            
            break;
        case AliyunSVNetworkStatusReachableViaWWAN:
        {
            [MBProgressHUD showMessage:NSLocalizedString(@"当前为4G网络,请注意流量消耗!" , nil) inView:self.view];
            
        }
            break;
        default:
            break;
    }
    //如果列表没有数据 并且 刚连上网络 需要刷新数据
    if (self.collectionViewDataSource.videoList.count == 0 && status != AliyunSVNetworkStatusNotReachable) {
        [self loadData];
    }
}

- (void)startPublish{
    [self tryPublish];
}

- (void)hideUploadProgress{
    if ([MHShortVideoPublishManager shared].currentStatus == AlivcPublishStatusPublishing) {
        self.uploadProgress.hidden = YES;
    }
}

- (void)showUploadProgress{
    if ([MHShortVideoPublishManager shared].currentStatus == AlivcPublishStatusPublishing) {
        self.uploadProgress.hidden = NO;
    }
}

/**
 尝试上传视频
 @return YES:开始合成成功
 */
- (BOOL)tryPublish{
    
    AliyunSVNetworkStatus status = [self.reachability currentReachabilityStatus];
    if (status == AliyunSVNetworkStatusNotReachable) {
        [MBProgressHUD showMessage:NSLocalizedString(@"请检查网络连接!" , nil) inView:self.view];
        return NO;
    }
    
    [MHShortVideoPublishManager shared].managerDelegate = self;
    BOOL startSuccess = [[MHShortVideoPublishManager shared]startPublishWithSaveToAlbum:YES];
    if (startSuccess) {
        //图片
        UIImage *image = [[MHShortVideoPublishManager shared] coverImage];
        //创建上传进度示意图
        AlivcShortVideoUploadProgressView *progress = [[AlivcShortVideoUploadProgressView alloc] initWithBackgroundImage:image];
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        if (window) {
            [window addSubview:progress];
        }else{
            [self.view addSubview:progress];
        }
        progress.center = CGPointMake(8 + progress.frame.size.width / 2, progress.frame.size.height/2 + 64);
        self.uploadProgress = progress;
    }else{
        //没有上传的资源，不做任何处理
        if (self.uploadProgress) {
            [self.uploadProgress removeFromSuperview];
        }
    }
    return startSuccess;
}


/**
 重试发布
 */
- (void)retryPublish{
    if ([MHShortVideoPublishManager shared].currentStatus == AlivcPublishStatusSuccess && _publishParamDic) {
        //之前已经发布成功了，只是插入appserver的数据库失败了，这次重新执行插入请求
        [self.uploadProgress setShowText:NSLocalizedString(@"正在重试" , nil)];
//        [self publishToAppServerWithDic:_publishParamDic];
    }else{
        AlivcPublishStatus preStatus = [MHShortVideoPublishManager shared].currentStatus;
        if (preStatus != AlivcPublishStatusSuccess && preStatus != AlivcPublishStatusNoTStart) {
            // 短视频sdk 3.7.7退后台重新合成有适配性bug，重新合成实际成功，现象是返回失败，所以这里不做判断
            BOOL restartSuccess = [[MHShortVideoPublishManager shared] restartPublishFromPreCurrentStatus];
            NSLog(@"%d",restartSuccess);
            if (self.uploadProgress) {
                UIWindow *window = [UIApplication sharedApplication].keyWindow;
                if (window) {
                    [window addSubview:self.uploadProgress];
                }
                self.uploadProgress.center = CGPointMake(8 + self.uploadProgress.frame.size.width / 2, self.uploadProgress.frame.size.height/2 + 64);
            }
        }else{
            NSLog(@"之前不是上传状态，不重新尝试上传");
        }
    }
}

//用户添加喜欢视频 请求
- (void)Net_addUserCollection{
    NSString *token = self.userToken;
    NSString *videoId =[self.playerManager playingVideo].ID;
    if (token && videoId) {
            [MHShortVideoServerManager dayeAddUserCollectionListWithToken:token videoId:videoId success:^{
                [self.collectionViewDataSource.videoList enumerateObjectsUsingBlock:^(AlivcShortVideoBasicVideoModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    AlivcQuVideoModel *model = (AlivcQuVideoModel *)obj;
                    if ( self.indexPath.item ==idx) {
                        model.collection = @"1";
                    }
                }];
                MHShortVideoCoverCell *cell = (MHShortVideoCoverCell *)
                   [self.collectionView cellForItemAtIndexPath:self.indexPath];
                [cell setSelected:YES];
                
            } failure:^(NSString * _Nonnull errorString) {
                 [MBProgressHUD showMessage:errorString inView:self.view];
            }];
               
        }else{
            [MBProgressHUD showMessage:[@"缺少必要的参数" localString] inView:self.view];
        }
}


//用户取消喜欢视频 请求
- (void)Net_delUserCollection{
    NSString *token = self.userToken;
       NSString *videoId =[self.playerManager playingVideo].ID;
       if (token && videoId) {
              [MHShortVideoServerManager dayeDelUserCollectionListWithToken:token videoId:videoId  success:^{
                  [self.collectionViewDataSource.videoList enumerateObjectsUsingBlock:^(AlivcShortVideoBasicVideoModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                      AlivcQuVideoModel *model = (AlivcQuVideoModel *)obj;
                      if ( self.indexPath.item ==idx) {
                          model.collection = @"0";
                      }
                  }];
                  MHShortVideoCoverCell *cell = (MHShortVideoCoverCell *)
                     [self.collectionView cellForItemAtIndexPath:self.indexPath];
                  [cell setSelected:NO];

              } failure:^(NSString * _Nonnull errorString) {
                  [MBProgressHUD showMessage:errorString inView:self.view];
              }];
                  
          }else{
              [MBProgressHUD showMessage:[@"缺少必要的参数" localString] inView:self.view];
          }
}

#pragma mark - getter & setter
- (AlivcShortVideoElasticView *)elasticView{
    if (!_elasticView) {
        _elasticView = [[AlivcShortVideoElasticView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        _elasticView.delegate = self;
    }
    return _elasticView;
}

//- (AlivcShortVideoMenuView *)menuView{
//    if (!_menuView) {
//        _menuView = [[AlivcShortVideoMenuView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, CGRectGetHeight(self.view.bounds))];
//        _menuView.delegate = self;
//    }
//    return _menuView;
//}

- (void)setControllerState:(AlivcPlayerControllerState)controllerState {
    _controllerState = controllerState;
    self.playerManager.canPlay = !controllerState;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    }
    return _collectionView;
}

- (MHShortVideoPlayCollectionViewDataSource *)collectionViewDataSource {
    if (!_collectionViewDataSource) {
        __weak typeof(self) weakSelf = self;
        _collectionViewDataSource = [[MHShortVideoPlayCollectionViewDataSource alloc] initWithCellID:CELLID cellConfig:^(MHShortVideoCoverCell * _Nullable cell, NSIndexPath * _Nullable indexPath) {
            cell.model = [weakSelf.collectionViewDataSource videoModelWithIndexPath:indexPath];
            cell.delegate = self;
        }];
    }
    return _collectionViewDataSource;
}

#pragma mark - notice
- (void)actionWX:(NSNotification *)notification{
    
    NSString *tag = notification.userInfo[@"tag"];
    if ([tag isEqualToString:@"100"]) {
        TOAST(@"微信分享");
    }else{
        TOAST(@"微信朋友圈分享");
    }
}
@end


