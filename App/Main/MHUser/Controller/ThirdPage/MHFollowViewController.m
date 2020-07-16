//
//  MHFollowViewController.m
//  App
//
//  Created by Pro on 2020/6/30.
//  Copyright © 2020 李焕明. All rights reserved.
//


#import "MHFollowViewController.h"
#import "MHFollowTableViewCell.h"
#import "MHFollowModel.h"

static NSString *cellId = @"MHFollowTableViewCell";

@interface MHFollowViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property(nonatomic,strong)NSMutableArray *arrData;
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)UIView *headView;

@property(nonatomic,strong)SearchView *searchV;
@end

@implementation MHFollowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateUI];
    _arrData = [[NSMutableArray alloc]init];
    [self requstData];
}

-(void)updateUI{
    
    _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEVICEWIDTH, 50)];
    _searchV = [SearchView creatWithPlaceholder:@"输入课程关键字搜索" superView:_headView block:^(NSString *result) {
        NSLog(@"result=%@",result);
    }];
    
}
//
- (UITableView *)tableview{
    if (!_tableview) {
        _tableview = [UITableView hyb_tableViewWithSuperview:self.view delegate:self style:UITableViewStyleGrouped constraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.view);
        }];
        _tableview.backgroundColor = SK_COLOR_BASE_SEBACKGROUND;
        [_tableview registerClassNames: @[cellId]];
        _tableview.tableHeaderView = _headView;
        
    }
    return _tableview;
}

//设置cell 的行高
#pragma mark -UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return [tableView fd_heightForCellWithIdentifier:cellId cacheByIndexPath:indexPath configuration:^(id cell) {
//        [self setupModelOfCell:cell AtIndexPath:indexPath];
//    }];
    return AUTO(80);
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return [tableView fd_heightForHeaderFooterViewWithIdentifier:headId configuration:^(id headerFooterView) {
//        [self setupModelOfHeadView:headerFooterView section:section];
//    }];
    //    return 500;
    
//}

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

//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    <#headview#> *headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headId];
//    [self setupModelOfHeadView:headView section:section];
//    return headView;
//
//}
//
//
//- (void)setupModelOfHeadView:(<#headview#> *)headView section:(NSInteger)section{
//    [headView setModel:nil section:section];
//}
#pragma mark - 创建cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MHFollowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = SK_COLOR_BASE_SEBACKGROUND;
    [self setupModelOfCell:cell AtIndexPath:indexPath];
    
    return cell;
}
- (void)setupModelOfCell:(MHFollowTableViewCell *)cell AtIndexPath:(NSIndexPath *)indexPath{
    MHFollowModel *list = _arrData[indexPath.row];
    [cell setModel:list indexPath:indexPath];
}

//选中指定行 调用
//已经选中
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"你点击了%ld行",indexPath.row)
}


#pragma mark - Net
-(void)requstData{
    NSArray *title = @[@"西游记",
                       @"黄大师",
                       @"老董",
                       @"老生"];
    for (int idx = 0; idx < title.count; idx ++) {
        MHFollowModel *model = [[MHFollowModel alloc]init];
        model.title = title[idx];
        [_arrData addObject:model];
    }
    
    
    [self.tableview reloadData];
    
}



@end
