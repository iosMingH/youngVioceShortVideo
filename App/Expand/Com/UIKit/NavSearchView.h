//
//  NavSearchView.h
//  LSYC
//
//  Created by fengxiadesinian on 2018/6/26.
//  Copyright © 2018年 fengxiadesinian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CEBaseController.h"
@interface NavSearchView : UIView
@property(nonatomic)BOOL isHidden;//隐藏界面
+(NavSearchView *)creatViewWithVC:(CEBaseController *)vc placeholder:(NSString *)placeHolder block:(HYBStringBlock)block;

@end
