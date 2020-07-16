//
//  SCPopTool.m
//  App
//
//  Created by mac on 2018/4/27.
//  Copyright © 2018年 HuanMingLi. All rights reserved.
//

#import "SCPopTool.h"
static NSTimeInterval const kFadeInAnimationDuration = 0.7;
static NSTimeInterval const kTransformPart1AnimationDuration = 0.3;
static NSTimeInterval const kTransformPart2AnimationDuration = 0.4;
static CGFloat const kDefaultCloseButtonPadding = 17.0f;

@interface SCPopTool ()
{
    UIButton *_navPopViw;
    UIView *_presentView;

}
@end
@implementation SCPopTool

+ (SCPopTool *)sharedInstance {
    static SCPopTool *sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClient = [[SCPopTool alloc]init];
    });
    return sharedClient;
}

- (void)showWithMainView:(UIView *)mainView PresentView:(UIView *)presentView animated:(BOOL)animated{
//    [_navPopViw translucentWindowCenterCoverContent:greenView]
    
    _navPopViw = [[UIButton alloc]initWithFrame:mainView.frame];
    _navPopViw.backgroundColor = [UIColor colorWithWhite:0 alpha:0.55];
    [_navPopViw addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    [mainView addSubview:_navPopViw];
//        [mainView bringSubviewToFront:_navPopViw];
    presentView.center = mainView.center;
    [_navPopViw addSubview:presentView];
//    _mainView = mainView;
    _presentView = presentView;
    dispatch_async(dispatch_get_main_queue(), ^{
        if(animated){
            _navPopViw.alpha = 0;
            [UIView animateWithDuration:kFadeInAnimationDuration animations:^{
                _navPopViw.alpha = 1;
            }];
            presentView.alpha = 0;
            presentView.layer.shouldRasterize = YES;
            presentView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.0, 0.0);
            [UIView animateWithDuration:kTransformPart1AnimationDuration animations:^{
                presentView.alpha = 1;
                presentView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.2, 1.2);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:.2 animations:^{
                    presentView.alpha = 1;
                    presentView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.8, 0.8);
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:kTransformPart2AnimationDuration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                        presentView.alpha = 1;
                        presentView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
                    } completion:^(BOOL finished2) {
                        presentView.layer.shouldRasterize = NO;
                    }];
                    
                }];
            }];
        }
    });
    
}

- (void)close {
//    [_navPopViw removeFromSuperview];
    [self hideAnimated:YES withCompletionBlock:nil];
}


- (void)hideAnimated:(BOOL)animated withCompletionBlock:(void(^)())completion {
    if(!animated){
        [self cleanup];
        return;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:kFadeInAnimationDuration animations:^{
            _navPopViw.alpha = 0;
        }];
        
        _presentView.layer.shouldRasterize = YES;
        [UIView animateWithDuration:kTransformPart2AnimationDuration animations:^{
            _presentView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.2, 1.2);
        } completion:^(BOOL finished){
            [UIView animateWithDuration:kTransformPart1AnimationDuration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                _presentView.alpha = 0;
                _presentView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.0, 0.0);
            } completion:^(BOOL finished2){
                [self cleanup];
                if(completion){
                    completion();
                }
            }];
        }];
    });
    
}

- (void)cleanup{
    [_presentView removeFromSuperview];
     [_navPopViw removeFromSuperview];

}
@end
