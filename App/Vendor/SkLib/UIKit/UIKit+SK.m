//
//  UIKit+SK.m
//  App
//
//  Created by 李焕明 on 15/11/19.
//  Copyright © 2015年 李焕明. All rights reserved.
//

#import "UIKit+SK.h"

@implementation UIColor (SK)
+(UIColor *) randomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 ); //0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5; // 0.5 to 1.0,away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5; //0.5 to 1.0,away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}
+(UIColor *) hexStringToColor: (NSString *) stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    
    if ([cString length] < 6) return [UIColor blackColor];
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor blackColor];
    
    // Separate into r, g, b substrings
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

+(UIImage*) createImageWithColor: (UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end


@implementation UIScrollView (SK)

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    //做你想要的操作
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    //做你想要的操作
}

@end

@implementation UIView(SK)
- (UIImage *)imageByRenderingView
{
    CGFloat oldAlpha = self.alpha;
    self.alpha = 1;
    
    CGSize s = self.bounds.size;
    UIGraphicsBeginImageContextWithOptions(s, NO, [UIScreen mainScreen].scale);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage*resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.alpha = oldAlpha;
    return resultingImage;
    
}
@end

@implementation UIButton (UIButtonImageWithLable)
- (void)setImage:(UIImage *)image withTitle:(NSString *)title forState:(UIControlState)stateType {
    //UIEdgeInsetsMake(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right)
    
    //    CGSize titleSize = [title sizeWithFont: [UIFont systemFontOfSize:12.0f ] ];
    CGSize titleSize = CGSizeZero;
    titleSize.width = [NSString widthWithString:title height:21 font:  [UIFont systemFontOfSize:13.0f ]];
    [self.imageView setContentMode:UIViewContentModeCenter];
    [self setImageEdgeInsets:UIEdgeInsetsMake(-8.0,
                                              0.0,
                                              0.0,
                                              -titleSize.width)];
    [self setImage:image forState:stateType];
    
    [self.titleLabel setContentMode:UIViewContentModeCenter];
    [self.titleLabel setBackgroundColor:[UIColor clearColor]];
    [self.titleLabel setFont: [UIFont systemFontOfSize:13.0f ] ];
    //    [self.titleLabel setTextColor:COLOR_ffffff];
    [self setTitleEdgeInsets:UIEdgeInsetsMake(30.0,
                                              -image.size.width,
                                              0.0,
                                              0.0)];
    [self setTitle:title forState:stateType];
}

@end

@implementation UIImage (SK)
+ (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize
{
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return reSizeImage;
}

+ (UIImage *)getTheLaunchImage
{
    NSString *defaultImageName = @"LaunchImage";
    NSInteger osVersion = floor([[[UIDevice currentDevice] systemVersion] floatValue])*100;
    NSInteger screenHeight = CGRectGetHeight([UIScreen mainScreen].bounds);
    // 3.5inch
    if (screenHeight < 568) {
        // >iOS7
        if (osVersion >= 700) {
            defaultImageName = [NSString stringWithFormat:@"%@-%zd",defaultImageName,osVersion];
        }
        // <iOS7
    }
    // 4.0inch and 4.7inch
    else if(screenHeight < 736){
        // >iOS7
        if (osVersion >= 700) {
            defaultImageName = [NSString stringWithFormat:@"%@-%zd-%zdh",defaultImageName,osVersion,screenHeight];
        }
        // <iOS7
        else {
            defaultImageName = [NSString stringWithFormat:@"%@-%zdh",defaultImageName,screenHeight];
        }
    }
    // 5.5inch
    else{
        NSString *orientation = @"";
        switch ([[UIApplication sharedApplication] statusBarOrientation]) {
            case UIInterfaceOrientationUnknown:
            case UIInterfaceOrientationPortrait:
            case UIInterfaceOrientationPortraitUpsideDown:
                orientation = @"Portrait";
                break;
            case UIInterfaceOrientationLandscapeLeft:
            case UIInterfaceOrientationLandscapeRight:
                orientation = @"Landscape";
                break;
            default:
                break;
        }
        defaultImageName = [NSString stringWithFormat:@"%@-%zd-%@-%zdh",defaultImageName,osVersion,orientation,screenHeight];
    }
    return [UIImage imageNamed:defaultImageName];
}
@end

@implementation NSString (SK)

+(NSString *)translation:(NSString *)arebic

{   NSString *str = arebic;
    NSArray *arabic_numerals = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0"];
    NSArray *chinese_numerals = @[@"一",@"二",@"三",@"四",@"五",@"六",@"七",@"八",@"九",@"零"];
    NSArray *digits = @[@"个",@"十",@"百",@"千",@"万",@"十",@"百",@"千",@"亿",@"十",@"百",@"千",@"兆"];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:chinese_numerals forKeys:arabic_numerals];
    
    NSMutableArray *sums = [NSMutableArray array];
    for (int i = 0; i < str.length; i ++) {
        NSString *substr = [str substringWithRange:NSMakeRange(i, 1)];
        NSString *a = [dictionary objectForKey:substr];
        NSString *b = digits[str.length -i-1];
        NSString *sum = [a stringByAppendingString:b];
        if ([a isEqualToString:chinese_numerals[9]])
        {
            if([b isEqualToString:digits[4]] || [b isEqualToString:digits[8]])
            {
                sum = b;
                if ([[sums lastObject] isEqualToString:chinese_numerals[9]])
                {
                    [sums removeLastObject];
                }
            }else
            {
                sum = chinese_numerals[9];
            }
            
            if ([[sums lastObject] isEqualToString:sum])
            {
                continue;
            }
        }
        
        [sums addObject:sum];
    }
    
    NSString *sumStr = [sums  componentsJoinedByString:@""];
    NSString *chinese = [sumStr substringToIndex:sumStr.length-1];
    return chinese;
}

