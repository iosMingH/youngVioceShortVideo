//
//  MHCourseIntroductionView.m
//  App
//
//  Created by dayewang on 2020/7/9.
//  Copyright © 2020 李焕明. All rights reserved.
//

//**************** 课程介绍
#import "MHCourseIntroductionView.h"
#import "MHCourseModel.h"
#import "MHCourseTableViewCell.h"
#import "MHCourseHeadView.h"
#import "MHCourseVideoDetailViewController.h"

static NSString *cellId = @"MHCourseTableViewCell";
static NSString * headId = @"MHCourseIntroduceHeadTitleView";

@interface MHCourseIntroductionView ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property(nonatomic,strong)NSMutableArray *arrData;
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)MHCourseIntroduceHeadView *headView;

@end

@implementation MHCourseIntroductionView
//
//- (UITableView *)tableview{
//    if (!_tableview) {
//        _tableview = [UITableView hyb_tableViewWithSuperview:self delegate:self style:UITableViewStyleGrouped constraints:^(MASConstraintMaker *make) {
//            make.edges.mas_equalTo(self);
//        }];
//        _tableview.backgroundColor = [UIColor blackColor];
//        _tableview.tableHeaderView = _headView;
//        [_tableview registerClassNames: @[cellId,headId]];
//
//
//    }
//    return _tableview;
//}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _arrData = [[NSMutableArray alloc]init];
        [self requstData];
        [self initView];
    }
    return self;
}

- (void)initView{
    _headView = [[MHCourseIntroduceHeadView alloc]initWithFrame:CGRectMake(0, 0, DEVICEWIDTH, AUTO(250))];
    _tableview = [UITableView hyb_tableViewWithSuperview:self delegate:self style:UITableViewStyleGrouped constraints:^(MASConstraintMaker *make) {
                      make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    _tableview.tableHeaderView = _headView;
    _tableview.backgroundColor = SK_COLOR_BASE_BACKGROUND;
    [_tableview registerClassNames: @[cellId,headId]];
}


//设置cell 的行高
#pragma mark -UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return [tableView fd_heightForCellWithIdentifier:cellId cacheByIndexPath:indexPath configuration:^(id cell) {
//        [self setupModelOfCell:cell AtIndexPath:indexPath];
//    }];
    
    return AUTO(100);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return [tableView fd_heightForHeaderFooterViewWithIdentifier:headId configuration:^(id headerFooterView) {
//        [self setupModelOfHeadView:headerFooterView section:section];
//    }];
        return AUTO(40);
    
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    return [[UIView alloc]init];
//}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc]init];
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 10;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
//设置分区的个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //返回1代表1个分区
    return 1;
}
//设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //    return 10;
    //返回1代表1行
    return self.arrData.count;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    MHCourseIntroduceHeadTitleView *headView1 = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headId];
    [self setupModelOfHeadView:headView1 section:section];
    return headView1;

}


- (void)setupModelOfHeadView:(MHCourseIntroduceHeadTitleView *)headView section:(NSInteger)section{
//     [headView setModel:nil section:section];
}
#pragma mark - 创建cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MHCourseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [self setupModelOfCell:cell AtIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor whiteColor];
    cell.titleL.textColor = SK_COLOR_BASE_TEXT_GRAY_DEEP;
    cell.contentL.textColor = SK_COLOR_BASE_TEXT_GRAY;
    cell.remarkL.textColor = SK_COLOR_BASE_ORANGE;
    return cell;
}
- (void)setupModelOfCell:(MHCourseTableViewCell *)cell AtIndexPath:(NSIndexPath *)indexPath{
    MHCourseModel *list = _arrData[indexPath.row];
    [cell setModel:list indexPath:indexPath];
}

//选中指定行 调用
//已经选中
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    NSLog(@"你点击了%ld行",indexPath.row)

    if (self.delegate!= nil && [self.delegate respondsToSelector:@selector(introductionPush_nextControllerDelegate:cmm:)]) {
        [self.delegate introductionPush_nextControllerDelegate:indexPath.row cmm:self];
    }

}

-(void)requstData{
  
    for (int idx = 0; idx < 10; idx ++) {
        MHCourseModel *model = [[MHCourseModel alloc]init];
        model.title = @"六至12岁孩童逻辑思维培养课程";
        model.content = @"课程分类";
        model.remark = @"￥109";
        [_arrData addObject:model];
    }

    
    [self.tableview reloadData];

}

@end







//**************听课列表

#import "MHCourseModel.h"
#import "MHCourseTableViewCell.h"
#import "MHCourseVideoDetailViewController.h"

//static NSString *cellId = @"MHCourseTableViewCell";

@interface MHLectureListView ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray *arrData;
@property(nonatomic,strong)UITableView *tableview;
@end

@implementation MHLectureListView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _arrData = [[NSMutableArray alloc]init];
        [self requstData];
        [self initView];
    }
    return self;
}

- (void)initView{
    _tableview = [UITableView hyb_tableViewWithSuperview:self delegate:self style:UITableViewStyleGrouped constraints:^(MASConstraintMaker *make) {
                      make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
                  }];
                  _tableview.backgroundColor = SK_COLOR_BASE_BACKGROUND;
                  [_tableview registerClassNames: @[cellId]];
}


