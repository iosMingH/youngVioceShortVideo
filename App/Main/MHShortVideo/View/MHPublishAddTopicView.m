//
//  MHPublishAddTopicView.m
//  App
//
//  Created by dayewang on 2020/7/28.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import "MHPublishAddTopicView.h"
#import "MHPublishAddTopicCell.h"
#import "MHPublishAddTopicModel.h"

static NSString *cellId = @"MHPublishAddTopicCell";

@interface MHPublishAddTopicView ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property(nonatomic,strong)NSMutableArray *arrData;
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)UIView *bottomV;

@end

@implementation MHPublishAddTopicView

-(void)initData{
    _arrData = [[NSMutableArray alloc]init];
      [self requstData];
    

    
}
- (void)initControl{
    UILabel *titleL = [UILabel hyb_labelWithText:@"添加话题" font:AUTO(13) superView:self constraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.mas_equalTo(0);
        make.height.mas_equalTo(AUTO(40));
    }];
    titleL.textColor = SK_COLOR_BASE_TEXT_GRAY;
    titleL.textAlignment = NSTextAlignmentCenter;

    
    UITextField *textF = [UITextField hyb_textFieldWithHolder:@"# 输入话题" superView:self constraints:^(MASConstraintMaker *make) {
         make.top.mas_equalTo(titleL.mas_bottom);
        make.left.mas_equalTo(SK_MARGINLR);
        make.right.mas_equalTo(-SK_MARGINLR);
        make.height.mas_equalTo(AUTO(40));
    }];
    textF.font = FONT(AUTO(14));
    textF.layer.cornerRadius = AUTO(20);
    textF.backgroundColor = HEXCOLOR(0xF7F7F7);
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, AUTO(40))];
    textF.leftViewMode = UITextFieldViewModeAlways;
    textF.leftView = leftView;
    
//    __weak typeof(self) weakSelf = self;
    _tableview = [UITableView hyb_tableViewWithSuperview:self delegate:self style:UITableViewStyleGrouped constraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(0);
        make.top.equalTo(textF.mas_bottom).offset(AUTO(10));
        make.bottom.mas_equalTo(-AUTO(40));
    }];
    _tableview.backgroundColor = [UIColor whiteColor];
    [_tableview registerClassNames: @[cellId]];
    
    [self init_UI_bottomView];
}

//确定
- (void)init_UI_bottomView{
    
    CGFloat viewH = AUTO(40);
    
    self.bottomV = [UIView hyb_viewWithSuperView:self constraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(viewH);
        make.bottom.mas_equalTo(0);
    }];
    
    [UIView hyb_addTopLineToView:self.bottomV height:1 color:SK_COLOR_BASE_LINE];
    
    [self.bottomV layoutIfNeeded];
    
    NSArray *titles = @[@"取消",@"确定"];
    NSArray *tags = @[@"300",@"400"];
    CGFloat btnW = self.bottomV.width/titles.count;
    for (int i = 0; i < titles.count; i++) {
        
        UIButton *btn = [UIButton hyb_buttonWithSuperView:self.bottomV constraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(btnW*i);
            make.top.and.bottom.mas_equalTo(0);
            make.width.mas_equalTo(btnW);
        } touchUp:^(UIButton *sender) {
            [self infoAction:sender];
        }];
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        [btn setTitleColor:SK_COLOR_BASE_TEXT_GRAY forState:UIControlStateNormal];
        btn.titleLabel.font = FONT(AUTO(14));
        btn.tag = [tags[i] integerValue];
        if (i == 1) {
             [btn setTitleColor:SK_COLOR_BASE_TEXT_ORANGE forState:UIControlStateNormal];
        }
        
    }
    

}

//设置cell 的行高
#pragma mark -UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [tableView fd_heightForCellWithIdentifier:cellId cacheByIndexPath:indexPath configuration:^(id cell) {
        [self setupModelOfCell:cell AtIndexPath:indexPath];
    }];
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
    MHPublishAddTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [self setupModelOfCell:cell AtIndexPath:indexPath];
    
    return cell;
}
- (void)setupModelOfCell:(MHPublishAddTopicCell *)cell AtIndexPath:(NSIndexPath *)indexPath{
    MHPublishAddTopicModel *list = _arrData[indexPath.row];
    [cell setModel:list indexPath:indexPath];
}

//选中指定行 调用
//已经选中
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"你点击了%ld行",indexPath.row);
    MHPublishAddTopicModel *tModel = _arrData[indexPath.row];

     [[HWPopTool sharedInstance] closeWithBlcok:nil];
    NSInteger tag = 1000;
    NoticeModel* model = [[NoticeModel alloc]init:tag msg:nil data:tModel];
    NSString* targer = @"MHPublishVideoViewControl";
    [[NSNotificationCenter defaultCenter] postNotificationName:targer object:nil userInfo:[model mj_keyValues]];
}

#pragma mark - action
//关注 粉丝 获赞 积分
- (void)infoAction:(UIButton *)sender
{
    NSInteger tag = sender.tag;
    [[HWPopTool sharedInstance] closeWithBlcok:nil];
    if (tag == 400) {
          NoticeModel* model = [[NoticeModel alloc]init:tag msg:nil data:nil];
          NSString* targer = @"MHPublishVideoViewControl";
          [[NSNotificationCenter defaultCenter] postNotificationName:targer object:nil userInfo:[model mj_keyValues]];
    }
  
                
}

#pragma mark - Net
-(void)requstData{
    for (int idx = 0; idx < 10; idx ++) {
        MHPublishAddTopicModel *model = [[MHPublishAddTopicModel alloc]init];
        model.title = [NSString stringWithFormat:@"#话题%d",idx];
        [_arrData addObject:model];
    }
    
    [self.tableview reloadData];
    
}

@end
