//
//  MHMessageViewController.m
//  App
//
//  Created by Pro on 2020/6/23.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import "MHMessageViewController.h"


@interface MHMessageViewController ()

@end

@implementation MHMessageViewController


- (void)viewDidLoad
{
  [super viewDidLoad];
  // Do any additional setup after loading the view.
    self.navigationItem.title = @"消息";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // 关闭滑动切换抽屉
       self.drawVC.slideEnabled = NO;
}

@end
