//
//  MHPublishVideoViewControl.m
//  App
//
//  Created by dayewang on 2020/7/27.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import "MHPublishVideoViewControl.h"
#import "NSString+Size.h"
#import "CollectionViewSpaceLayout.h"
#import "MHPublishVideoCell.h"
#import "MHPublishAddTopicView.h"
//计算文字的高和宽
#import "NSString+Size.h"
#import "MHRelationCourseController.h"
#import "MHPublishAddTopicModel.h"


#import <AliyunVideoSDKPro/AliyunPublishManager.h>
#import "AVC_ShortVideo_Config.h"
#import "AlivcQuVideoServerManager.h"
#import "AliVideoClientUser.h"
#import "MBProgressHUD+AlivcHelper.h"
#import "MHShortVideoPublishManager.h"
#import "AlivcDefine.h"
#import "AliyunMediaConfig.h"

#import "MHCourseModel.h"
//设置cell和计算统一的字体
#define kCellFont 14

static NSString *cellid = @"MHPublishVideoCell";
static NSString *headId = @"MHPublishHeadView";
static NSString *titleId = @"MHPublishTitleHeadView";
static NSString *courseCellid = @"MHChooseRelationCourseCell";

@interface MHPublishVideoViewControl () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UITextFieldDelegate,UITextViewDelegate,PassValueDelegate>

@property (nonatomic,weak) UICollectionView *collectionView;

@property (nonatomic,strong) NSMutableArray *dataArrM; //话题

@property (nonatomic,strong) NSMutableArray *courseArrM; //话题

@property (nonatomic, copy) NSString *describeStr; //视频描述

@end

@implementation MHPublishVideoViewControl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = SK_COLOR_BASE_SEBACKGROUND;
    self.title = @"发布";
    self.describeStr = @"";
      _dataArrM = [NSMutableArray array];
     _courseArrM = [NSMutableArray array];
    
    //没导航scrollView不能顶头,适配
    if (@available(iOS 11.0, *)) {
        UIScrollView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self collectionView];
    
    //发布按钮
        UIButton *btn = [UIButton hyb_buttonWithTitle:@"确认发布" superView:self.view constraints:^(MASConstraintMaker *make) {
           make.left.mas_equalTo(AUTO(20));
           make.right.mas_equalTo(-AUTO(20));
           make.bottom.mas_equalTo(-AUTO(20));
           make.height.mas_equalTo(AUTO(44));
        } touchUp:^(UIButton *sender) {
//            TOAST(@"发布成功");
            if (self.describeStr.length > 0) {
                 [self publish];
            }else{
                TOAST(@"请输入视频描述");
            }
           
        }];
         btn.titleLabel.font = NFONT;
         btn.layer.cornerRadius = AUTO(25);
         btn.backgroundColor = SK_COLOR_BASE_ORANGE;
        [btn setTitleColor:SK_COLOR_BASE_TITLEMAIN forState:UIControlStateNormal];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //显示系统的导航栏  ----------- MH
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
     if(section == 1) {
            return self.dataArrM.count;
     }else if (section == 2){
         return self.courseArrM.count;
     }
        return 0;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
         MHPublishVideoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellid forIndexPath:indexPath];
        //    cell.lblName.text = self.dataArrM[indexPath.item];
            MHPublishAddTopicModel *model = self.dataArrM[indexPath.row];
            [cell setModel:model indexPath:indexPath];
            cell.layer.cornerRadius = 3;
            cell.clipsToBounds = YES;
            
            return cell;
    }else{
         MHChooseRelationCourseCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:courseCellid forIndexPath:indexPath];
        //    cell.lblName.text = self.dataArrM[indexPath.item];
            MHCourseModel *model = self.courseArrM[indexPath.row];
            [cell setModel:model indexPath:indexPath];
            return cell;
    }
   
}

//必须实现
#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
//        NSString *title = self.dataArrM[indexPath.item];
         MHPublishAddTopicModel *model = self.dataArrM[indexPath.row];
        NSString *title = model.title;
        //文字的高和宽
        CGSize size = [title sizeWithFontSize:kCellFont maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        //根据文字高和宽在自己增加些范围，使之较为美观
        return CGSizeMake(size.width + 15, size.height + 10);
    }else if (indexPath.section == 2){
        return CGSizeMake(DEVICEWIDTH, AUTO(100));
    }
    else{
        return CGSizeZero;
    }
}

//UICollectionFlowLayout Delegate
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
  
    if (section == 0) {
        return  CGSizeMake(DEVICEWIDTH, AUTO(158));
    }else{
        return CGSizeMake(DEVICEWIDTH, AUTO(40));
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeZero;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (section == 1) {
         return UIEdgeInsetsMake(10, 10, 10, 10 );
    }else{
         return UIEdgeInsetsMake(0, 0, 0, 0);
    }
   
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if(kind == UICollectionElementKindSectionHeader) {
        if (indexPath.section == 0) {
            MHPublishHeadView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headId forIndexPath:indexPath];
            header.textT.delegate = self;
            header.coverImage.image = self.coverImage;
            [header setModel:@"" indexPath:indexPath];
            return header;
        }else{
            MHPublishTitleHeadView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:titleId forIndexPath:indexPath];
            [header setModel:@"" indexPath:indexPath];
            return header;
        }
        
    }
        return [UICollectionReusableView new];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1) {
          MHPublishAddTopicModel *model = self.dataArrM[indexPath.row];
          [self.dataArrM removeObject:model];
          [_collectionView reloadData];
    }
    
}

 // 弹出话题框
