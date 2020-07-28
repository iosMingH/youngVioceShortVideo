//
//  MHUserHeadView.m
//  App
//
//  Created by Pro on 2020/6/24.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import "MHUserHeadView.h"
#define KY_MTITLE @"key_title"
#define KY_MMARK  @"key_mark"
#define KY_MIMAGE @"key_image"
@interface MHUserHeadView ()<UITextViewDelegate,UITextFieldDelegate>

@property (nonatomic, strong) UIView                  *containerView;
@property (nonatomic, copy) NSArray<NSString *>       *constellations;
@property(nonatomic,strong)UIView *infoView;
@property(nonatomic,strong)UIView *introductionView;
@property(nonatomic,strong)UIView *toolView;
@property (nonatomic, strong) UIImageView                  *avatar;   //头像
@property(nonatomic,strong)UILabel *nickL;                            //昵称
@property(nonatomic,strong)UITextField *introductionT;                  //个人备注
 @property(nonatomic,strong)NSArray* menusData;
@property(nonatomic,strong)NSArray* toolData;


@end

@implementation MHUserHeadView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self){
        [self initData];
        [self initSubViews];
    }
    return self;
}

- (void)initData{
    self.menusData = @[
    @{KY_MTITLE:@"关注",
      KY_MMARK:@"100",
      KY_MIMAGE:@""},
    @{KY_MTITLE:@"粉丝",
      KY_MMARK:@"200",
      KY_MIMAGE:@""},
    @{KY_MTITLE:@"获赞",
    KY_MMARK:@"300",
    KY_MIMAGE:@""},
    @{KY_MTITLE:@"积分",
    KY_MMARK:@"400",
    KY_MIMAGE:@""}
    ];
    
    self.toolData = @[
        @{KY_MTITLE:@"申请开店",
          KY_MMARK:@"500",
          KY_MIMAGE:@""},
        @{KY_MTITLE:@"我的课程",
          KY_MMARK:@"600",
          KY_MIMAGE:@""},
        @{KY_MTITLE:@"我的订单",
        KY_MMARK:@"700",
        KY_MIMAGE:@""},
        @{KY_MTITLE:@"邀请好友",
        KY_MMARK:@"800",
        KY_MIMAGE:@""},
    ];
}

- (void)initSubViews {
    _containerView = [[UIView alloc] initWithFrame:self.bounds];
    [self addSubview:_containerView];
    _containerView.backgroundColor = SK_COLOR_BASE_SEBACKGROUND;
    [self UI_init_infoView];
    [self UI_init_introductionView];
//    [self UI_init_toolView];
    [self  UI_init_slideTabBar];
}


//用户信息
- (void)UI_init_infoView{
    
    UIView *infoView = [UIView hyb_viewWithSuperView:self constraints:^(MASConstraintMaker *make) {
        make.left.and.top.and.right.mas_equalTo(0);
        make.height.mas_equalTo(AUTO(100));
    }];
    infoView.backgroundColor = SK_COLOR_BASE_SEBACKGROUND;

    //头像
    UIImageView *headI = [UIImageView hyb_imageViewWithImage:@"img_find_default" superView:infoView constraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(AUTO(15));
        make.top.mas_equalTo(AUTO(10));
        make.size.mas_equalTo(CGSizeMake(AUTO(80), AUTO(80)));
    } onTaped:^(UITapGestureRecognizer *sender) {
        NSLog(@"123");
    }];
    headI.backgroundColor = [UIColor grayColor];
    headI.layer.cornerRadius = AUTO(40);
    self.avatar = headI;
    
    UIView *infoDetailV = [UIView hyb_viewWithSuperView:infoView constraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headI.mas_right).offset(AUTO(15));
        make.right.mas_equalTo(-AUTO(15));
        make.top.equalTo(headI);
        make.height.equalTo(infoView).multipliedBy(0.5);
    }];

    [infoDetailV layoutIfNeeded];
    
    CGFloat infoDetailW = infoDetailV.width/4;
    
