//
//  SCHomeController.m
//  App
//
//  Created by mac on 2017/11/22.
//  Copyright © 2017年 HuanMingLi. All rights reserved.
//

#import "SCHomeController.h"


@interface SCHomeController ()

@end

@implementation SCHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    adjustsScrollViewInsets(self.view);
    self.title = @"层数";

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)initView{
    
   
    
}

@end
