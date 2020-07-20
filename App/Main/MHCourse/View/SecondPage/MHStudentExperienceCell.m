//
//  MHStudentExperienceCell.m
//  App
//
//  Created by dayewang on 2020/7/9.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import "MHStudentExperienceCell.h"

#import "MHCourseModel.h"

//*********** 课程展示CELL
@interface MHStudentExperienceCell()
@property(nonatomic,strong)UIView *vwLine;

@end

@implementation MHStudentExperienceCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
         __weak typeof(self) weakSelf = self;
//        _vwLine = [UIView hyb_addTopLineToView:self.contentView height:0.5 color:kLineColor];
        
        UIView *bgView = [UIView hyb_viewWithSuperView:self.contentView constraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(5, 10, 5, 10));
        }];
        bgView.backgroundColor = SK_COLOR_BASE_BACKGROUND;
        
        _coverI = [UIImageView hyb_viewWithSuperView:bgView constraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SK_MARGINLR);
            make.top.mas_equalTo(10);
            make.size.mas_equalTo(CGSizeMake(AUTO(30), AUTO(30)));
        }];
        _coverI.backgroundColor = [UIColor grayColor];
        _coverI.layer.cornerRadius = AUTO(15);
        
        _titleL = [UILabel hyb_labelWithFont:NSIZE superView:bgView constraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.coverI.mas_top).offset(0);
            make.left.equalTo(weakSelf.coverI.mas_right).offset(10);
            make.right.mas_equalTo(-10);
            make.bottom.equalTo(weakSelf.coverI.mas_bottom).offset(0);
        }];
        _titleL.numberOfLines = 2;
        _titleL.textColor = [UIColor blackColor];
        
        _contentL = [UILabel hyb_labelWithFont:AUTO(12) superView:bgView constraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.coverI.mas_bottom).offset(5);
            make.left.mas_equalTo(SK_MARGINLR);
            make.right.mas_equalTo(-SK_MARGINLR);
            
        }];
        _contentL.textColor = SK_COLOR_BASE_TEXT_GRAY;
        _contentL.numberOfLines = 0;
        
        _remarkL = [UILabel hyb_labelWithFont:AUTO(12) superView:bgView constraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SK_MARGINLR);
            make.top.equalTo(weakSelf.contentL.mas_bottom).offset(5);;
            make.width.mas_equalTo(AUTO(100));
               }];
        _remarkL.textColor = SK_COLOR_BASE_TEXT_GRAY;
    }
    return self;
}
-(void)setModel:(id)model indexPath:(NSIndexPath *)indexPath{
    MHCourseModel *messagem = (MHCourseModel *)model;
    _titleL.text = messagem.title;
    _contentL.text = messagem.content;
    _remarkL.text = messagem.remark;
    
    
    if (indexPath.row == 0) {
        _vwLine.hidden = YES;
    }else{
        _vwLine.hidden = NO;
    }
}

@end





//*********** 播放页标题
@interface MHCoursePlayHeadTitleView ()
@property(nonatomic,strong)UILabel *titleL;
@property(nonatomic,strong)UIButton *contentBtn;
@end

@implementation MHCoursePlayHeadTitleView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        __weak typeof(self) weakSelf = self;
        
        UIView *spaceView = [UIView hyb_viewWithSuperView:self.contentView constraints:^(MASConstraintMaker *make) {
            make.left.and.right.mas_equalTo(0);
            make.height.mas_equalTo(10);
            make.top.mas_equalTo(0);
        }];
        spaceView.backgroundColor = SK_COLOR_BASE_BACKGROUND;
        
        UIView *vLine = [UIView hyb_viewWithSuperView:self.contentView constraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SK_MARGINLR);
            make.width.mas_equalTo(3);
            make.top.mas_equalTo(20);
            make.height.mas_equalTo(15);
        }];
        vLine.backgroundColor = [UIColor orangeColor];
        
        self.titleL = [UILabel hyb_labelWithFont:AUTO(15) superView:self.contentView constraints:^(MASConstraintMaker *make) {
            make.left.equalTo(vLine).offset(10);
            make.right.mas_equalTo(-15);
            make.top.mas_equalTo(10);
            make.bottom.mas_equalTo(0);
        }];
//        self.titleL.text = @"猜你喜欢";
        self.titleL.textColor = SK_COLOR_BASE_SEBACKGROUND;
        
        
        
        UIImageView *iconV = [UIImageView hyb_imageViewWithImage:@"p_arrow" superView:self.contentView constraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-AUTO(SK_MARGINLR));
            make.size.mas_equalTo(CGSizeMake(AUTO(6), AUTO(11)));
