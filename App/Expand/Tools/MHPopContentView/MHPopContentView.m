//
//  MHPopContentView.m
//  App
//
//  Created by dayewang on 2020/7/13.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import "MHPopContentView.h"
#import "NSNotification+Extension.h"
#import "NSAttributedString+Extension.h"

@interface MHPopContentView () <UIGestureRecognizerDelegate,UIScrollViewDelegate>
@property (nonatomic, strong) UIView            *container;
@end


@implementation MHPopContentView

- (instancetype)initWithHeight:(CGFloat)height withRoundSize:(CGSize)roundSize{
    
    self = [super init];
    if (self) {
        self.frame = ScreenFrame;
      
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGuesture:)];
        tapGestureRecognizer.delegate = self;
        [self addGestureRecognizer:tapGestureRecognizer];
        self.backgroundColor = RGBACOLOR(0, 0, 0, 0.2);
                
        _container = [[UIView alloc] initWithFrame:CGRectMake(0, DEVICEHEIGH, DEVICEWIDTH, height)];
        _container.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:_container];
        
        _contentV = [[UIView alloc]initWithFrame:CGRectMake(0, AUTO(40), DEVICEWIDTH, _container.height-AUTO(40))];
        [_container addSubview:_contentV];
        
        UIBezierPath* rounded = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, DEVICEWIDTH, height) byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:roundSize];
        CAShapeLayer* shape = [[CAShapeLayer alloc] init];
        [shape setPath:rounded.CGPath];
        _container.layer.mask = shape;

//        UIBlurEffect *blurEffect =[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
//        UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc]initWithEffect:blurEffect];
//        visualEffectView.frame = self.bounds;
//        visualEffectView.alpha = 0.3;
//        [_container addSubview:visualEffectView];
//
        
        _titieL = [[UILabel alloc] init];
        _titieL.textColor = ColorGray;
//        _titieL.text = @"课程列表";
        _titieL.font = SmallFont;
        _titieL.textAlignment = NSTextAlignmentCenter;
        [_container addSubview:_titieL];
        
        _close = [[UIImageView alloc] init];
        _close.image = [UIImage imageNamed:@"icon_closetopic"];
        _close.contentMode = UIViewContentModeCenter;
        [_close addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGuesture:)]];
        [_container addSubview:_close];
        [_titieL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.container);
            make.height.mas_equalTo(35);
        }];
        [_close mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.titieL);
            make.right.mas_equalTo(-10);
            make.width.height.mas_equalTo(30);
        }];
                
    }
    return self;
}


//guesture
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    
    if ([touch.view isKindOfClass:[UIButton class]]) {
        return NO;
    }
    
    for (id className in self.shouldClickClasses) {
    
        if ([NSStringFromClass([touch.view.superview class]) isEqualToString:className]) {
            return NO;
        }

    }
    return YES;
}

- (void)handleGuesture:(UITapGestureRecognizer *)sender {
    CGPoint point = [sender locationInView:_container];
    if(![_container.layer containsPoint:point]) {
        [self dismiss];
        return;
    }
    point = [sender locationInView:_close];
    if([_close.layer containsPoint:point]) {
        [self dismiss];
    }
}

//update method
- (void)show {
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    [window addSubview:self];
    [UIView animateWithDuration:0.15f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         CGRect frame = self.container.frame;
                         frame.origin.y = frame.origin.y - frame.size.height;
                         self.container.frame = frame;
                     }
                     completion:^(BOOL finished) {
                     }];
}

- (void)dismiss {
    [UIView animateWithDuration:0.15f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         CGRect frame = self.container.frame;
                         frame.origin.y = frame.origin.y + frame.size.height;
                         self.container.frame = frame;
                     }
                     completion:^(BOOL finished) {
                         [self removeFromSuperview];
                     }];
}

@end

