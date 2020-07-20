//
//  MHAllCourseListView.m
//  App
//
//  Created by dayewang on 2020/7/13.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import "MHAllCourseListView.h"

#import "MHCourseTableViewCell.h"
#import "MHCourseModel.h"

static NSString *cellId = @"MHCourseTableViewCell";

@interface MHAllCourseListView ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property(nonatomic,strong)NSMutableArray *arrData;
@property(nonatomic,strong)UITableView *tableview;

@end

@implementation MHAllCourseListView


- (void)initControl{
    _arrData = [[NSMutableArray alloc]init];
    [self tableview];
      [self requstData];
}


-(void)updateUI{
    
    
}
//
- (UITableView *)tableview{
    if (!_tableview) {
        _tableview = [UITableView hyb_tableViewWithSuperview:self delegate:self style:UITableViewStyleGrouped constraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self);
        }];
        _tableview.backgroundColor = [UIColor whiteColor];
        [_tableview registerClassNames: @[cellId]];
        
        
    }
    return _tableview;
}

//设置cell 的行高
#pragma mark -UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return AUTO(100);
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
    cell.contentView.backgroundColor = [UIColor whiteColor];
    cell.titleL.textColor = [UIColor blackColor];
    cell.contentL.textColor = SK_COLOR_BASE_TEXT_GRAY;
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


#pragma mark - Net
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




//***********评论弹出框
@interface MHPopCourseCommentView ()

@property (nonatomic,strong) UIWindow* window;
@property(nonatomic,strong)UITextView *textView;
@end

@implementation MHPopCourseCommentView

-(void)loadUI{
    
          _window = [UIApplication sharedApplication].keyWindow;
          
          _navPopViw = [[UIButton alloc]initWithFrame:_window.bounds];
          _navPopViw.backgroundColor = RGBACOLOR(0, 0, 0, 0.2);
          [_window addSubview:_navPopViw];
          [_navPopViw addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
          [_navPopViw addSubview:self];
          self.frame = CGRectMake(0, DEVICEHEIGH, DEVICEWIDTH,AUTO(300));
          self.backgroundColor = [UIColor whiteColor];
    
            [self initTextView];
}

- (void)returnKeyHandler
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(reKeyBoard)];
    [self addGestureRecognizer:tap];
    tap.cancelsTouchesInView = false;
}

//实现方法//取消textView ,textField的第一响应者即可
- (void)reKeyBoard
{
    [self.textView resignFirstResponder];
}


-(void)initTextView{
   
    self.textView = [UITextView hyb_viewWithSuperView:self constraints:^(MASConstraintMaker *make) {
        make.left.and.top.mas_equalTo(SK_MARGINLR);
        make.right.mas_equalTo(-SK_MARGINLR);
        make.height.mas_equalTo(AUTO(170));
    }];
    self.textView.backgroundColor = SK_COLOR_BASE_BACKGROUND;
     self.textView.textContainerInset = UIEdgeInsetsMake(8, 8, 0, 8);
    self.textView.placeholder = @"在此输入你对课程的心得体验";
    self.textView.layer.cornerRadius = AUTO(5);
    self.textView.font = NFONT;
    
    
    UIButton *btn = [UIButton hyb_buttonWithTitle:@"确认发布" superView:self constraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SK_MARGINLR);
        make.right.mas_equalTo(-SK_MARGINLR);
        make.bottom.mas_equalTo(-SK_MARGINLR);
        make.height.mas_equalTo(AUTO(44));
    } touchUp:^(UIButton *sender) {
        TOAST(@"确认发布");
        NSInteger tag = sender.tag;
        NoticeModel* model = [[NoticeModel alloc]init:tag msg:nil data:nil];
        NSString* targer = @"MHCousrsePlayViewController";
        [[NSNotificationCenter defaultCenter] postNotificationName:targer object:nil userInfo:[model mj_keyValues]];
    }];
    btn.layer.cornerRadius = AUTO(22);
    btn.backgroundColor = SK_COLOR_BASE_ORANGE;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = FONT(AUTO(16));
    btn.tag = 1000;
}


#pragma mark 打开与关闭方法
-(void)show{
   
    [self loadUI];
     [self returnKeyHandler];
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, DEVICEHEIGH-AUTO(300), DEVICEWIDTH, AUTO(300));
    }];
}

-(void)close{
    //移除点击手势
     __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.2 animations:^{
         self.frame = CGRectMake(0, DEVICEHEIGH, DEVICEWIDTH,AUTO(300));
    } completion:^(BOOL finished) {
        [weakSelf.navPopViw removeFromSuperview];
    }];
}


@end






//评论试图
@interface MHCourseCommentView ()
@property(nonatomic,strong)UITextView *textView;


@end


@implementation MHCourseCommentView

- (void)returnKeyHandler
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(reKeyBoard)];
    [self addGestureRecognizer:tap];
    tap.cancelsTouchesInView = false;
}

//实现方法//取消textView ,textField的第一响应者即可
- (void)reKeyBoard
{
    [self.textView resignFirstResponder];
}


-(void)initControl{
    [self returnKeyHandler];
    self.textView = [UITextView hyb_viewWithSuperView:self constraints:^(MASConstraintMaker *make) {
        make.left.and.top.mas_equalTo(SK_MARGINLR);
        make.right.mas_equalTo(-SK_MARGINLR);
        make.height.mas_equalTo(AUTO(170));
    }];
    self.textView.backgroundColor = SK_COLOR_BASE_BACKGROUND;
     self.textView.textContainerInset = UIEdgeInsetsMake(8, 8, 0, 8);
    self.textView.placeholder = @"在此输入你对课程的心得体验";
    self.textView.layer.cornerRadius = AUTO(5);
    self.textView.font = NFONT;
    
    
    UIButton *btn = [UIButton hyb_buttonWithTitle:@"确认发布" superView:self constraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SK_MARGINLR);
        make.right.mas_equalTo(-SK_MARGINLR);
        make.bottom.mas_equalTo(-SK_MARGINLR);
        make.height.mas_equalTo(AUTO(44));
    } touchUp:^(UIButton *sender) {
        TOAST(@"确认发布");
        NSInteger tag = sender.tag;
        NoticeModel* model = [[NoticeModel alloc]init:tag msg:nil data:nil];
        NSString* targer = @"MHCousrsePlayViewController";
        [[NSNotificationCenter defaultCenter] postNotificationName:targer object:nil userInfo:[model mj_keyValues]];
    }];
    btn.layer.cornerRadius = AUTO(22);
    btn.backgroundColor = SK_COLOR_BASE_ORANGE; 
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = FONT(AUTO(16));
    btn.tag = 1000;
}

@end
