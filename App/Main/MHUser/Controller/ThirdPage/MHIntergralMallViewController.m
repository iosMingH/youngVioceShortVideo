//
//  MHIntergralMallViewController.m
//  App
//
//  Created by dayewang on 2020/7/6.
//  Copyright © 2020 李焕明. All rights reserved.
// 积分商城

#import "MHIntergralMallViewController.h"

#import "MHIntergralMallModel.h"
#import "MHIntergralMallCell.h"
#import "MHCourseVideoDetailViewController.h"

static NSString *cellId = @"MHIntergralMallCell";
@interface MHIntergralMallViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property(nonatomic,strong)NSMutableArray *arrData;
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)MHIntergralMallHeadView *headView;
@property(nonatomic,strong)SearchView *searchV;
@end

@implementation MHIntergralMallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //    [self updateUI];
  
    _arrData = [[NSMutableArray alloc]init];

    self.title = @"积分商城";
//    //返回按钮
//    UIButton *backButton = [[UIButton alloc]init];
//    [backButton addTarget:self action:@selector(backButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
//    [backButton setImage:[UIImage imageNamed:@"p_arrow_left_selected"] forState:UIControlStateNormal];
////    [backButton sizeToFit];
//    backButton.contentMode = UIViewContentModeScaleAspectFit;
//     [backButton setImageEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
////    backButton.center = CGPointMake(15 + backButton.frame.size.width / 2, SafeTop + 22);
//    backButton.frame = CGRectMake(0, 0, AUTO(40), AUTO(40));
//
//    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
//    leftItem.imageInsets = UIEdgeInsetsMake(0, 10, 0, -10);
   
    UIButton *leftNavBtn =  [self addLeftButtonImage:@"p_arrow_left_selected" Action:@selector(backButtonTouched:)];
     leftNavBtn.contentMode = UIViewContentModeScaleAspectFit;
      leftNavBtn.frame = CGRectMake(0, 0, AUTO(40), AUTO(40));
    
    
    _searchV = [SearchView creatWithPlaceholder:@"输入课程关键字搜索" superView:self.view block:^(NSString *result) {
           NSLog(@"result=%@",result);
       }];
    _searchV.backgroundColor = [UIColor whiteColor];
    
    _headView = [[MHIntergralMallHeadView alloc]initWithFrame:CGRectMake(0, 50, DEVICEWIDTH, AUTO(180))];
    [self requstData];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
      self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];

}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
     [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
}

-(void)updateUI{
    
    
}
//
- (UITableView *)tableview{
    if (!_tableview) {
        _tableview = [UITableView hyb_tableViewWithSuperview:self.view delegate:self style:UITableViewStyleGrouped constraints:^(MASConstraintMaker *make) {
//            make.edges.mas_equalTo(self.view);
            make.edges.insets(UIEdgeInsetsMake(50, 0, 0, 0));
        }];
        _tableview.backgroundColor = SK_COLOR_BASE_BACKGROUND;
        _tableview.tableHeaderView = _headView;
        [_tableview registerClassNames: @[cellId]];
        
        
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
    return 0.01;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc]init];
}

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

#pragma mark - 创建cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MHIntergralMallCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [self setupModelOfCell:cell AtIndexPath:indexPath];
    
    return cell;
}
- (void)setupModelOfCell:(MHIntergralMallCell *)cell AtIndexPath:(NSIndexPath *)indexPath{
    MHIntergralMallModel *list = _arrData[indexPath.row];
    [cell setModel:list indexPath:indexPath];
}

//选中指定行 调用
//已经选中
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"你点击了%ld行",indexPath.row)
//    MHCourseVideoDetailViewController *vc = [[MHCourseVideoDetailViewController alloc]init];
//    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - aciton
- (void)backButtonTouched:(UIButton *)sender {

    [self.navigationController popViewControllerAnimated:YES];
}



-(void)requstData{
  
    for (int idx = 0; idx < 10; idx ++) {
        MHIntergralMallModel *model = [[MHIntergralMallModel alloc]init];
        model.title = @"六至12岁孩童逻辑思维培养课程";
        model.content = @"课程分类";
        model.remark = @"￥109";
        [_arrData addObject:model];
    }

    
    [self.tableview reloadData];

}


@end

