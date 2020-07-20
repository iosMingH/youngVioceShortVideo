//
//  MHCommomCourseViewController.m
//  App
//
//  Created by dayewang on 2020/7/8.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import "MHCommomCourseViewController.h"
#import "MHCourseModel.h"
#import "MHCourseTableViewCell.h"
#import "MHCourseHeadView.h"
#import "MHCourseVideoDetailViewController.h"

static NSString *cellId = @"MHCourseTableViewCell";
static NSString * headId = @"MHCourseTitleView";
@interface MHCommomCourseViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property(nonatomic,strong)NSMutableArray *arrData;
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)MHCourseHeadView *headView;


@end

@implementation MHCommomCourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //    [self updateUI];
    _arrData = [[NSMutableArray alloc]init];
//    self.view.backgroundColor = [UIColor blackColor];
    _headView = [[MHCourseHeadView alloc]initWithFrame:CGRectMake(0, 0, DEVICEWIDTH, AUTO(200))];
    [self requstData];
}

-(void)updateUI{
    
    
}
//
- (UITableView *)tableview{
    if (!_tableview) {
        _tableview = [UITableView hyb_tableViewWithSuperview:self.view delegate:self style:UITableViewStyleGrouped constraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.view);
        }];
        _tableview.backgroundColor = [UIColor blackColor];
        _tableview.tableHeaderView = _headView;
        [_tableview registerClassNames: @[cellId,headId]];
        
        
    }
    return _tableview;
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
        return AUTO(250);
    
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
    MHCourseTitleView *headView1 = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headId];
    [self setupModelOfHeadView:headView1 section:section];
    return headView1;

}


- (void)setupModelOfHeadView:(MHCourseTitleView *)headView section:(NSInteger)section{
//     [headView setModel:nil section:section];
}
#pragma mark - 创建cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MHCourseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [self setupModelOfCell:cell AtIndexPath:indexPath];
    cell.titleL.textColor = SK_COLOR_BASE_TITLEMAIN;
       cell.contentL.textColor = SK_COLOR_BASE_TITLELESS;
       cell.remarkL.textColor = SK_COLOR_BASE_TEXT_YELLOW;
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
    NSLog(@"你点击了%ld行",indexPath.row)
    MHCourseVideoDetailViewController *vc = [[MHCourseVideoDetailViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
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
