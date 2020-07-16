//
//  FUProgressHUD.m
//  App
//
//  Created by mac on 2017/11/16.
//  Copyright © 2017年 HuanMingLi. All rights reserved.
//


#import "FUProgressHUD.h"
#import "SVProgressHUD.h"
#import "SVProgressHUD_Extension.h"

#define ST_TIME_DELAY 1.3f * NSEC_PER_SEC

@implementation FUProgressHUD

// 创建静态对象 防止外部访问
static FUProgressHUD *_instance;
+(instancetype) Instance
{// 也可以使用一次性代码
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:NULL] init] ;
        [_instance initStyle];
    }) ;
    return _instance ;
}

-(void)initStyle
{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD setBackgroundColor:[UIColor whiteColor]];
    [SVProgressHUD setForegroundColor:[UIColor grayColor]];
    [SVProgressHUD setMinimumDismissTimeInterval:CGFLOAT_MAX];
}

-(void)info:(NSString*)message
{// 提示
    [SVProgressHUD showInfoWithStatus:message];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(ST_TIME_DELAY)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

-(void)success:(NSString*)message
{// 成功
    [SVProgressHUD showSuccessWithStatus:message];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(ST_TIME_DELAY)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

-(void)error:(NSString*)message
{// 错误
    [SVProgressHUD showErrorWithStatus:message];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(ST_TIME_DELAY)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

-(void)loading:(NSString*)message
{
    [SVProgressHUD showImage:[UIImage imageWithGIFNamed:@"loading"] status:message];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(ST_TIME_DELAY)), dispatch_get_main_queue(), ^{
//        [SVProgressHUD dismiss];
//    });
}

- (void)show
{
    [SVProgressHUD show];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setForegroundColor:[UIColor blackColor]]; //字体颜色
    [SVProgressHUD setBackgroundColor:RGBCOLOR(230, 231, 238)];   //背景颜色
}

-(void)complete
{
    [SVProgressHUD dismiss];
}


@end
