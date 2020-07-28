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
//设置cell和计算统一的字体
#define kCellFont 14

static NSString *cellid = @"MHPublishVideoCell";
static NSString *headId = @"MHPublishHeadView";
static NSString *titleId = @"MHPublishTitleHeadView";

@interface MHPublishVideoViewControl () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic,weak) UICollectionView *collectionView;

@property (nonatomic,strong) NSMutableArray *dataArrM;

@end

@implementation MHPublishVideoViewControl

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = SK_COLOR_BASE_SEBACKGROUND;
    self.title = @"发布";
    [self collectionView];
    
    //登录按钮
        UIButton *btn = [UIButton hyb_buttonWithTitle:@"确认发布" superView:self.view constraints:^(MASConstraintMaker *make) {
           make.left.mas_equalTo(AUTO(20));
           make.right.mas_equalTo(-AUTO(20));
           make.bottom.mas_equalTo(-AUTO(20));
           make.height.mas_equalTo(AUTO(44));
        } touchUp:^(UIButton *sender) {
            TOAST(@"成功成功");
        }];
         btn.titleLabel.font = NFONT;
         btn.layer.cornerRadius = AUTO(25);
         btn.backgroundColor = SK_COLOR_BASE_ORANGE;
        [btn setTitleColor:SK_COLOR_BASE_TITLEMAIN forState:UIControlStateNormal];
    
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
        }
        return 0;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MHPublishVideoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellid forIndexPath:indexPath];
    cell.lblName.text = self.dataArrM[indexPath.item];
    cell.layer.cornerRadius = 3;
    cell.clipsToBounds = YES;
    
    return cell;
}

//必须实现
#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        NSString *title = self.dataArrM[indexPath.item];
        //文字的高和宽
        CGSize size = [title sizeWithFontSize:kCellFont maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        //根据文字高和宽在自己增加些范围，使之较为美观
        return CGSizeMake(size.width + 15, size.height + 10);
    }else{
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
    return UIEdgeInsetsMake(10, 10, 10, 10 );
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if(kind == UICollectionElementKindSectionHeader) {
        if (indexPath.section == 0) {
            MHPublishHeadView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headId forIndexPath:indexPath];
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
        collectionView.delegate = self;
        collectionView.dataSource = self;
        
        collectionView.backgroundColor = SK_COLOR_BASE_SEBACKGROUND;
        [collectionView registerClass:[MHPublishTitleHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:titleId];
        [collectionView registerClass:[MHPublishHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headId];
        [collectionView registerClass:[MHPublishVideoCell class] forCellWithReuseIdentifier:cellid];

        [self.view addSubview:collectionView];
        
        _collectionView = collectionView;
    }
    return _collectionView;
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
            TOAST(@"选择关联课程");
        }
            break;
            
        case 300:
            
        {
            
            
        }
            break;
            
        default:
            break;
    }
    
}


- (NSMutableArray *)dataArrM
{
    if (!_dataArrM) {
        _dataArrM = [NSMutableArray array];
        
        for (int i = 0; i < 10; i ++) {
            NSInteger num = arc4random()%3;
            NSString *str;
            if (num == 0) {
                str = @"搜索关键字";
            }else if(num == 1){
                str = @"关键词";
            }else if (num == 2){
                str = @"爱好";
            }else if (num == 3){
                str = @"编码风格";
            }
            [_dataArrM addObject:str];
        }
    }
    return _dataArrM;
}

@end


