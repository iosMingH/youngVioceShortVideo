//
//  MHRelationCourseController.m
//  App
//
//  Created by dayewang on 2020/7/28.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import "MHRelationCourseController.h"
#import "MHCourseModel.h"
#import "MHCourseTableViewCell.h"

static NSString *cellId = @"MHCourseTableViewCell";
@interface MHRelationCourseController ()<
UITableViewDelegate,
UITableViewDataSource
>
@property(nonatomic,strong)NSMutableArray *arrData;
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)UITextField *searchV;
@property(nonatomic,strong)UIButton *relationBtn; //不关联按钮


@end

@implementation MHRelationCourseController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = SK_COLOR_BASE_SEBACKGROUND;
    // Do any additional setup after loading the view.
    
//    [self addLeftButtonImage:@"p_wrong" Action:@selector(btnBack:)];
    _arrData = [[NSMutableArray alloc]init];
     
     [self requstData];
}

-(void)initView{
    [self init_UI_nav];
    
//    不关联课程
    UIButton *btn = [UIButton hyb_buttonWithTitle:@"不关联课程" superView:self.view constraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.mas_equalTo(0);
        make.height.mas_equalTo(AUTO(50));
    } touchUp:^(UIButton *sender) {
        [self dismissViewControllerAnimated:YES completion:^{}];
    }];
    btn.backgroundColor = HEXCOLOR(0x373434);
    btn.titleLabel.font = NFONT;
    self.relationBtn = btn;
}
- (void)init_UI_nav{
    UIButton *backBtn = [UIButton hyb_buttonWithImage:@"p_wrong" superView:self.view constraints:^(MASConstraintMaker *make) {
          make.left.mas_equalTo(SK_MARGINLR);
          make.top.mas_equalTo(AUTO(50));
          make.size.mas_equalTo(CGSizeMake(AUTO(15), AUTO(15)));
      } touchUp:^(UIButton *sender) {
          [self dismissViewControllerAnimated:YES completion:^{}];
      }];
      
      UITextField *textF = [UITextField hyb_textFieldWithHolder:@"搜索课程" superView:self.view constraints:^(MASConstraintMaker *make) {
          make.left.equalTo(backBtn.mas_right).offset(SK_MARGINLR);
          make.centerY.equalTo(backBtn.mas_centerY);
          make.right.mas_equalTo(-SK_MARGINLR);
          make.height.mas_equalTo(AUTO(40));
      }];
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"搜索课程" attributes:@{NSForegroundColorAttributeName:SK_COLOR_BASE_TEXT_GRAY,
        NSFontAttributeName:textF.font
    }];
    textF.attributedPlaceholder = attrString;
      textF.textColor = SK_COLOR_BASE_TITLEMAIN;
      textF.font = FONT(14);
      textF.backgroundColor = rgba(255, 255, 255, 0.07);
      textF.layer.cornerRadius = AUTO(20);
      UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, AUTO(40))];
      textF.leftViewMode = UITextFieldViewModeAlways;
      textF.leftView = leftView;
      textF.textAlignment = NSTextAlignmentCenter;
    self.searchV = textF;
}


- (UITableView *)tableview{
    if (!_tableview) {
        __weak typeof (self) weakSelf = self;
        _tableview = [UITableView hyb_tableViewWithSuperview:self.view delegate:self style:UITableViewStyleGrouped constraints:^(MASConstraintMaker *make) {
            make.left.and.right.mas_equalTo(0);
            make.top.equalTo(weakSelf.searchV.mas_bottom).offset(AUTO(10));
            make.bottom.equalTo(weakSelf.relationBtn.mas_top).offset(AUTO(0));
        }];
        _tableview.backgroundColor = SK_COLOR_BASE_SEBACKGROUND;
        [_tableview registerClassNames: @[cellId]];
    }
    return _tableview;
}

//设置cell 的行高
#pragma mark -UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return AUTO(100);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
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
       NSDictionary *back = @{@"test":@"123",@"hello":@"world"};
          if (self.Block) {
              self.Block(back);
          }
//      [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:^{}];
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
