//
//  MHAddAddressViewController.m
//  App
//
//  Created by dayewang on 2020/7/3.
//  Copyright © 2020 李焕明. All rights reserved.
// 新建收货地址

#import "MHAddAddressViewController.h"
#import "MHAddAddressCell.h"
#import "takePhoto.h"
#import "MHEditTipsView.h"
#import "MHAddAddressModel.h"
#import "CGXPickerView.h"

#define HEIGHT_HEAD   AUTO(160)
#define HEIGHT_CELL   AUTO(49)
#define TABLE_SECETION_HEIGHT AUTO(10)
@interface MHAddAddressViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    BOOL _isEdit;
}
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataList;
@property(nonatomic,strong)UIView *mHeaderView;
@property(nonatomic,strong)UIView *mFooterView;
@property(nonatomic,strong)UIImageView *headerI;
@property(nonatomic,strong)UIButton *photoBtn;
@property(nonatomic,strong)UITextView *infoT;
@property (nonatomic, copy) NSString *address;


@end

@implementation MHAddAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initData
{
    _isEdit = NO;
    _dataList = [[NSMutableArray alloc]init];
    NSArray *titles = @[@"收货人",@"手机号码",@"省市区",@"详细地址"];
    NSArray *contents = @[@"填写收货人姓名",@"填写收货人手机号",@"选择省市区",@""];
    for (int idx = 0; idx < titles.count; idx++) {
        MHAddAddressModel *model = [[MHAddAddressModel alloc]init];
        model.title = titles[idx];
        model.content = contents[idx];
        [_dataList addObject:model];
    }
}


- (void)initView
{
    [self initData];
    self.title = @"新建收货地址";
    UIButton *editBtn = [self addNavRightBtnTitle:@"编辑" action:@selector(btnEditAction:)];
    
    [editBtn setTitle:@"保存" forState:UIControlStateSelected];
//    [self addNavRightBtn:@"" image:@"" action:@selector(btnEditAction:)];
    self.view.backgroundColor = SK_COLOR_BASE_SEBACKGROUND;

    self.mFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEVICEWIDTH, HEIGHT_HEAD)];
    [self.view addSubview:self.mFooterView];
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = self.mFooterView;
    [self initFooterView];
}

- (void)initLayout
{
//    __weak typeof(self)  wkThis = self;
        UIView *superview = self.view;
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.edges.equalTo(superview);
    }];

}

- (void)initFooterView{
    UITextView *textT = [UITextView hyb_viewWithSuperView:self.mFooterView constraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(AUTO(10));
        make.right.mas_equalTo(-AUTO(10));
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(AUTO(120));
    }];
    textT.font = TFONT;
    textT.textColor = SK_COLOR_BASE_TITLEMAIN;
    textT.backgroundColor = SK_COLOR_BASE_TRANSPARENT;
//    textT.placeholder = @"请填写你的详细收货地址";
    textT.textContainerInset = UIEdgeInsetsMake(8, 8, 0, 8);
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"请填写你的详细收货地址" attributes:@{NSForegroundColorAttributeName:SK_COLOR_BASE_TEXT_GRAY,
           NSFontAttributeName:textT.font
       }];
    textT.attributedPlaceholder = attrString;
    textT.userInteractionEnabled = NO;
    self.infoT = textT;
    
}

#pragma mark - tableView 数据源方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MHAddAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MHEditInfoCell"];
    if (!cell) {
        cell = [[MHAddAddressCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MHEditInfoCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
 
    MHAddAddressModel *model = [_dataList objectAtIndex: indexPath.row];
    cell.model = model;
    
    switch (indexPath.row) {
        case 0:
        {
             cell.contentT.userInteractionEnabled = YES;
        }
            break;
        case 1:
       {
            cell.contentT.userInteractionEnabled = YES;
           cell.contentT.keyboardType = UIKeyboardTypeNumberPad;
       }
           break;
        case 2:
       {
           cell.contentT.userInteractionEnabled = NO;
           cell.contentT.text = self.address;
       }
           break;
        case 3:
       {
           cell.contentT.userInteractionEnabled = NO;
       }
           break;
        default:
            break;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return HEIGHT_CELL;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEVICEWIDTH, HEIGHT_CELL)];
    view.backgroundColor = SK_COLOR_BASE_SEBACKGROUND;
    return view;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return TABLE_SECETION_HEIGHT;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isEdit && indexPath.row == 2 ) {
//        [self initTipsView];
        NSLog(@"弹出省市区");
        
        [CGXPickerView showAddressPickerWithTitle:@"请选择你的城市" DefaultSelected:@[@4, @0,@0] IsAutoSelect:NO Manager:nil ResultBlock:^(NSArray *selectAddressArr, NSArray *selectAddressRow) {
            NSLog(@"%@-%@",selectAddressArr,selectAddressRow);
            self.address = [NSString stringWithFormat:@"%@%@%@", selectAddressArr[0], selectAddressArr[1],selectAddressArr[2]];
            [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:2 inSection:0], nil] withRowAnimation:UITableViewRowAnimationNone];
            
        }];
       }
   
}

#pragma lazy ctrl

-(UITableView *)tableView
{
    if (!_tableView) {
        //        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.bounces = NO;
        _tableView.backgroundColor = SK_COLOR_BASE_SEBACKGROUND;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
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
          }
                      break;
                default:
                    break;
    }
            
}


#pragma mark - btnAction
//编辑")
- (void)btnEditAction:(UIButton *)pBtn
{
    pBtn.selected = !pBtn.selected;
    if (pBtn.selected) {
        _isEdit = YES;
        self.photoBtn.userInteractionEnabled = YES;
        self.infoT.userInteractionEnabled = YES;
        
    }else{
        _isEdit = NO;
        [self.navigationController popViewControllerAnimated:YES];
        [FUPROGRESS_HUD success:@"新建收货地址"];
        self.photoBtn.userInteractionEnabled = NO;
        self.infoT.userInteractionEnabled = NO;
    }
    [self.tableView reloadData];
}

@end

