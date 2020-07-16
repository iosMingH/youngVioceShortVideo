//
//  UIButton+FillColor.h
//  App
//
//  Created by mac on 2017/6/7.
//  Copyright © 2017年 HuanMingLi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (FillColor)
- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;
+ (UIImage *)imageWithColor:(UIColor *)color ;
@end