//    NSArray *titleA = @[@"关注",@"粉丝",@"获赞",@"积分"];
     NSArray *remarkA = @[@"212",@"2323",@"344334",@"23213"];
    for (int i = 0; i < self.menusData.count; i++) {
        NSDictionary* item = [self.menusData objectAtIndex:i];
        UIView *titleV = [UIView hyb_viewWithSuperView:infoDetailV constraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.height.equalTo(infoDetailV);
            make.width.mas_equalTo(infoDetailW);
            make.left.mas_equalTo(i*infoDetailW);
        } onTaped:^(UITapGestureRecognizer *sender) {
            
            [self infoAction:sender];
            
        }];
        titleV.tag = [[item objectForKey:KY_MMARK]integerValue];
        titleV.backgroundColor = SK_COLOR_BASE_SEBACKGROUND;
    
        //标题  关注 粉丝 获赞 积分
        UILabel *titleL = [UILabel hyb_labelWithText:[item objectForKey:KY_MTITLE] font:AUTO(12) superView:titleV constraints:^(MASConstraintMaker *make) {
            make.left.and.right.and.top.mas_equalTo(0);
            make.height.equalTo(titleV).multipliedBy(0.5);
        }];
        titleL.textColor = [UIColor whiteColor];
        titleL.textAlignment = NSTextAlignmentCenter;
        
        //具体的数值
        UILabel *remarkL = [UILabel hyb_labelWithText:remarkA[i] font:AUTO(15) superView:titleV constraints:^(MASConstraintMaker *make) {
            make.left.and.right.mas_equalTo(0);
            make.height.equalTo(titleV).multipliedBy(0.5);
            make.top.equalTo(titleL.mas_bottom);
               }];
            remarkL.textColor = [UIColor whiteColor];
            remarkL.textAlignment = NSTextAlignmentCenter;
    }
    
    //编辑资料按钮
    UIButton *editB = [UIButton hyb_buttonWithTitle:@"编辑资料" superView:infoView constraints:^(MASConstraintMaker *make) {
        make.left.equalTo(infoDetailV.mas_left);
        make.width.equalTo(infoDetailV.mas_width).multipliedBy(0.6);
        make.top.equalTo(infoDetailV.mas_bottom).offset(AUTO(5));
        make.bottom.equalTo(infoView.mas_bottom).offset(AUTO(-5));
    } touchUp:^(UIButton *sender) {
        [self button:sender];
        
    }];
    [editB layoutIfNeeded];
    editB.layer.cornerRadius = editB.height/2;
    editB.backgroundColor = [UIColor grayColor];
    editB.titleLabel.font = FONT(AUTO(13));
    editB.tag = 1000;
    
    //签到按钮
    UIButton *signB = [UIButton hyb_buttonWithTitle:@"签到" superView:infoView constraints:^(MASConstraintMaker *make) {
        make.left.equalTo(editB.mas_right).offset(AUTO(10));
        make.top.equalTo(infoDetailV.mas_bottom).offset(AUTO(5));
        make.bottom.equalTo(infoView.mas_bottom).offset(AUTO(-5));
        make.right.mas_equalTo(-AUTO(15));
       } touchUp:^(UIButton *sender) {
          [self button:sender];
       }];
       [signB layoutIfNeeded];
       signB.layer.cornerRadius = signB.height/2;
       signB.backgroundColor = [UIColor grayColor];
       signB.titleLabel.font = FONT(AUTO(13));
        signB.tag = 1100;
                           
                           
    self.infoView = infoView;
    
}

//昵称 简介
- (void)UI_init_introductionView{
    
    UIView *introductionView = [UIView hyb_viewWithSuperView:self constraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.infoView.mas_bottom);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(AUTO(100));
       }];
    introductionView.backgroundColor = SK_COLOR_BASE_SEBACKGROUND;
    
    [UIView hyb_addBottomLineToView:introductionView height:0.5 color:SK_COLOR_BASE_TEXT_GRAY];
    
    UILabel *nickL = [UILabel hyb_labelWithFont:AUTO(16) superView:introductionView constraints:^(MASConstraintMaker *make) {
         make.left.mas_equalTo(AUTO(15));
        make.right.mas_equalTo(-AUTO(15));
        make.top.mas_equalTo(20);
        make.height.mas_equalTo(30);
    }];
    nickL.text = @"昵称";
    nickL.textColor = SK_COLOR_BASE_TITLEMAIN; 
    
    self.nickL = nickL;
    
   UITextField *introductionT = [UITextField hyb_textFieldWithHolder:@"你还没有个人简介，点击此处添加" delegate:self superView:introductionView constraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(AUTO(15));
        make.right.mas_equalTo(-AUTO(15));
        make.top.equalTo(nickL.mas_bottom);
        make.height.equalTo(introductionView).multipliedBy(0.5);
    }];
    introductionT.font = FONT(15);
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"你还没有个人简介，点击此处添加" attributes:@{NSForegroundColorAttributeName:SK_COLOR_BASE_TEXT_GRAY,
        NSFontAttributeName:introductionT.font
    }];
     introductionT.attributedPlaceholder = attrString;

 
//     introductionT.attributedPlaceholder = @"你好没有个人简介，点击此处添加";
    self.introductionT = introductionT;
    
    self.introductionView = introductionView;

}

