//
//  MHAddressViewController.m
//  App
//
//  Created by dayewang on 2020/7/2.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import "MHAddressViewController.h"
#import "MHAddressCell.h"
#import "MHAddressModel.h"
#import "MHAddAddressViewController.h"

static NSString *cellId = @"MHAddressCell";
@interface MHAddressViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property(nonatomic,strong)NSMutableArray *arrData;
@property(nonatomic,strong)UITableView *tableview;

@end

@implementation MHAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收货地址";
    //    [self updateUI];
    _arrData = [[NSMutableArray alloc]init];

                                                            
//    UIButton *editBtn = [self addNavRightBtnTitle:@"增加" action:@selector(btnEditAction:)];
    [self addRightButtonImage:@"p_add_001" Action:@selector(btnEditAction:)];
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
        _tableview.backgroundColor = SK_COLOR_BASE_SEBACKGROUND;
        [_tableview registerClassNames: @[cellId]];
        
        
    }
    return _tableview;
}

//设置cell 的行高
#pragma mark -UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return AUTO(90);
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
    MHAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [self setupModelOfCell:cell AtIndexPath:indexPath];
    
    return cell;
}
- (void)setupModelOfCell:(MHAddressCell *)cell AtIndexPath:(NSIndexPath *)indexPath{
    MHAddressModel *list = _arrData[indexPath.row];
    [cell setModel:list indexPath:indexPath];
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
    switch (model.code){
//更换手机号
            case 100:
          {
//              TOAST(@"更换手机号");
//              [self initChangePhoneTipsView];
              MHAddAddressViewController *VC = [[MHAddAddressViewController alloc]init];
              [self.navigationController pushViewController:VC animated:YES];
          }
                      break;
                default:
                    break;
    }
            
}

#pragma mark - Net
-(void)requstData{
    NSArray *title = @[@"王大炮",
                       @"老李子",@"黄三",@"王大炮",
                       @"老李子",@"黄三",@"王大炮",
                       @"老李子",@"黄三"];
    NSArray *remark = @[@"1232313123",
    @"13933434344",@"151230000000",@"1232313123",
    @"13933434344",@"151230000000",@"1232313123",
    @"13933434344",@"151230000000"];
    NSArray *contentL = @[@"王大炮的家",
    @"老李子的家",@"黄三的家",@"王大炮的家",
    @"老李子的家",@"黄三的家",@"王大炮的家",
    @"老李子的家",@"黄三的家"];
    for (int idx = 0; idx < title.count; idx ++) {
        MHAddressModel *model = [[MHAddressModel alloc]init];
        model.title = title[idx];
        model.remark = remark[idx];
        model.content = contentL[idx];
        [_arrData addObject:model];
    }
    
    
    [self.tableview reloadData];
    
}

- (void)btnEditAction:(UIButton *)pBtn
{
    MHAddAddressViewController *VC = [[MHAddAddressViewController alloc]init];
    [self.navigationController pushViewController:VC animated:YES];
}

@end