+ (CGFloat)heightWithString:(NSString *)string width:(CGFloat)width font:(UIFont *)font
{
    //    CGSize size = [string sizeWithFont:font constrainedToSize:CGSizeMake(width, MAXFLOAT) lineBreakMode: NSLineBreakByWordWrapping];
    //    return size.height;
    CGRect rect = [string boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil] context:nil];
    return rect.size.height;
}

+ (CGFloat)widthWithString:(NSString *)string height:(CGFloat)height font:(UIFont *)font
{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil] context:nil];
    return rect.size.width;
}

+ (NSString *)randomHeadImageStr
{
    NSInteger isGirl = arc4random()%2;
    NSInteger index = arc4random()%4+1;
    
    NSMutableString *str = [NSMutableString stringWithString:@"img_"];
    isGirl ? [str appendString:@"boy_0"]:[str appendString:@"girl_0"];
    [str appendString:[NSString stringWithFormat:@"%ld.png", (long)index]];
    
    return str;
}

+ (CGSize)sizeWithString:(NSString *)string MaxSize:(CGSize)maxSize font:(UIFont *)font
{
    CGRect rect = [string boundingRectWithSize:maxSize
                                       options:NSStringDrawingUsesLineFragmentOrigin
                                    attributes:@{NSFontAttributeName:font}
                                       context:nil];
    return rect.size;
}

+ (NSString *)timeInfoWithDateString:(NSString *)dateString
{
    // 把日期字符串格式化为日期对象
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:dateString];
    
    NSDate *curDate = [NSDate date];
    NSTimeInterval time = -[date timeIntervalSinceDate:curDate];
    
    if ( [date getYear]>= 3000) {
        return @"置顶";
    }
    
    
    int month = (int)([curDate getMonth] - [date getMonth]);
    int year = (int)([curDate getYear] - [date getYear]);
    int day = (int)([curDate getDay] - [date getDay]);
    
    NSTimeInterval retTime = 1.0;
    // 小于一小时
    if (time < 3600) {
        retTime = time / 60;
        retTime = retTime <= 0.0 ? 1.0 : retTime;
        return [NSString stringWithFormat:@"%.0f分钟前", retTime];
    }
    // 小于一天，也就是今天
    else if (time < 3600 * 24) {
        retTime = time / 3600;
        retTime = retTime <= 0.0 ? 1.0 : retTime;
        return [NSString stringWithFormat:@"%.0f小时前", retTime];
    }
    // 昨天
    else if (time < 3600 * 24 * 2) {
        return @"昨天";
    }
    // 第一个条件是同年，且相隔时间在一个月内
    // 第二个条件是隔年，对于隔年，只能是去年12月与今年1月这种情况
    else if ((abs(year) == 0 && abs(month) <= 1)
             || (abs(year) == 1 && [curDate getMonth] == 1 && [date getMonth] == 12)) {
        int retDay = 0;
        // 同年
        if (year == 0) {
            // 同月
            if (month == 0) {
                retDay = day;
            }
        }
        
        if (retDay <= 0) {
            // 这里按月最大值来计算
            // 获取发布日期中，该月总共有多少天
            int totalDays = 31;//[NSDate daysInMonth:(int)[date getMonth] year:(int)[date getYear]];//待修正
            // 当前天数 + （发布日期月中的总天数-发布日期月中发布日，即等于距离今天的天数）
            retDay = (int)[curDate getDay] + (totalDays - (int)[date getDay]);
            
            if (retDay >= totalDays) {
                return [NSString stringWithFormat:@"%d个月前", (abs)(MAX(retDay / 31, 1))];
            }
        }
        
        return [NSString stringWithFormat:@"%d天前", (abs)(retDay)];
    } else  {
        if (abs(year) <= 1) {
            if (year == 0) { // 同年
                return [NSString stringWithFormat:@"%d个月前", abs(month)];
            }
            
            // 相差一年
            int month = (int)[curDate getMonth];
            int preMonth = (int)[date getMonth];
            
            // 隔年，但同月，就作为满一年来计算
            if (month == 12 && preMonth == 12) {
                return @"1年前";
            }
            
            // 也不看，但非同月
            return [NSString stringWithFormat:@"%d个月前", (abs)(12 - preMonth + month)];
        }
        
        return [NSString stringWithFormat:@"%d年前", abs(year)];
    }
    
    return @"1小时前";
}
@end