//            make.top.mas_equalTo(AUTO(20));
            make.centerY.equalTo(weakSelf.contentView.mas_centerY).offset(AUTO(5));
        }];
                
        self.contentBtn = [UIButton hyb_buttonWithSuperView:self.contentView constraints:^(MASConstraintMaker *make) {
            make.right.equalTo(iconV.mas_left).offset(-AUTO(10));
            make.top.mas_equalTo(AUTO(10));
            make.bottom.mas_equalTo(0);
        } touchUp:^(UIButton *sender) {
            NSInteger tag = sender.tag;
            NoticeModel* model = [[NoticeModel alloc]init:tag msg:nil data:nil];
            NSString* targer = @"MHCousrsePlayViewController";
            [[NSNotificationCenter defaultCenter] postNotificationName:targer object:nil userInfo:[model mj_keyValues]];
        }];
        self.contentBtn.titleLabel.font = FONT(AUTO(13));
        [self.contentBtn setTitleColor:SK_COLOR_BASE_TEXT_GRAY forState:UIControlStateNormal];
        
        
       
    }
    return self;
}

-(void)setModel:(id)model section:(NSInteger )section{
   
    if (section==0) {
        self.titleL.text = @"听课列表";
        [self.contentBtn setTitle:@"查看全部课程" forState:UIControlStateNormal];
        self.contentBtn.tag = 100;
    }else{
        self.titleL.text = @"精选心得";
        [self.contentBtn setTitle:@"发布心得" forState:UIControlStateNormal];
        self.contentBtn.tag = 200;
    }
}

@end




//*********** 课程播放列表     Listening

//#import "MHCourseListeningSingleCell.h"
#import "MHCourseListeningSingleModel.h"
static NSString *cellid = @"MHCourseListeningSingleCell";
@interface MHCourseListeningListCell ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)NSMutableArray *arrData;

@end


@implementation MHCourseListeningListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _arrData = [[NSMutableArray alloc]init];
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self collectionView];
        [self requstData];
    }
    return self;
}

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [UICollectionView hyb_collectionViewWithDelegate:self horizontal:YES superView:self];
        [_collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClassNames:@[cellid]];
    }
    return _collectionView;
}

#pragma mark collectionview代理

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((kScreenWidth + AUTO(50))/3,AUTO(80));
}
//每个section中的列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}
//每个item之间的行间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 10;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(15, 15, 15, 15 );
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{

    return CGSizeZero;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _arrData.count;
    
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MHCourseListeningSingleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellid forIndexPath:indexPath];
    MHCourseListeningSingleModel *model = _arrData[indexPath.row];
    [cell setModel:model indexPath:indexPath];
    return cell;
}


-(void)setModel:(id)model indexPath:(NSIndexPath *)indexPath{
    
}

-(void)requstData{
    NSArray *titles = @[@"免费课：他们是怎么赚 到钱的?",@"第一课：他们是怎么赚 到钱的是的是的发送到 爱仕达多所",@"第一课：他们是怎么赚 到钱的是的是的发送到 爱仕达多所",@"第一课：他们是怎么赚 到钱的是的是的发送到 爱仕达多所",@"第一课：他们是怎么赚 到钱的是的是的发送到 爱仕达多所"];
   
    for (int idx = 0; idx < titles.count; idx++) {
        MHCourseListeningSingleModel *model = [[MHCourseListeningSingleModel alloc]init];
        model.title = titles[idx];
        [_arrData addObject:model];
    
    }

    [_collectionView reloadData];
}
@end







//*********** 课程cell
#import "MHCourseListeningSingleModel.h"
@interface MHCourseListeningSingleCell ()
@property(nonatomic,strong)UILabel *titleL;
@end
@implementation MHCourseListeningSingleCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = SK_COLOR_BASE_BACKGROUND;
        UILabel *titleL = [UILabel hyb_labelWithFont:AUTO(14) superView:self.contentView constraints:^(MASConstraintMaker *make) {
            make.top.and.bottom.mas_equalTo(0);
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
        }];
        titleL.numberOfLines = 4;
        titleL.textColor = SK_COLOR_BASE_TEXT_BLACK;
        self.titleL = titleL;
    }
    return self;
}
-(void)setModel:(id)model indexPath:(NSIndexPath *)indexPath{
    
    MHCourseListeningSingleModel *messagem = (MHCourseListeningSingleModel *)model;
       _titleL.text = messagem.title;
}



@end




