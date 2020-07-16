//
//  ALIVCViewController.m
//  AlivcSmartVideo
//
//  Created by wb-ll501135 on 12/31/2019.
//  Copyright (c) 2019 wb-ll501135. All rights reserved.
//

#import "ALIVCViewController.h"
#import "AlivcShortVideoQuHomeTabBarController.h"

@interface ALIVCViewController ()

@end

@implementation ALIVCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)pushTovc:(id)sender {
    AlivcShortVideoQuHomeTabBarController *vc = [[AlivcShortVideoQuHomeTabBarController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
