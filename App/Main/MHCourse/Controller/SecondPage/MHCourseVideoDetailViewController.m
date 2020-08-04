//
//  MHCourseVideoDetailViewController.m
//  App
//
//  Created by dayewang on 2020/7/3.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import "MHCourseVideoDetailViewController.h"
#import "ENestScrollPageView.h"
#import "MHMyOrderView.h"
#import "MHCourseIntroductionView.h"
#import "MHCousreShopViewController.h"
#import "MHCousrsePlayViewController.h"
#import "CommentsPopView.h"
#import "MHCourseBuyView.h"
#import "MHPopContentView.h"
#import "MHCoursePaymentStatusViewController.h"

#define HEIGHT_TOOLVIEW     AUTO(50)
@interface MHCourseVideoDetailViewController ()<IntroductionDelegate,LectureDelegate>
@property(nonatomic,retain)ENestScrollPageView *pageView;
@property(nonatomic,retain)MHCourseVideoDetailHeadView *headView;
@property(nonatomic,strong)MHCourseVideoDetailToolView *toolView;
@property(nonatomic,strong)MHPopContentView *popBuyView;

@end

@implementation MHCourseVideoDetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.view.backgroundColor = SK_COLOR_BASE_SEBACKGROUND;
    self.title = @"课程详情";
    [self pageView];
    // Do any additional setup after loading the view.
    [self initToolView];
        
}

//分页控制
- (ENestScrollPageView *)pageView{
    if (_pageView == nil) {
        MHCourseVideoDetailHeadView *headView = [[MHCourseVideoDetailHeadView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, AUTO(394))];
        
       MHCourseIntroductionView *v1 = [[MHCourseIntroductionView alloc] initWithPageTitle:@"课程介绍"];
        v1.delegate = self;

        
        MHLectureListView *v2 = [[MHLectureListView alloc] initWithPageTitle:@"听课列表"];
        v2.delegate = self;
        
        EScrollPageItemBaseView *v3 = [[MHStudentExperienceView alloc] initWithPageTitle:@"学员心得"];
        
        NSArray *vs = @[v1,v2,v3];
        //设置一些参数等等。。。
        ENestParam *param = [[ENestParam alloc] init];
        //从0开始
        param.scrollParam.segmentParam.startIndex = 0;
        //字体颜色等
        param.scrollParam.segmentParam.textColor = 0x767676;
        param.scrollParam.segmentParam.textSelectedColor = 0x282828;
        param.scrollParam.segmentParam.lineColor = SK_COLOR_BASE_ORANGE;

        //分栏高度
        param.scrollParam.headerHeight = 40;
        
        
        //这一步 避免试图不置顶
        CGFloat nvBarH = 0;
        _pageView = [[ENestScrollPageView alloc] initWithFrame:CGRectMake(0, nvBarH, self.view.frame.size.width, self.view.frame.size.height-nvBarH-HEIGHT_TOOLVIEW-Height_NavBar) headView:headView subDataViews:vs setParam:param];
        [_pageView eScrollView].bounces = NO;
        [self.view addSubview:_pageView];
        
        
        
    }
    return _pageView;
}

//底部工具栏
- (void)initToolView{
    
    _toolView = [MHCourseVideoDetailToolView hyb_viewWithSuperView:self.view constraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-kBottomHeight);
        make.height.mas_equalTo(HEIGHT_TOOLVIEW);
    }];
    _toolView.backgroundColor = [UIColor whiteColor];
}

#pragma mark - deletate
//课程介绍页面 跳转到下级页面
- (void)introductionPush_nextControllerDelegate:(NSInteger )param cmm:(id)cmm{
    NSLog(@"param=%ld",param);
     MHCousrsePlayViewController *vc= [[MHCousrsePlayViewController alloc]init];
     [self.navigationController pushViewController:vc animated:YES];
}

//听课列表页面 跳转到下级页面

- (void)lecturePush_nextControllerDelegate:(NSInteger)param cmm:(id)cmm{
      NSLog(@"param=%ld",param);
    MHCousrsePlayViewController *vc= [[MHCousrsePlayViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - notice
- (void)eventNotice:(NSNotification *)info
{
    NoticeModel *model = [NoticeModel mj_objectWithKeyValues:[info userInfo]];
    switch (model.code) {
//            店铺
                case 100:
            {
                MHCousreShopViewController *vc = [[MHCousreShopViewController alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
//            客服
                case 200:
            {
                TOAST(@"客服");
//                CommentsPopView *popView = [[CommentsPopView alloc] initWithAwemeId:@""];
//                [popView show];
            }
                break;
//            购买
                case 300:

            {

                MHPopContentView *popView = [[MHPopContentView alloc]initWithHeight:AUTO(250) withRoundSize:CGSizeMake(0, 0)];
                
                MHCourseBuyView *view = [[MHCourseBuyView alloc]initWithFrame:CGRectMake(0, AUTO(-20), popView.contentV.width, popView.contentV.height+AUTO(20))];
                [popView.contentV addSubview:view];
                [popView show];
                self.popBuyView = popView;
            }
                break;
//            确认支付
                case 1000:
            {
                MHCoursePaymentStatusViewController *vc = [[MHCoursePaymentStatusViewController alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
                [self.popBuyView dismiss];
            }
                break;
    

                default:
                    break;
    }
            
}


@end


