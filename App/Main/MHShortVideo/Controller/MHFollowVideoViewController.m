//
//  MHFollowVideoViewController.m
//  App
//
//  Created by Pro on 2020/6/3.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import "MHFollowVideoViewController.h"
#import "MBProgressHUD+AlivcHelper.h"
#import "MHShortVideoServerManager.h"
#import "AlivcAlertView.h"
#import "NSString+AlivcHelper.h"
#import "AlivcShortVideoElasticView.h"
#import "AlivcShortVideoRoute.h"
#import "AlivcShortVideoTabBar.h"
#import "AlivcDefine.h"
#import "MHShortVideoPublishManager.h"
#import "AlivcMacro.h"
#import "AlivcImage.h"

@interface MHFollowVideoViewController ()<UIAlertViewDelegate,AlivcShortVideoElasticViewDelegate>
/**
 渐变图层
 */
@property (strong, nonatomic) CAGradientLayer *gradientLayer;

/**
 弹层视图
 */
@property (nonatomic, strong) AlivcShortVideoElasticView *elasticView;

@end

@implementation MHFollowVideoViewController

#pragma mark - Getter
- (AlivcShortVideoElasticView *)elasticView{
    if (!_elasticView) {
        _elasticView = [[AlivcShortVideoElasticView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        _elasticView.delegate = self;
    }
    return _elasticView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor grayColor];

    
    [self addNotification];
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

- (void)publishSuccess{
    [MBProgressHUD showMessage:NSLocalizedString(@"发布成功，已进入审核通道" , nil) inView:self.view];
}

@end
