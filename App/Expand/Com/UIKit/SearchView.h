//
//  SearchView.h
//  LSYC
//
//  Created by fengxiadesinian on 2018/1/29.
//  Copyright © 2018年 fengxiadesinian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchView : UIView

@property(nonatomic)HYBStringBlock endEdit;
@property(nonatomic,strong)UITextField *searchBox;




+(SearchView *)creatWithsuperView:(UIView *)superView block:(HYBStringBlock)block;
+(SearchView *)creatWithPlaceholder:(NSString *)placeholder superView:(UIView *)superView block:(HYBStringBlock)block;
@end
