//
//  MHSettingViewController.m
//  App
//
//  Created by dayewang on 2020/7/2.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import "MHSettingViewController.h"
#import "MHSettingCell.h"
#import "MHAddressViewController.h"
#import "HomeTabViewController.h"
#import "MHOpenShopView.h"

static NSString *cellId = @"MHSettingCell";

@interface MHSettingViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property(nonatomic,strong)NSMutableArray *arrData;
@property(nonatomic,strong)UITableView *tableview;

@end

@implementation MHSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //    [self updateUI];
    _arrData = [[NSMutableArray alloc]init];
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
        UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEVICEWIDTH, AUTO(20))];
        _tableview.backgroundColor = HEXCOLOR(0x282525);
        _tableview.bounces = NO;
        _tableview.tableHeaderView = headView;
        [_tableview registerClassNames: @[cellId]];
        
        
    }
    return _tableview;
}

- (void)initTipsView{
     MHOpenShopView *tipsView = [[MHOpenShopView alloc]initWithFrame:CGRectMake(0, 0, DEVICEWIDTH-AUTO(60), DEVICEWIDTH+AUTO(40))];
     tipsView.backgroundColor = [UIColor whiteColor];
     
    [HWPopTool sharedInstance].shadeBackgroundType = ShadeBackgroundTypeGradient;
    [HWPopTool sharedInstance].closeButtonType = ButtonPositionTypeRight;
    [[HWPopTool sharedInstance] showWithPresentView:tipsView animated:YES];
}

- (void)pushOtherControllerWithIndex:(NSInteger )index{
    MHSettingModel *model = _arrData[index];
    [self.drawVC showRootVCAnimated:YES];
     id vc = self.drawVC.rootVC;
    HomeTabViewController *tabBarVC = (HomeTabViewController *)vc;
    NSArray *childs = tabBarVC.childViewControllers;
    if ([childs[tabBarVC.selectedIndex] isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController *)childs[tabBarVC.selectedIndex];
        UIViewController *childVC = nav.childViewControllers.firstObject;
        childVC.hidesBottomBarWhenPushed = YES;
        [nav pushViewController:[[NSClassFromString(model.className) alloc]init] animated:NO];
        childVC.hidesBottomBarWhenPushed = NO;
    }
}

//设置cell 的行高
#pragma mark -UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return [tableView fd_heightForCellWithIdentifier:cellId cacheByIndexPath:indexPath configuration:^(id cell) {
//        [self setupModelOfCell:cell AtIndexPath:indexPath];
//    }];
    return AUTO(60);
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
    MHSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [self setupModelOfCell:cell AtIndexPath:indexPath];
    
    return cell;
}
- (void)setupModelOfCell:(MHSettingCell *)cell AtIndexPath:(NSIndexPath *)indexPath{
    MHSettingModel *list = _arrData[indexPath.row];
    [cell setModel:list indexPath:indexPath];
}

//选中指定行 调用
//已经选中
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
//申请开店
        case 0:
        {
            [self initTipsView];
        }
            break;
//            我的课程
        case 1:{
            [self pushOtherControllerWithIndex:indexPath.row];
        }
           break;
//            我的订单
        case 2:
       {
           [self pushOtherControllerWithIndex:indexPath.row];
       }
           break;
//            邀请好友
       case 3:{
           TOAST(@"邀请好友");
       }
          break;
//            收货地址
        case 4:
       {
            [self pushOtherControllerWithIndex:indexPath.row];
       }
           break;
//            当前版本
       case 5:{
            TOAST(@"当前版本");
       }
          break;
        default:
            break;
    }
}

#pragma mark - notice
- (void)eventNotice:(NSNotification *)info
{
    NoticeModel *model = [NoticeModel mj_objectWithKeyValues:[info userInfo]];
    switch (model.code) {
            
        case 100:
        {
            
        }
            break;
//确定
        case 200:
        {
            TOAST(@"确定");
        }
            break;
            
        case 300:
            
        {
            
            
        }
            break;
            
        default:
            break;
    }
    
}


#pragma mark - Net
-(void)requstData{
    NSArray *title = @[@"申请开店",
                       @"我的课程",
                       @"我的订单",
                       @"邀请好友",
                        @"收货地址",
                       @"当前版本"
                        ];
    NSArray *iconS = @[@"p_shop01",
                    @"p_mycourse",
                    @"p_order",
                    @"p_human",
                     @"p_location",
                    @"p_version"
                     ];
    NSArray *classNames = @[@"",
                           @"MHMyCourseViewController",
                           @"MHMyOrderViewController",
                           @"",
                           @"MHAddressViewController",
                           @""];
    for (int idx = 0; idx < title.count; idx ++) {
          MHSettingModel *model = [[MHSettingModel alloc]init];
          model.title = title[idx];
        model.icon = iconS[idx];
        model.className = classNames[idx];
          [_arrData addObject:model];
    }

    
    [self.tableview reloadData];
    
}


@end
