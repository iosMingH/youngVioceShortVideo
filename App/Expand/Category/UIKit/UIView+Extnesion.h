//
//  CmmSelectedTitle.h
//  App
//
//  Created by mac on 2017/9/15.
//  Copyright © 2017年 HuanMingLi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extnesion)
@property (nonatomic,assign) CGFloat x;
@property (nonatomic,assign) CGFloat y;
@property (nonatomic,assign) CGFloat centerX;
@property (nonatomic,assign) CGFloat centerY;
@property (nonatomic,assign) CGFloat width;
@property (nonatomic,assign) CGFloat height;
@property (nonatomic,assign) CGSize size;
@property (nonatomic,assign) CGPoint origin;


@end
@interface UIView (FindFirstResponder)

- (UIView *)findFirstResponder;

@end
