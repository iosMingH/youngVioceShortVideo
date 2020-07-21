//
//  MHMyOrderView.m
//  App
//
//  Created by dayewang on 2020/7/8.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import "MHMyOrderView.h"
#import "MHCourseModel.h"
#import "MHCourseTableViewCell.h"
#import "MHCourseVideoDetailViewController.h"

static NSString *cellId = @"MHCourseTableViewCell";

@interface MHMyOrderView ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray *arrData;
@property(nonatomic,strong)UITableView *tableview;
@end

@implementation MHMyOrderView

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
                  _tableview.backgroundColor = SK_COLOR_BASE_SEBACKGROUND;
                  [_tableview registerClassNames: @[cellId]];
}


//设置cell 的行高
#pragma mark -UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return [tableView fd_heightForCellWithIdentifier:cellId cacheByIndexPath:indexPath configuration:^(id cell) {
//        [self setupModelOfCell:cell AtIndexPath:indexPath];
//    }];
    
    return 100;
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
    cell.contentView.backgroundColor = SK_COLOR_BASE_SEBACKGROUND;
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
}

-(void)requstData{
  
    for (int idx = 0; idx < 4; idx ++) {
        MHCourseModel *model = [[MHCourseModel alloc]init];
        model.title = @"六至12岁孩童逻辑思维培养课程";
        model.content = @"1500积分";
        model.remark = @"待收货";
        [_arrData addObject:model];
    }

    
    [self.tableview reloadData];

}

@end

