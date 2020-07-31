//
//  MHCousrsePlayViewController.m
//  App
//
//  Created by dayewang on 2020/7/10.
//  Copyright © 2020 李焕明. All rights reserved.
// 课程播放

#import "MHCousrsePlayViewController.h"
#import "MHStudentExperienceCell.h"
#import "MHStudentExperienceModel.h"
#import "MHCoursePlayView.h"
#import "MHPopContentView.h"
#import "MHAllCourseListView.h"
#import "MHCourseTableViewCell.h"

static NSString *cellId = @"MHStudentExperienceCell";
static NSString *listenCellId = @"MHCourseListeningListCell";

static NSString * headId = @"MHCoursePlayHeadTitleView";
@interface MHCousrsePlayViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property(nonatomic,strong)NSMutableArray *arrData;
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)MHCoursePlayView *headView;
@property(nonatomic,strong) MHPopContentView *commentView;

@end

@implementation MHCousrsePlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"课程播放";
    //    [self updateUI];
    self.view.backgroundColor = SK_COLOR_BASE_SEBACKGROUND;
    _arrData = [[NSMutableArray alloc]init];
    _headView = [[MHCoursePlayView alloc]initWithFrame:CGRectMake(0, 0, DEVICEWIDTH, AUTO(270))];
    [_headView setModel:@"" section:0];
    [self requstData];
    
}

-(void)updateUI{
    
    
}
//
- (UITableView *)tableview{
    if (!_tableview) {

            _tableview = [UITableView hyb_tableViewWithSuperview:self.view delegate:self style:UITableViewStyleGrouped constraints:^(MASConstraintMaker *make) {
            //            make.edges.mas_equalTo(self.view);
                        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
                    }];
        
        _tableview.backgroundColor = [UIColor whiteColor];
        _tableview.tableHeaderView = _headView;
        [_tableview registerClassNames: @[cellId,headId,listenCellId]];
        
        
    }
    return _tableview;
}

//设置cell 的行高
#pragma mark -UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return [tableView fd_heightForCellWithIdentifier:cellId cacheByIndexPath:indexPath configuration:^(id cell) {
//        [self setupModelOfCell:cell AtIndexPath:indexPath];
//    }];
    if (indexPath.section == 0) {
        return AUTO(100);
    }else{
        return AUTO(170);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return [tableView fd_heightForHeaderFooterViewWithIdentifier:headId configuration:^(id headerFooterView) {
//        [self setupModelOfHeadView:headerFooterView section:section];
//    }];
       return AUTO(50);
    
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    return [[UIView alloc]init];
//}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc]init];
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 0.01;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
//设置分区的个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //返回1代表1个分区
    return 2;
}
//设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //    return 10;
    //返回1代表1行
    if (section==0) {
        return 1;
    }else{
    return self.arrData.count;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
        MHCoursePlayHeadTitleView *headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headId];
        [self setupModelOfHeadView:headView section:section];
        return headView;
}


- (void)setupModelOfHeadView:(MHCoursePlayHeadTitleView *)headView section:(NSInteger)section{
    [headView setModel:@"" section:section];
}
#pragma mark - 创建cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        MHCourseListeningListCell *cell = [tableView dequeueReusableCellWithIdentifier:listenCellId forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupModelOfListenCell:cell AtIndexPath:indexPath];
        
        return cell;
    }else{
        MHStudentExperienceCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupModelOfCell:cell AtIndexPath:indexPath];
        cell.contentView.backgroundColor = [UIColor whiteColor];
        return cell;
    }
}
- (void)setupModelOfCell:(MHStudentExperienceCell *)cell AtIndexPath:(NSIndexPath *)indexPath{
    MHStudentExperienceModel *list = _arrData[indexPath.row];
    [cell setModel:list indexPath:indexPath];
}

- (void)setupModelOfListenCell:(MHCourseListeningListCell *)cell AtIndexPath:(NSIndexPath *)indexPath{

    [cell setModel:nil indexPath:indexPath];
}


//选中指定行 调用
//已经选中
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"你点击了%ld行",indexPath.row)
}


#pragma mark - notice
- (void)eventNotice:(NSNotification *)info
{
    NoticeModel *model = [NoticeModel mj_objectWithKeyValues:[info userInfo]];
    switch (model.code) {
//            查看全部课程
                case 100:
            {
                
                MHPopContentView *popView = [[MHPopContentView alloc]initWithHeight:DEVICEHEIGH*3/4 withRoundSize:CGSizeMake(10.0f, 10.0f)];
               
                popView.shouldClickClasses = @[@"MHCourseTableViewCell"];

                popView.titieL.text = @"课程列表";
                
                MHAllCourseListView *view = [[MHAllCourseListView alloc]initWithFrame:CGRectMake(0, 0, popView.contentV.width, popView.contentV.height)];
                [popView.contentV addSubview:view];

                [popView show];
                
            }
                break;
//            发布心得
                case 200:
            {
               
//                MHPopContentView *popView = [[MHPopContentView alloc]initWithHeight:AUTO(300) withRoundSize:CGSizeMake(0, 0)];
//
//                MHCourseCommentView *view = [[MHCourseCommentView alloc]initWithFrame:CGRectMake(0, AUTO(-20), popView.contentV.width, popView.contentV.height+AUTO(20))];
//                [popView.contentV addSubview:view];
//                [popView show];
//                self.commentView = popView;
                
                MHPopCourseCommentView *popView = [MHPopCourseCommentView new];
                [popView show];
                

                
                
            
            }
                break;
            
//            确认发布心得
                case 1000:
            {
               
               
                [self.commentView dismiss];
            
            }
                break;
            
            
                default:
                    break;
    }
            
}


#pragma mark - Net
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




