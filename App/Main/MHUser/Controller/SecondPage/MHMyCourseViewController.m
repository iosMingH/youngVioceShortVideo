//
//  MHMyCourseViewController.m
//  App
//
//  Created by dayewang on 2020/7/6.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import "MHMyCourseViewController.h"
#import "MHMyCourseModel.h"
#import "MHMyCourseCell.h"
#import "MHCourseVideoDetailViewController.h"


static NSString *cellId = @"MHMyCourseCell";
static NSString * headId = @"MHMyCourseTitleView";
@interface MHMyCourseViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property(nonatomic,strong)NSMutableArray *arrData;
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)SearchView *searchV;

@end

@implementation MHMyCourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //    [self updateUI];
    _arrData = [[NSMutableArray alloc]init];
//    self.view.backgroundColor = [UIColor blackColor];
    self.title = @"我的课程";
    _searchV = [SearchView creatWithPlaceholder:@"输入课程关键字搜索" superView:self.view block:^(NSString *result) {
              NSLog(@"result=%@",result);
          }];
    [self requstData];
}

-(void)updateUI{
    
    
}
//
- (UITableView *)tableview{
    if (!_tableview) {
        _tableview = [UITableView hyb_tableViewWithSuperview:self.view delegate:self style:UITableViewStyleGrouped constraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsMake(50, 0, 0, 0));
        }];
        _tableview.backgroundColor = SK_COLOR_BASE_SEBACKGROUND;
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
    
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return [tableView fd_heightForHeaderFooterViewWithIdentifier:headId configuration:^(id headerFooterView) {
//        [self setupModelOfHeadView:headerFooterView section:section];
//    }];
        return 80;
    
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
    MHMyCourseTitleView *headView1 = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headId];
    [self setupModelOfHeadView:headView1 section:section];
    return headView1;

}


- (void)setupModelOfHeadView:(MHMyCourseTitleView *)headView section:(NSInteger)section{
//     [headView setModel:nil section:section];
}
#pragma mark - 创建cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MHMyCourseCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [self setupModelOfCell:cell AtIndexPath:indexPath];
    cell.contentView.backgroundColor = SK_COLOR_BASE_SEBACKGROUND;
    return cell;
}
- (void)setupModelOfCell:(MHMyCourseCell *)cell AtIndexPath:(NSIndexPath *)indexPath{
    MHMyCourseModel *list = _arrData[indexPath.row];
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

#pragma mark - notice
- (void)eventNotice:(NSNotification *)info
{
    NoticeModel *model = [NoticeModel mj_objectWithKeyValues:[info userInfo]];
    switch (model.code) {
//           热门排序
        case 100:
        {
            TOAST(@"热门排序");
        }
            break;
//           价格排序
        case 200:
        {
            TOAST(@" 价格排序");
        }
            break;
            
//            从新到旧
        case 300:
            
        {
            
             TOAST(@"从新到旧");
        }
            break;
//            价格排序
        case 400:
                   
       {
           
            TOAST(@"价格排序11");
       }
           break;
            
        default:
            break;
    }
    
}


-(void)requstData{
  
    for (int idx = 0; idx < 10; idx ++) {
        MHMyCourseModel *model = [[MHMyCourseModel alloc]init];
        model.title = @"六至12岁孩童逻辑思维培养课程";
        model.content = @"课程分类";
        model.remark = @"￥109";
        [_arrData addObject:model];
    }

    
    [self.tableview reloadData];

}


@end
