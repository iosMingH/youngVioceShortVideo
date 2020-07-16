//
//  UIColor+HexColor.h
//  App
//
//  Created by mac on 2017/9/21.
//  Copyright © 2017年 HuanMingLi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HexColor)

// 十六进制颜色
+ (UIColor*)colorWithHexString:(NSString*)hex;

+ (UIColor*)colorWithHexString:(NSString*)hex withAlpha:(CGFloat)alpha;


+ (UIColor *)colorWithHex:(int)hexValue alpha:(CGFloat)alpha;

/**
 颜色

 @param hexValue <#hexValue description#>
 @return <#return value description#>
 */
+ (UIColor *)colorWithHex:(int)hexValue;

@end
