//
//  MHMyOrderDetailViewController.m
//  App
//
//  Created by dayewang on 2020/7/14.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import "MHMyOrderDetailViewController.h"
#import "MHMyOrderDetailCell.h"
#import "MHMyOrderDetailModel.h"

static NSString *cellId = @"MHMyOrderDetailCell";
static NSString *cellId1 = @"MHMyOrderDetailInfoCell";

static NSString * headId = @"MHMyOrderDetailTitleHeadView";
@interface MHMyOrderDetailViewController ()<
UITableViewDelegate,
UITableViewDataSource
>
@property(nonatomic,strong)NSMutableArray *arrData;
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)NSMutableArray *arrOrderData;
@end

@implementation MHMyOrderDetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"订单详情";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    //返回按钮
     [self addLeftButtonImage:@"p_arrow_left_selected" Action:@selector(backButtonTouched:)];
    
    _arrData = [[NSMutableArray alloc]init];
    _arrOrderData = [[NSMutableArray alloc]init];
     [self requstData];
}


- (void)initView{
    

    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
      self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
//    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
  
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    self.navigationController.navigationBar.barTintColor = SK_COLOR_BASE_SEBACKGROUND;

}

#pragma mark - aciton
- (void)backButtonTouched:(UIButton *)sender {

    [self.navigationController popViewControllerAnimated:YES];
}

- (UITableView *)tableview{
    if (!_tableview) {
        _tableview = [UITableView hyb_tableViewWithSuperview:self.view delegate:self style:UITableViewStyleGrouped constraints:^(MASConstraintMaker *make) {
//            make.edges.mas_equalTo(self.view);
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        _tableview.backgroundColor = SK_COLOR_BASE_BACKGROUND;

        [_tableview registerClassNames: @[cellId,headId,cellId1]];
        
        
    }
    return _tableview;
}

//设置cell 的行高
#pragma mark -UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        return AUTO(100);
    }else{
        return AUTO(50);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

       if (section == 0) {
           return AUTO(50);
       }else{
           return AUTO(0.01);
       }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc]init];
}

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
      return  self.arrData.count;
    }else{
        return self.arrOrderData.count;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section==0) {
        MHMyOrderDetailTitleHeadView *headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headId];
               [self setupModelOfHeadView:headView section:section];
               return headView;
    }else{
         return [[UIView alloc]init];
    }
}


- (void)setupModelOfHeadView:(MHMyOrderDetailTitleHeadView *)headView section:(NSInteger)section{
    [headView setModel:@"" section:section];
}
#pragma mark - 创建cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        MHMyOrderDetailInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId1 forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        MHMyOrderDetailInfoModel *list = _arrData[indexPath.row];
           [cell setModel:list indexPath:indexPath];
        
        return cell;
    }else{
        MHMyOrderDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        MHMyOrderDetailModel *list = _arrOrderData[indexPath.row];
        [cell setModel:list indexPath:indexPath];
        cell.contentView.backgroundColor = [UIColor whiteColor];
        
        return cell;
    }
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
                case 100:
            {
                

            }

                case 200:
            {
               
            
            
            }
                break;

            
            
                default:
                    break;
    }
            
}


#pragma mark - Net
-(void)requstData{
  
    for (int idx = 0; idx < 1; idx ++) {
        MHMyOrderDetailInfoModel *model = [[MHMyOrderDetailInfoModel alloc]init];
        model.title = @"教师资格“从小到大”你的认知都 发生了怎样的变化？";
        model.content = @"商品种类";
        model.remark = @"商品数量";
        [_arrData addObject:model];
    }

    
    NSArray *contents = @[@"待付款",@"2020/07/01 16:30",@"2020/07/01 16:31",@"￥233",@"￥199"];
    for (int idx = 0; idx<contents.count; idx++) {
        MHMyOrderDetailModel *model = [[MHMyOrderDetailModel alloc]init];
        model.content = contents[idx];
        [_arrOrderData addObject:model];
    }

    
    [self.tableview reloadData];

}



@end