//设置cell 的行高
#pragma mark -UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return [tableView fd_heightForCellWithIdentifier:cellId cacheByIndexPath:indexPath configuration:^(id cell) {
//        [self setupModelOfCell:cell AtIndexPath:indexPath];
//    }];
    
    return AUTO(100);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc]init];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc]init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
//设置分区的个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //返回1代表1个分区
    return 1;
}
//设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //    return 10;
    //返回1代表1行
    return self.arrData.count;
}


#pragma mark - 创建cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MHCourseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [self setupModelOfCell:cell AtIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor whiteColor];
    cell.titleL.textColor = SK_COLOR_BASE_TEXT_GRAY_DEEP;
    cell.contentL.textColor = SK_COLOR_BASE_TEXT_GRAY;
    cell.remarkL.textColor = SK_COLOR_BASE_ORANGE;
    return cell;
}
- (void)setupModelOfCell:(MHCourseTableViewCell *)cell AtIndexPath:(NSIndexPath *)indexPath{
    MHCourseModel *list = _arrData[indexPath.row];
    [cell setModel:list indexPath:indexPath];
}

//选中指定行 调用
//已经选中
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (self.delegate!= nil && [self.delegate respondsToSelector:@selector(lecturePush_nextControllerDelegate:cmm:)]) {
         [self.delegate lecturePush_nextControllerDelegate:indexPath.row cmm:self];
     }
}

-(void)requstData{
  
    for (int idx = 0; idx < 4; idx ++) {
        MHCourseModel *model = [[MHCourseModel alloc]init];
        model.title = @"六至12岁孩童逻辑思维培养课程";
        model.content = @"课程分类";
        model.remark = @"￥109";
        [_arrData addObject:model];
    }

    
    [self.tableview reloadData];

}

@end





/******************** headview ************************/

@interface MHCourseVideoDetailHeadView ()
@property(nonatomic,strong)UILabel *titleL;
@property(nonatomic,strong)UILabel *contentL;
@property(nonatomic,strong)UILabel *remarkL;

@end


@implementation MHCourseVideoDetailHeadView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self bgImageView];
        [self initIntroduceView];
        
    }
    return self;
}

- (void)initIntroduceView{
    
    UIView *introduceView = [[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(_bgImageView.frame), DEVICEWIDTH, AUTO(131))];
    [self addSubview:introduceView];
    introduceView.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleL = [UILabel hyb_labelWithFont:AUTO(15) superView:introduceView constraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(SK_MARGINLR);
        make.right.mas_offset(-SK_MARGINLR);
        make.top.mas_offset(5);
//        make.height.mas_offset(AUTO(40));
    }];
    titleL.text = @"教师资格“从小到大”你的认知都发生了怎样的变化？";
    titleL.numberOfLines = 2;
    self.titleL = titleL;
    
    UILabel *contentL = [UILabel hyb_labelWithFont:AUTO(12) superView:introduceView constraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(SK_MARGINLR);
        make.right.mas_offset(-SK_MARGINLR);
        make.top.equalTo(titleL.mas_bottom).offset(AUTO(10));
//        make.height.mas_offset(AUTO(40));
    }];
    contentL.numberOfLines = 0;
    contentL.textColor = SK_COLOR_BASE_TEXT_GRAY;
    contentL.text = @"加入慕课教资交流备考群（QQ群号：1062660256），免费领取高效备 考资料，包含：福利专项课、公开课; 40+必备知识点";
    self.contentL = contentL;
    
    UILabel *remarkL = [UILabel hyb_labelWithFont:AUTO(12) superView:introduceView constraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(SK_MARGINLR);
        make.right.mas_offset(-SK_MARGINLR);
        make.top.equalTo(contentL.mas_bottom).offset(AUTO(5));
    }];
    remarkL.textColor = SK_COLOR_BASE_TEXT_GRAY;
    remarkL.text = @"已更新23节、共23节";
    self.remarkL = remarkL;
    
    UIView *spaceView = [UIView hyb_viewWithSuperView:introduceView constraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.mas_offset(0);
        make.height.mas_offset(AUTO(10));
        
    }];
    spaceView.backgroundColor = SK_COLOR_BASE_BACKGROUND;
}

- (UIImageView *)bgImageView{
    if (_bgImageView == nil) {
        _bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, self.frame.size.width,AUTO(263))];
//        _bgImageView.layer.anchorPoint = CGPointMake(0.5, 1);
        _bgImageView.image = [UIImage imageNamed:@"testBg"];
        
        
        //横向拉伸
//        _bgImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_bgImageView];
    }
    return _bgImageView;
}

- (void)setModel:(id)model section:(NSInteger)section{
    
    
}
@end




//**************学员心得
#import "MHStudentExperienceModel.h"
#import "MHStudentExperienceCell.h"
#import "MHCourseVideoDetailViewController.h"

static NSString *experienceCellId = @"MHStudentExperienceCell";

@interface MHStudentExperienceView ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray *arrData;
@property(nonatomic,strong)UITableView *tableview;
@end

