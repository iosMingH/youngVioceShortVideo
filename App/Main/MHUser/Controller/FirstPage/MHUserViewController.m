//
//  MHUserViewController.m
//  App
//
//  Created by Pro on 2020/6/24.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import "MHUserViewController.h"
#import "MHUserHeadView.h"
#import "HoverViewFlowLayout.h"
#import "AlivcQuVideoModel.h"
#import "MBProgressHUD+AlivcHelper.h"

#import "MHShortVideoCCell.h"
#import "AlivcQuHeaderReusableView.h"

#import "AliVideoClientUser.h"

#import "MHShortVideoServerManager.h"

#import "AlivcAlertView.h"

#import "NSString+AlivcHelper.h"

#import "AlivcShortVideoElasticView.h"

#import "AlivcShortVideoRoute.h"

#import "AlivcShortVideoTabBar.h"

#import "AlivcUserInfoViewController.h"

#import "AlivcDefine.h"

#import "MHShortVideoPublishManager.h"

#import "AliyunReachability.h"

//#import "AlivcShortVideoPlayViewController.h"
#import "MHShortVideoLivePlayViewController.h"

#import "AlivcMacro.h"
#import "AlivcImage.h"

#import "MHUserFollowViewController.h"
#import "MHIntegralViewController.h"
#import "MHEditInfoViewController.h"
#import "MHSettingViewController.h"
#import "MHCourseVideoDetailViewController.h"
#import "MHMyCourseViewController.h"
#import "MHOpenShopView.h"


#define kUserInfoHeaderHeight          AUTO(240)
#define kSlideTabBarHeight             AUTO(40)
static CGFloat device = 4;//间距
static CGFloat beside = 8; //边距
static NSInteger kPageCountPerQuerry = 10;//每次请求查询的个数

NSString * const kUserInfoCell         = @"MHUserHeadView";
NSString * const kAwemeCollectionCell  = @"AwemeCollectionCell";

@interface MHUserViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate,OnTabTapActionDelegate,UIAlertViewDelegate,AlivcShortVideoElasticViewDelegate>
@property (nonatomic, strong) NSMutableArray         *workAwemes;
@property (nonatomic, strong) NSMutableArray         *shareAwemes;
@property (nonatomic, strong) NSMutableArray         *favoriteAwemes;
@property (nonatomic, copy)   NSString                           *uid;
@property (nonatomic, assign) NSInteger                        pageIndex;
@property (nonatomic, assign) NSInteger                        pageSize;
@property (nonatomic, assign) NSInteger                        tabIndex;
@property (nonatomic, assign) CGFloat                          itemWidth;
@property (nonatomic, assign) CGFloat                          itemHeight;

@property (nonatomic, strong) MHUserHeadView                   *userInfoHeader;

/**
 播放数据源列表
 */
@property (nonatomic, strong) NSMutableArray <AlivcQuVideoModel *>*videoList;

/**
 临时存储要删除的视频
 */
@property (nonatomic, strong) AlivcQuVideoModel *shouldDeleteModel;

/**
 弹层视图
 */
@property (nonatomic, strong) AlivcShortVideoElasticView *elasticView;

/**
 下拉刷新
 */
@property (nonatomic, strong) UIRefreshControl *refreshControl;

/**
 网络监听
 */
@property (nonatomic, strong) AliyunReachability *reachability;


//hm 分页
@property (nonatomic, assign) NSInteger  pageNum;

@end

@implementation MHUserViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        _workAwemes = [[NSMutableArray alloc]init];
        _favoriteAwemes = [[NSMutableArray alloc]init];
        _shareAwemes = [[NSMutableArray alloc]init];
        _pageIndex = 0;
        _tabIndex = 0;

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationItem.title = @"测试";
    self.view.backgroundColor = [UIColor blackColor];
    
    [self configBaseData];
    [self addNotification];
    self.pageNum = 1;
    [self setupUI];
    
    [self addRightButtonImage:@"p_setting" Action:@selector(settingAction)];
//    [self addNavRightBtnTitle:@"设置" action:@selector(settingAction)];
}

- (AlivcShortVideoElasticView *)elasticView{
    if (!_elasticView) {
        _elasticView = [[AlivcShortVideoElasticView alloc]initWithFrame:CGRectMake(0, -Height_NavBar, ScreenWidth, ScreenHeight)];
        _elasticView.delegate = self;
    }
    return _elasticView;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
//    self.navigationController.navigationBar.translucent = NO;
    // 关闭滑动切换抽屉
         self.drawVC.slideEnabled = YES;
}
- (void)viewWillDisappear:(BOOL)animated{
     [super viewWillDisappear:animated];
    
}

