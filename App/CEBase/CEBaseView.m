//
//  CEBaseView.m
//  App
//
//  Created by mac on 2017/11/16.
//  Copyright © 2017年 HuanMingLi. All rights reserved.
//

#import "CEBaseView.h"

//#define kPixels     1.0 / [UIScreen mainScreen].scale  // 1px

@implementation CEBaseView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initData];
        [self initControl];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self initLayout];
}


-(void)initControl{}

-(void)initLayout{}

-(void)initData{}


-(void)drawBorder
{
    self.layer.borderWidth = kPixels;
//    self.layer.borderColor = [[UIColor randomColor]CGColor];
}

-(void)sendNotice:(NSString*)targer notice:(NSDictionary*)data;
{
    [[NSNotificationCenter defaultCenter] postNotificationName:targer
                                                        object:nil
                                                      userInfo:data];
}

@end