@implementation MHStudentExperienceView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _arrData = [[NSMutableArray alloc]init];
        [self requstData];
        [self initView];
    }
    return self;
}

- (void)initView{
    _tableview = [UITableView hyb_tableViewWithSuperview:self delegate:self style:UITableViewStyleGrouped constraints:^(MASConstraintMaker *make) {
                      make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
                  }];
                  _tableview.backgroundColor = SK_COLOR_BASE_BACKGROUND;
                  [_tableview registerClassNames: @[experienceCellId]];
}


//设置cell 的行高
#pragma mark -UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return [tableView fd_heightForCellWithIdentifier:cellId cacheByIndexPath:indexPath configuration:^(id cell) {
//        [self setupModelOfCell:cell AtIndexPath:indexPath];
//    }];
    
    return AUTO(170);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc]init];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc]init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
//设置分区的个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //返回1代表1个分区
    return 1;
}
//设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //    return 10;
    //返回1代表1行
    return self.arrData.count;
}


#pragma mark - 创建cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MHStudentExperienceCell *cell = [tableView dequeueReusableCellWithIdentifier:experienceCellId forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [self setupModelOfCell:cell AtIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor whiteColor];

    return cell;
}
- (void)setupModelOfCell:(MHStudentExperienceCell *)cell AtIndexPath:(NSIndexPath *)indexPath{
    MHStudentExperienceModel *list = _arrData[indexPath.row];
    [cell setModel:list indexPath:indexPath];
}

//选中指定行 调用
//已经选中
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"你点击了%ld行",indexPath.row)
}

-(void)requstData{
  
    for (int idx = 0; idx < 4; idx ++) {
        MHStudentExperienceModel *model = [[MHStudentExperienceModel alloc]init];
        model.title = @"用户昵称";
        model.content = @"加入慕课教资交流备考群（QQ群号：1062660256） 免费领取高效备考资料，包含： 1. 福利专项课、公开课 2. 40+";
        model.remark = @"2020/09/07";
        [_arrData addObject:model];
    }

    
    [self.tableview reloadData];

}

@end



//**************店铺 客服 购买  按钮
@interface MHCourseVideoDetailToolView()

@end

@implementation MHCourseVideoDetailToolView

-(void)initControl{
    CGFloat space = AUTO(20);
    CGFloat wBtn = AUTO(60);
    NSArray *icons = @[@"p_shop",@"p_contact"];
    NSArray *titles = @[@"店铺",@"客服"];
    NSArray *tags = @[@"100",@"200"];
    for (int idx = 0; idx < titles.count; idx++) {
        UIView *view = [UIView hyb_viewWithSuperView:self constraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(space + wBtn*idx);
            make.top.and.bottom.mas_equalTo(0);
            make.width.mas_equalTo(wBtn);
        } onTaped:^(UITapGestureRecognizer *sender) {
            [self toolAction:sender];
        }];
        view.tag = [tags[idx] integerValue];
        
        UIImageView *iconV = [UIImageView hyb_imageViewWithSuperView:view constraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(AUTO(8));
            make.size.mas_equalTo(CGSizeMake(AUTO(20), AUTO(20)));
            make.centerX.equalTo(view);
        }];
        iconV.contentMode = UIViewContentModeScaleAspectFit;
        iconV.image = IMG(icons[idx]);
        
        UILabel *titleL = [UILabel hyb_labelWithFont:AUTO(12) superView:view constraints:^(MASConstraintMaker *make) {
            make.top.equalTo(iconV.mas_bottom).offset(AUTO(0));
            make.left.and.right.mas_equalTo(0);
            make.bottom.mas_equalTo(-AUTO(5));
        }];
        titleL.text = titles[idx];
        titleL.textAlignment = NSTextAlignmentCenter;
    }
    
    //购买按钮
    UIButton *buyBtn = [UIButton hyb_buttonWithSuperView:self constraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(wBtn*titles.count+2*space);
        make.right.mas_equalTo(-AUTO(10));
        make.top.mas_equalTo(AUTO(8));
        make.height.mas_equalTo(AUTO(36));
    } touchUp:^(UIButton *sender) {
        NoticeModel* model = [[NoticeModel alloc]init:sender.tag msg:nil data:nil];
        NSString* targer = @"MHCourseVideoDetailViewController";
        [[NSNotificationCenter defaultCenter] postNotificationName:targer object:nil userInfo:[model mj_keyValues]];
    }];
    buyBtn.tag = 300;
    buyBtn.backgroundColor = SK_COLOR_BASE_ORANGE;
    buyBtn.layer.cornerRadius = AUTO(20);
    [buyBtn setTitle:@"购买" forState:UIControlStateNormal];
    
}

//申请开店 课程订单  邀请好友
- (void)toolAction:(UITapGestureRecognizer *)sender
{
    NSInteger tag = [sender view].tag;
    NoticeModel* model = [[NoticeModel alloc]init:tag msg:nil data:nil];
    NSString* targer = @"MHCourseVideoDetailViewController";
    [[NSNotificationCenter defaultCenter] postNotificationName:targer object:nil userInfo:[model mj_keyValues]];
                
}


@end