- (void)setupUI {
//    _itemWidth = (DEVICEWIDTH - (CGFloat)(((NSInteger)(DEVICEWIDTH)) % 3) ) / 3.0f;
//    _itemHeight = _itemWidth * 1.35f;
    
    if (@available(iOS 11.0, *)) {
        _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    _collectionView.alwaysBounceVertical = YES;
    _collectionView.showsVerticalScrollIndicator = NO;
    
    CGRect frame = CGRectMake(beside, 0, DEVICEWIDTH - beside * 2, DEVICEHEIGH-Height_TabBar);
    _collectionView = [[UICollectionView alloc]initWithFrame:frame collectionViewLayout:[self alivcFlowLayoutWithCollectionViewWidth:frame.size.width]];
    _collectionView.tag = 8;
    _collectionView.backgroundColor = kClearColor;
    [self.view addSubview:_collectionView];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[MHUserHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kUserInfoCell];
    [_collectionView registerClass:[MHShortVideoCCell class] forCellWithReuseIdentifier:kAwemeCollectionCell];
  //    HKAdjustsContentInsets(_collectionView);
//    //下拉刷新
    _refreshControl = [[UIRefreshControl alloc]init];
    [_refreshControl addTarget:self action:@selector(refreshData) forControlEvents:UIControlEventValueChanged];
    [_collectionView addSubview:_refreshControl];
    //上拉加载
    _collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}


/**
 布局定义

 @return 一行3个排列的瀑布流布局
 */
- (UICollectionViewFlowLayout *)alivcFlowLayoutWithCollectionViewWidth:(CGFloat )width{
    
    CGFloat itemWidth = (width - device * 2) / 3;
    CGFloat itemHeight = itemWidth / 9 * 16;
    HoverViewFlowLayout *layout = [[HoverViewFlowLayout alloc] initWithTopHeight: kSlideTabBarHeight];
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
    layout.minimumLineSpacing = device;
    layout.minimumInteritemSpacing = device;
    layout.sectionHeadersPinToVisibleBounds = NO;
    return layout;
}

- (void)initIntergralTipsView{
    MHSignInView *tipsView = [[MHSignInView alloc]initWithFrame:CGRectMake(0, 0, DEVICEWIDTH-AUTO(100), DEVICEWIDTH-AUTO(80))];
    tipsView.backgroundColor = [UIColor whiteColor];
    
    [HWPopTool sharedInstance].shadeBackgroundType = ShadeBackgroundTypeGradient;
   [HWPopTool sharedInstance].closeButtonType = ButtonPositionTypeRight;
   [[HWPopTool sharedInstance] showWithPresentView:tipsView animated:YES];
    
   
}

- (void)refreshData{
    [self configBaseData];
}

//UICollectionViewDataSource Delegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0 && kind == UICollectionElementKindSectionHeader) {
        MHUserHeadView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kUserInfoCell forIndexPath:indexPath];
        _userInfoHeader = header;
//        [header initData:nil];
        header.slideTabBar.delegate = self;
        return header;
    }
    return [UICollectionReusableView new];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if(section == 1) {
//        return _tabIndex == 0 ? 15 : 5;
        return _tabIndex == 0 ? self.videoList.count : 5;
    }
    return 0;
   
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MHShortVideoCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kAwemeCollectionCell forIndexPath:indexPath];
   if (indexPath.row < self.videoList.count) {
          [cell configUIWithModel:self.videoList[indexPath.row]];
      }
      cell.backgroundColor = [UIColor clearColor];
    return cell;
}
//UICollectionFlowLayout Delegate
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if(section == 0) {
        return CGSizeMake(DEVICEWIDTH, kUserInfoHeaderHeight);
    }
    return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeZero;
}

//OnTabTapDelegate
- (void)onTabTapAction:(NSInteger)index {
    if(_tabIndex == index){
        return;
    }
    _tabIndex = index;
//    _pageIndex = 0;
//
    [UIView setAnimationsEnabled:NO];
    [self.collectionView performBatchUpdates:^{
//        [self.workAwemes removeAllObjects];
//        [self.favoriteAwemes removeAllObjects];

        if([self.collectionView numberOfItemsInSection:1]) {
            [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:1]];
        }
    } completion:^(BOOL finished) {
        [UIView setAnimationsEnabled:YES];

    }];
    
}
- (CGFloat) navagationBarHeight {
    return self.navigationController.navigationBar.frame.size.height;
}


