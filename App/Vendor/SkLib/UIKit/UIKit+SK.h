//
//  UIKit+SK.h
//  App
//
//  Created by 李焕明 on 15/11/19.
//  Copyright © 2015年 李焕明. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDate+Helpers.h"

// RGB颜色设置
#define RGBCOLOR(r,g,b)     [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
// RGBA颜色设置
#define RGBACOLOR(r,g,b,a)  [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
// 十六进制颜色设置
#define HEXCOLOR(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
// 十六进制颜色设置
#define HEXACOLOR(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]
// 系统版本
#define XcodeAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

#define APPSTOREID     @"1373601388" //@"1104867082"
@interface UIColor (SK)
+(UIColor *) randomColor;
+(UIColor *) hexStringToColor: (NSString *) stringToConvert;
+(UIImage*) createImageWithColor: (UIColor*) color;
@end

@interface UIScrollView (SK)

@end

@interface UIView(SK)
- (UIImage *)imageByRenderingView;
@end

@interface UIButton (UIButtonImageWithLable)
- (void) setImage:(UIImage *)image withTitle:(NSString *)title forState:(UIControlState)stateType;
@end

@interface UIImage (SK)
+ (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize;
+ (UIImage *)getTheLaunchImage;
@end

@interface NSString (SK)
+ (NSString *)translation:(NSString *)arebic;//阿拉伯数字转化为汉语数字
+ (CGFloat)heightWithString:(NSString *)string width:(CGFloat)width font:(UIFont *)font;
+ (CGFloat)widthWithString:(NSString *)string height:(CGFloat)height font:(UIFont *)font;
+ (NSString *)timeInfoWithDateString:(NSString *)dateString;//将时间转化到几天前模式
+ (CGSize)sizeWithString:(NSString *)string MaxSize:(CGSize)maxSize font:(UIFont *)font;
//临时
+ (NSString *)randomHeadImageStr;
@end

@interface NSDate (SK)
- (NSString *)prettyDateWithReference:(NSDate *)reference;
@end