@implementation NSDate (SK)

- (NSString *)prettyDateWithReference:(NSDate *)reference
{
    NSString *suffix = @"ago";
    
    float different = [reference timeIntervalSinceDate:self];
    if (different < 0) {
        different = -different;
        suffix = @"from now";
    }
    
    // days = different / (24 * 60 * 60), take the floor value
    float dayDifferent = floor(different / 86400);
    
    int days   = (int)dayDifferent;
    int weeks  = (int)ceil(dayDifferent / 7);
    int months = (int)ceil(dayDifferent / 30);
    int years  = (int)ceil(dayDifferent / 365);
    
    // It belongs to today
    if (dayDifferent <= 0) {
        // lower than 60 seconds
        if (different < 60) {
            //            return @"just now";
            return @"刚刚";
        }
        
        // lower than 120 seconds => one minute and lower than 60 seconds
        if (different < 120) {
            //            return [NSString stringWithFormat:@"1 minute %@", suffix];
            return [NSString stringWithFormat:@"1 分钟 %@", suffix];
        }
        
        // lower than 60 minutes
        if (different < 660 * 60) {
            //            return [NSString stringWithFormat:@"%d minutes %@", (int)floor(different / 60), suffix];
            return [NSString stringWithFormat:@"%d 分钟 %@", (int)floor(different / 60), suffix];
        }
        
        // lower than 60 * 2 minutes => one hour and lower than 60 minutes
        if (different < 7200) {
            //            return [NSString stringWithFormat:@"1 hour %@", suffix];
            return [NSString stringWithFormat:@"1 小时 %@", suffix];
        }
        
        // lower than one day
        if (different < 86400) {
            //            return [NSString stringWithFormat:@"%d hours %@", (int)floor(different / 3600), suffix];
            return [NSString stringWithFormat:@"%d 小时 %@", (int)floor(different / 3600), suffix];
        }
    }
    // lower than one week
    else if (days < 7) {
        //        return [NSString stringWithFormat:@"%d day%@ %@", days, days == 1 ? @"" : @"s", suffix];
        return [NSString stringWithFormat:@"%d 天%@ %@", days, days == 1 ? @"" : @"s", suffix];
    }
    // lager than one week but lower than a month
    else if (weeks < 4) {
        //        return [NSString stringWithFormat:@"%d week%@ %@", weeks, weeks == 1 ? @"" : @"s", suffix];
        return [NSString stringWithFormat:@"%d 周%@ %@", weeks, weeks == 1 ? @"" : @"s", suffix];
    }
    // lager than a month and lower than a year
    else if (months < 12) {
        //        return [NSString stringWithFormat:@"%d month%@ %@", months, months == 1 ? @"" : @"s", suffix];
        return [NSString stringWithFormat:@"%d 月%@ %@", months, months == 1 ? @"" : @"s", suffix];
    }
    // lager than a year
    else {
        //        return [NSString stringWithFormat:@"%d year%@ %@", years, years == 1 ? @"" : @"s", suffix];
        return [NSString stringWithFormat:@"%d 年%@ %@", years, years == 1 ? @"" : @"s", suffix];
    }
    
    return self.description;
}

@end