#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    AlivcQuVideoModel *selectedModel = self.videoList[indexPath.row];
//    switch (selectedModel.ensorStatus) {
//        case AlivcQuVideoAbstractionStatus_On:
//            [self showAlertViewWithString:NSLocalizedString(@"视频正在审核中,无法查看" , nil) withTag:0];
//            break;
//        case AlivcQuVideoAbstractionStatus_Fail:
//            _shouldDeleteModel = selectedModel;
//            [self showAlertViewWithString:NSLocalizedString(@"抱歉,该视频未通过审核,已不存在" , nil) withTag:101];
//            break;
//        case AlivcQuVideoAbstractionStatus_Success:
//        {
//            NSMutableArray *canPlayVideoList = [[NSMutableArray alloc]init];
//            for (AlivcQuVideoModel *model in self.videoList) {
//                if (model.ensorStatus == AlivcQuVideoAbstractionStatus_Success) {
//                    [canPlayVideoList addObject:model];
//                }
//            }
//            if (canPlayVideoList.count) {
//                NSInteger startIndex = 0;
//                if (canPlayVideoList.count == self.videoList.count) {
//                    startIndex = indexPath.row;
//                }else{
//                    for (AlivcQuVideoModel *itemModel in canPlayVideoList) {
//                        if ([itemModel.videoId isEqualToString:selectedModel.videoId]) {
//                            startIndex = [canPlayVideoList indexOfObject:itemModel];
//                            break;
//                        }
//                    }
//                }
//                [self hideUploadProgressView];
//                MHShortVideoLivePlayViewController *targetVC = [[MHShortVideoLivePlayViewController alloc] initWithVideoList:canPlayVideoList startPlayIndex:startIndex];
//                [self.navigationController pushViewController:targetVC animated:YES];
//            }
//
//        }
//            break;
//
//        default:
//            break;
//    }
    NSLog(@"indexPath.row=%ld",indexPath.row);
    NSMutableArray *canPlayVideoList = [[NSMutableArray alloc]init];
               for (AlivcQuVideoModel *model in self.videoList) {
                  
                       [canPlayVideoList addObject:model];
                
               }
    
               if (canPlayVideoList.count) {
                   NSInteger startIndex = 0;
                   if (canPlayVideoList.count == self.videoList.count) {
                       startIndex = indexPath.row;
                   }else{
                       for (AlivcQuVideoModel *itemModel in canPlayVideoList) {
                           if ([itemModel.videoId isEqualToString:selectedModel.videoId]) {
                               startIndex = [canPlayVideoList indexOfObject:itemModel];
                               break;
                           }
                       }
                   }
                   [self hideUploadProgressView];
                   MHShortVideoLivePlayViewController *targetVC = [[MHShortVideoLivePlayViewController alloc] initWithVideoList:canPlayVideoList startPlayIndex:startIndex];
                   [self.navigationController pushViewController:targetVC animated:YES];
               }
    
}


-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)addNotification{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(videoHaveDeleted:) name:MHNotificationDeleveVideoSuccess object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(enterMask) name:AlivcNotificationQuPlay_EnterMask object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(quitMask) name:AlivcNotificationQuPlay_QutiMask object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeUserSuccess) name:AlivcNotificationChangeUserSuccess object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(publishSuccess) name:AlivcNotificationVideoPublishSuccess object:nil];
    self.reachability = [AliyunReachability reachabilityForInternetConnection];
    [self.reachability startNotifier];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged)
                                                 name:AliyunSVReachabilityChangedNotification
                                               object:nil];
}



- (void)configBaseData{
    self.pageNum = 1;
    __weak typeof(self) weakSelf = self;
    [self.collectionView.mj_footer resetNoMoreData];
    //先查询kPageCountPerQuerry条
    [MHShortVideoServerManager dayeServerGetPersonalVideoListWithToken:[FUCacheManager read:COMMON_USER_TOKEN] pageIndex:1 pageSize:kPageCountPerQuerry lastEndVideoId:nil success:^(NSArray<AlivcQuVideoModel *> * _Nonnull videoList,NSInteger allVideoCount) {
        if (weakSelf.refreshControl) {
            [weakSelf.refreshControl endRefreshing];
        }
        if (videoList) {
            self.videoList = [[NSMutableArray alloc]initWithArray:videoList];
        }else{
            self.videoList = [[NSMutableArray alloc]init];
        }
        [self.collectionView reloadData];
         self.pageNum ++;
    } failure:^(NSString * _Nonnull errorString) {
        //
        if (weakSelf.refreshControl) {
            [weakSelf.refreshControl endRefreshing];
        }
        [MBProgressHUD showMessage:errorString inView:self.view];
    }];
}