////开店 订单等
//- (void)UI_init_toolView{
//        
//    UIView *toolV = [UIView hyb_viewWithSuperView:self constraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.introductionView.mas_bottom);
//        make.left.and.right.mas_equalTo(0);
//        make.height.mas_equalTo(AUTO(100));
////        make.bottom.mas_equalTo(-20);
//         }];
//    toolV.backgroundColor = SK_COLOR_BASE_SEBACKGROUND;
//    
//    [toolV layoutIfNeeded];
//    CGFloat toolW = toolV.width/self.toolData.count;
//    
////      NSArray *titleA = @[@"申请开店",@"课程订单",@"邀请好友"];
//        for (int i = 0; i < self.toolData.count; i++) {
//        NSDictionary* item = [self.toolData objectAtIndex:i];
//        UIView *titleV = [UIView hyb_viewWithSuperView:toolV constraints:^(MASConstraintMaker *make) {
//                make.top.mas_equalTo(0);
//                make.height.equalTo(toolV);
//                make.width.mas_equalTo(toolW);
//                make.left.mas_equalTo(i*toolW);
//            } onTaped:^(UITapGestureRecognizer *sender) {
//                [self toolAction:sender];
//                
//            }];
//            titleV.tag = [[item objectForKey:KY_MMARK] integerValue];
//            titleV.backgroundColor = SK_COLOR_BASE_SEBACKGROUND;
//            
//            UIImageView *iconV = [UIImageView hyb_imageViewWithSuperView:titleV constraints:^(MASConstraintMaker *make) {
//                make.centerX.equalTo(titleV.mas_centerX);
//                make.top.mas_equalTo(AUTO(20));
//                make.size.mas_equalTo(CGSizeMake(AUTO(40), AUTO(40)));
//            }];
//            iconV.backgroundColor = [UIColor grayColor];
//            iconV.layer.cornerRadius = AUTO(20);
//        
//            UILabel *titleL = [UILabel hyb_labelWithText:[item objectForKey:KY_MTITLE]  font:AUTO(12) superView:titleV constraints:^(MASConstraintMaker *make) {
//                make.left.and.right.mas_equalTo(0);
//                make.height.equalTo(titleV).multipliedBy(0.3);
//                make.top.equalTo(iconV.mas_bottom).offset(AUTO(5));
//            }];
//            titleL.textColor = [UIColor whiteColor];
//            titleL.textAlignment = NSTextAlignmentCenter;
//            
//        }
//    
//    
//    
//        [UIView hyb_addBottomLineToView:toolV height:0.3 color:SK_COLOR_BASE_TEXT_GRAY];
//    
//        self.toolView = toolV;
//}

- (void)UI_init_slideTabBar {
  
    
    _slideTabBar = [SlideTabBar new];
    [self addSubview:_slideTabBar];
    [_slideTabBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
        make.left.right.bottom.equalTo(self);
    }];
    [_slideTabBar setLabels:@[@"作品",@"转发",@"赞过"] tabIndex:0];
}

- (void)initData:(id)model {
//    [_slideTabBar setLabels:@[[@"作品" stringByAppendingString:[NSString stringWithFormat:@"%d",15]],[@"转发" stringByAppendingString:[NSString stringWithFormat:@"%d", 5]],[@"赞过" stringByAppendingString:[NSString stringWithFormat:@"%d",5]]] tabIndex:0];
    
    [_slideTabBar setLabels:@[@"作品",@"转发",@"赞过"] tabIndex:0];
}

//-(void)onTouch:(UIButton*)sender
//{
//    if (sender.tag == 100) {
//        sender.selected = !sender.selected;
//    }
//    NoticeModel* model = [[NoticeModel alloc]init:sender.tag msg:nil data:nil];
//    NSString* targer = @"SCBillingController";
//    [[NSNotificationCenter defaultCenter] postNotificationName:targer object:nil userInfo:[model mj_keyValues]];
//}
#pragma mark - action
//关注 粉丝 获赞 积分
- (void)infoAction:(UITapGestureRecognizer *)sender
{
    NSInteger tag = [sender view].tag;
    
    NoticeModel* model = [[NoticeModel alloc]init:tag msg:nil data:nil];
    NSString* targer = @"MHUserViewController";
    [[NSNotificationCenter defaultCenter] postNotificationName:targer object:nil userInfo:[model mj_keyValues]];
                
}


//申请开店 课程订单  邀请好友
- (void)toolAction:(UITapGestureRecognizer *)sender
{
    NSInteger tag = [sender view].tag;
    NoticeModel* model = [[NoticeModel alloc]init:tag msg:nil data:nil];
    NSString* targer = @"MHUserViewController";
    [[NSNotificationCenter defaultCenter] postNotificationName:targer object:nil userInfo:[model mj_keyValues]];
                
}

//编辑资料 签到
- (void)button:(UIButton *)sender{
    
    NoticeModel* model = [[NoticeModel alloc]init:sender.tag msg:nil data:nil];
    NSString* targer = @"MHUserViewController";
    [[NSNotificationCenter defaultCenter] postNotificationName:targer object:nil userInfo:[model mj_keyValues]];
}

@end
