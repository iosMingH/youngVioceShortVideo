//
//  MHCourseSelectTitleViewController.m
//  App
//
//  Created by Pro on 2020/6/28.
//  Copyright © 2020 李焕明. All rights reserved.
// 课程标题

#import "MHCourseSelectTitleViewController.h"
#import "LSPPageView.h"
#import "MHCourseViewController.h"
#import "MHCommomCourseViewController.h"

@interface MHCourseSelectTitleViewController ()<LSPPageViewDelegate>
@property(nonatomic,strong)SearchView *searchV;
@end

@implementation MHCourseSelectTitleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor blackColor];
//    self.J_BaseNavHidden = YES;
    
//    self.navigationItem.title = @"课程";

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

//          self.navigationController.navigationBar.hidden = NO;
//        //设置导航栏背景图片为一个无图的image，导航栏会加载空imgae，就自然透明掉了
//        [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
//    //    同理透明掉导航栏下划线
//        [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];

    
}


- (void)initView{
    _searchV = [SearchView creatWithPlaceholder:@"输入课程关键字搜索" superView:self.view block:^(NSString *result) {
        NSLog(@"result=%@",result);
    }];
    
    [_searchV mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(Height_NavBar);
    }];
    
        NSMutableArray *testArray = [NSMutableArray array];

        for (int i = 0; i < 10; i++) {
            [testArray addObject:[NSString stringWithFormat:@"课程分类%d",i]];
        }

         

        NSMutableArray *childVcArray = [NSMutableArray array];
        for (int i = 0; i < testArray.count; i++) {
//            if (i == 0) {
//                MHCommomCourseViewController *vc = [[MHCommomCourseViewController alloc] init];
//                [childVcArray addObject:vc];
//            }else{
                MHCourseViewController *vc = [[MHCourseViewController alloc] init];
               [childVcArray addObject:vc];
//            }
        }
    
//            [testArray insertObject:@"推荐" atIndex:0];
         [testArray insertObject:@"推荐" atIndex:0];
            MHCommomCourseViewController *vc = [[MHCommomCourseViewController alloc] init];
            [childVcArray insertObject:vc atIndex:0];
    NSLog(@"testArray=%@",testArray);
        
        LSPPageView *pageView = [[LSPPageView alloc] initWithFrame:CGRectMake(0, Height_NavBar+50, self.view.bounds.size.width, self.view.bounds.size.height-50-Height_NavBar) titles:testArray.mutableCopy style:nil childVcs:childVcArray.mutableCopy parentVc:self];
        [pageView setToIndex:0];
        pageView.delegate = self;
        pageView.backgroundColor = [UIColor blackColor];
        [self.view addSubview:pageView];
    
}


#pragma mark - LSPPageViewDelegate
- (void)pageViewScollEndView:(LSPPageView *)pageView WithIndex:(NSInteger)index
{
    NSLog(@"第%zd个",index);
}
@end