- (void)initTopicView{
    MHPublishAddTopicView *tipsView = [[MHPublishAddTopicView alloc]initWithFrame:CGRectMake(0, 0, DEVICEWIDTH-AUTO(80), AUTO(328))];
    tipsView.backgroundColor = [UIColor whiteColor];
    
    [HWPopTool sharedInstance].shadeBackgroundType = ShadeBackgroundTypeGradient;
   [HWPopTool sharedInstance].closeButtonType = ButtonPositionTypeRight;
   [[HWPopTool sharedInstance] showWithPresentView:tipsView animated:YES];
}

#pragma mark - 懒加载创建
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//        layout.sectionInsets = UIEdgeInsetsMake(8, 8, 8, 8);

        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:layout];
//        if ([self.navigationController.viewControllers.firstObject isKindOfClass: NSClassFromString(@"MHUserViewController")] ||[self.navigationController.viewControllers.firstObject isKindOfClass: NSClassFromString(@"MHMessageViewController")]){
//                CGRect frame = collectionView.frame;
//                 frame.origin.y = 0;
//                collectionView.frame = frame;
//            }
        
        collectionView.delegate = self;
        collectionView.dataSource = self;
        
        collectionView.backgroundColor = SK_COLOR_BASE_SEBACKGROUND;
        [collectionView registerClass:[MHPublishTitleHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:titleId];
        [collectionView registerClass:[MHPublishHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headId];
        [collectionView registerClass:[MHPublishVideoCell class] forCellWithReuseIdentifier:cellid];
        [collectionView registerClass:[MHChooseRelationCourseCell class] forCellWithReuseIdentifier:courseCellid];

        [self.view addSubview:collectionView];
        
        _collectionView = collectionView;
    }
    return _collectionView;
}

#pragma mark - delegate
- (void)textViewDidEndEditing:(UITextView *)textView{
    self.describeStr = textView.text;
}

//上一页面传来的数据
- (void)passValue:(id)value indexPath:(NSIndexPath *)indexPath{
    [_courseArrM removeAllObjects];
    MHCourseModel *model = (MHCourseModel *)value;
    NSLog(@"%@",model.title);
    [_courseArrM addObject:model];
    [_collectionView reloadData];
}

#pragma mark - notice
- (void)eventNotice:(NSNotification *)info
{
    NoticeModel *model = [NoticeModel mj_objectWithKeyValues:[info userInfo]];
    switch (model.code) {
//       添加话题
        case 101:
        {
//            TOAST(@"添加话题");
            [self initTopicView];
        }
            break;
//        选择关联课程
        case 102:
        {
//            TOAST(@"选择关联课程");
            MHRelationCourseController *vc = [[MHRelationCourseController alloc]init];
            vc.delegate = self;
//            [self.navigationController pushViewController:vc animated:YES];
            vc.modalPresentationStyle = UIModalPresentationFullScreen;
            [self presentViewController:vc animated:YES completion:nil];
            
        }
            break;
//      添加话题 确定
        case 400:
            
        {
            
            TOAST(@"添加话题确定");
        }
            break;
//      添加话题 确定
        case 1000:
        {
            MHPublishAddTopicModel *topic = (MHPublishAddTopicModel *)model.data;
            [_dataArrM addObject:topic];
            [_collectionView reloadData];
            
        }
            break;
        default:
            break;
    }
    
}

//发布
- (void)publish {

    AliyunUploadSVideoInfo *info = [AliyunUploadSVideoInfo new];
    info.desc = self.describeStr;
    if (info.desc) {
        NSInteger charLen = info.desc.length;
        if (charLen > 19) {
            [MBProgressHUD showMessage:NSLocalizedString(@"视频描述过长,应小于20个字符" , nil) inView:self.view];
            return;
        }
    }

    [[MHShortVideoPublishManager shared] setVideoPath:self.taskPath
                                             videoConfig:self.config];
    [[MHShortVideoPublishManager shared] setCoverImag:self.coverImage
                                               videoInfo:info];
    [self popToPlayVC];
}

- (void)popToPlayVC{

    Class viewControllerClass = NSClassFromString(@"HomeTabViewController");
    BOOL haveFind = NO;
    if (viewControllerClass) {
        for (UIViewController *itemVC in self.navigationController.viewControllers) {
            NSString *classString = NSStringFromClass([itemVC class]);
            if ([classString isEqualToString:@"HomeTabViewController"]) {
                [self.navigationController popToViewController:itemVC animated:YES];
                //派发通知
                haveFind = YES;
                [[NSNotificationCenter defaultCenter]postNotificationName:AlivcNotificationVideoStartPublish object:nil];
                break;
            }
        }
    }
    if (!haveFind) {
//        [MBProgressHUD showMessage:NSLocalizedString(@"请主页面点击中间圆圈按钮进入编辑模块" , nil) inView:self.view];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            UIViewController *targetVC = [[viewControllerClass alloc]init];
            [self.navigationController pushViewController:targetVC animated:YES];
            [[NSNotificationCenter defaultCenter]postNotificationName:AlivcNotificationVideoStartPublish object:nil];
        });
    }
}


@end