- (void)loadMoreData{
    NSLog(@"加载更多的数据");
    AlivcQuVideoModel *lastModel = self.videoList.lastObject;
    if (lastModel.ID) {
        [MHShortVideoServerManager dayeServerGetPersonalVideoListWithToken:[FUCacheManager read:COMMON_USER_TOKEN] pageIndex:self.pageNum pageSize:kPageCountPerQuerry lastEndVideoId:lastModel.ID success:^(NSArray<AlivcQuVideoModel *> * _Nonnull videoList,NSInteger allVideoCount) {
            
//            if (videoList.count < kPageCountPerQuerry) {
//                [self.collectionView.mj_footer endRefreshingWithNoMoreData];
//            }else{
//                [self.collectionView.mj_footer endRefreshing];
//            }
            
            if (videoList.count) {
                [self.videoList addObjectsFromArray:videoList];
                [self.collectionView reloadData];
                self.pageNum ++;
            }
        } failure:^(NSString * _Nonnull errorString) {
            //
            [self.collectionView.mj_footer endRefreshing];
            [MBProgressHUD showMessage:errorString inView:self.view];
        }];
    }else{
        [self.collectionView.mj_footer endRefreshing];
    }
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 101 && _shouldDeleteModel) {
        [MHShortVideoServerManager dayeServerDeletePersonalVideoWithToken:[FUCacheManager read:COMMON_USER_TOKEN] videoId:_shouldDeleteModel.videoId userId:[AliVideoClientUser shared].userID success:^{
            NSDictionary *dic = @{MHNotificationDeleveVideoSuccess:_shouldDeleteModel};
            [[NSNotificationCenter defaultCenter]postNotificationName:MHNotificationDeleveVideoSuccess object:nil userInfo:dic];
            _shouldDeleteModel = nil;
        } failure:^(NSString * _Nonnull errorString) {
            //
        }];
    }
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


#pragma mark - Private Method
- (void)showAlertViewWithString:(NSString *)showString withTag:(NSInteger )tag{
    AlivcAlertView *alertView = [[AlivcAlertView alloc]initWithAlivcTitle:nil message:showString delegate:self cancelButtonTitle:nil confirmButtonTitle:[@"确定" localString]];
    [alertView setStyle:AlivcAlertViewStyleWhite];
    alertView.tag = tag;
    alertView.delegate = self;
    [alertView showInView:self.view];
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

- (void)changeUserSuccess{
    [self configBaseData];
}

- (void)publishSuccess{
    [self configBaseData];
    [MBProgressHUD showMessage:NSLocalizedString(@"发布成功，已进入审核通道" , nil) inView:self.view];
}

//网络状态判定
- (void)reachabilityChanged{
    AliyunSVNetworkStatus status = [self.reachability currentReachabilityStatus];
    switch (status) {
        case AliyunSVNetworkStatusNotReachable:
            [MBProgressHUD showMessage:NSLocalizedString(@"请检查网络连接!" , nil) inView:self.view];
            break;
        case AliyunSVNetworkStatusReachableViaWiFi:
            if (self.videoList.count == 0) {
                [self configBaseData];
            }
            break;
        case AliyunSVNetworkStatusReachableViaWWAN:
        {
            [MBProgressHUD showMessage:NSLocalizedString(@"当前为4G网络,请注意流量消耗!" , nil) inView:self.view];
            if (self.videoList.count == 0) {
                [self configBaseData];
            }
        }
            break;
        default:
            break;
    }
}

//视频已经删除的通知
- (void)videoHaveDeleted:(NSNotification *)noti{
    [self configBaseData];
}

#pragma mark - notice
- (void)eventNotice:(NSNotification *)info
{
    NoticeModel *model = [NoticeModel mj_objectWithKeyValues:[info userInfo]];
    switch (model.code) {
//            关注
                case 100:
            {
                MHUserFollowViewController *vc = [[MHUserFollowViewController alloc]init];
                vc.tabIndex = 0;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
//            粉丝
                case 200:
            {
                MHUserFollowViewController *vc = [[MHUserFollowViewController alloc]init];
                 vc.tabIndex = 1;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
//            获赞
                case 300:
//                    TOAST(@"获赞");
            {

            }
                break;
//            积分
                case 400:
            {
                MHIntegralViewController *vc = [[MHIntegralViewController alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
            }
            
                break;
//            申请开店
                case 500:
                    TOAST(@"申请开店");
                break;
//              我的课程
                case 600:
            {
                MHMyCourseViewController *vc = [[MHMyCourseViewController alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
            }
            
                break;
//            课程订单
                case 700:
                    TOAST(@"我的订单");
                break;
//            邀请好友
                case 800:
                    TOAST(@"邀请好友");
                break;
//            编辑资料
            case 1000:
                {
                    
                    MHEditInfoViewController *vc = [[MHEditInfoViewController alloc]init];
                    [self.navigationController pushViewController:vc animated:YES];
                }
            
            break;
//            签到
            case 1100:
                [self initIntergralTipsView];
            break;
                default:
                    break;
    }
            
}

#pragma mark - 旋转
- (BOOL)shouldAutorotate{
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationPortrait;
}

#pragma mark - action
-(void)settingAction{
//    MHSettingViewController *vc = [[MHSettingViewController alloc]init];
//    [self.navigationController pushViewController:vc animated:YES];
    [self.drawVC showRightVCAnimated:YES];
}

@end
