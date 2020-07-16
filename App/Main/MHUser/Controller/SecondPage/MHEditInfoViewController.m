//
//  MHEditInfoViewController.m
//  App
//
//  Created by dayewang on 2020/7/1.
//  Copyright © 2020 李焕明. All rights reserved.
// 编辑资料

#import "MHEditInfoViewController.h"
#import "MHEditInfoCell.h"
#import "takePhoto.h"
#import "MHEditTipsView.h"
#define HEIGHT_HEAD   AUTO(160)
#define HEIGHT_CELL   AUTO(49)
#define TABLE_SECETION_HEIGHT AUTO(10)
@interface MHEditInfoViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    BOOL _isEdit;
}
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataList;
@property(nonatomic,strong)UIView *mHeaderView;
@property(nonatomic,strong)UIView *mFooterView;
@property(nonatomic,strong)UIImageView *headerI;
@property(nonatomic,strong)UIButton *photoBtn;
@property(nonatomic,strong)UITextField *infoT;

@end

@implementation MHEditInfoViewController

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
    NSArray *titles = @[@"昵称",@"手机号码",@"个人简介"];
    NSArray *contents = @[@"杜月笙",@"15304053560",@"0/120"];
    for (int idx = 0; idx < titles.count; idx++) {
        MHEditInfoModel *model = [[MHEditInfoModel alloc]init];
        model.title = titles[idx];
        model.content = contents[idx];
        [_dataList addObject:model];
    }
}


- (void)initView
{
    [self initData];
    self.title = @"个人信息";
    UIButton *editBtn = [self addNavRightBtnTitle:@"编辑" action:@selector(btnEditAction:)];
    [editBtn setTitle:@"保存" forState:UIControlStateSelected];
    self.view.backgroundColor = SK_COLOR_BASE_SEBACKGROUND;
//    self.mHeaderView = [[UIView alloc] init];
    self.mHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEVICEWIDTH, HEIGHT_HEAD)];
    [self.view addSubview:self.mHeaderView];
    self.mFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEVICEWIDTH, HEIGHT_HEAD)];
    [self.view addSubview:self.mFooterView];
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.mHeaderView;
    self.tableView.tableFooterView = self.mFooterView;
    [self initHeaderView];
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

- (void)initHeaderView
{

    __weak typeof(self) wkThis = self;
    CGFloat heightH = AUTO(90);
    self.headerI = [[UIImageView alloc] init];
    [self.mHeaderView addSubview:self.headerI];
    [self.headerI mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(AUTO(20));
        make.centerX.mas_equalTo(wkThis.mHeaderView);
        make.size.mas_equalTo(CGSizeMake(heightH, heightH));
    }];
    self.headerI.userInteractionEnabled = YES;
    self.headerI.clipsToBounds = YES;
    self.headerI.layer.cornerRadius = heightH*0.5;
    self.headerI.backgroundColor = [UIColor grayColor];
    
    self.photoBtn = [[UIButton alloc]init];
    [self.headerI addSubview:self.photoBtn];
    [self.photoBtn addTarget:self action:@selector(btnPhotoTarget) forControlEvents:UIControlEventTouchUpInside];
    [self.photoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(wkThis.headerI);
    }];
    self.photoBtn.userInteractionEnabled = NO;
    
    UILabel *remarkL = [UILabel hyb_labelWithFont:AUTO(13) superView:self.mHeaderView constraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(wkThis.headerI.mas_bottom).offset(AUTO(10));
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(20);
    }];
    remarkL.textColor = SK_COLOR_BASE_TITLEMAIN;
    remarkL.textAlignment = NSTextAlignmentCenter;
    remarkL.text = @"点击更换头像";
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
    textT.textContainerInset = UIEdgeInsetsMake(8, 8, 0, 8);
    
}

- (void)initTipsView{
    MHEditTipsView *tipsView = [[MHEditTipsView alloc]initWithFrame:CGRectMake(0, 0, DEVICEWIDTH-100, 150)];
    tipsView.backgroundColor = [UIColor whiteColor];

    [tipsView setModel:@"15102323233"];
    
    [HWPopTool sharedInstance].shadeBackgroundType = ShadeBackgroundTypeGradient;
       [HWPopTool sharedInstance].closeButtonType = ButtonPositionTypeRight;
       [[HWPopTool sharedInstance] showWithPresentView:tipsView animated:NO];
    
}

- (void)initChangePhoneTipsView{
    UIView *tipsView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEVICEWIDTH-100, 300)];
    tipsView.backgroundColor = [UIColor whiteColor];
    tipsView.layer.cornerRadius = AUTO(5);
    
    [HWPopTool sharedInstance].shadeBackgroundType = ShadeBackgroundTypeGradient;
    [HWPopTool sharedInstance].closeButtonType = ButtonPositionTypeRight;
    [[HWPopTool sharedInstance] showWithPresentView:tipsView animated:NO];
}

#pragma mark - tableView 数据源方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MHEditInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MHEditInfoCell"];
    if (!cell) {
        cell = [[MHEditInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MHEditInfoCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
 
    MHEditInfoModel *model = [_dataList objectAtIndex: indexPath.row];
    cell.model = model;
    if (_isEdit && indexPath.row == 0) {
        cell.contentT.userInteractionEnabled = YES;
    }else{
        cell.contentT.userInteractionEnabled = NO;
    }
//    if ( indexPath.section !=_dataList.count-1) {
//            UIView *vLine = [[UIView alloc]init];
//            [cell.contentView addSubview:vLine];
//            vLine.backgroundColor =SK_COLOR_BASE_LINE;
//
//            [vLine mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.left.mas_equalTo(SK_MARGIN);
//                make.right.mas_equalTo(-SK_MARGIN);
//                make.bottom.mas_equalTo(0);
//                make.height.mas_equalTo(AUTO(1));
//            }];
//    }
    
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
    if (_isEdit && indexPath.row != 0) {
//        [self initTipsView];
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
            case 200:
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
        
    }else{
        _isEdit = NO;
        [self.navigationController popViewControllerAnimated:YES];
        [FUPROGRESS_HUD success:@"个人信息修改成功"];
        self.photoBtn.userInteractionEnabled = NO;
    }
    [self.tableView reloadData];
}

- (void)btnPhotoTarget
{
    [takePhoto chooseViewController:self sharePicture:^(UIImage *image) {
        self.headerI.image = image;
    }];
}
@end

