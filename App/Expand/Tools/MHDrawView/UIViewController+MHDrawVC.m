//
//  UIViewController+MHDrawVC.m
//  App
//
//  Created by dayewang on 2020/7/8.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import "UIViewController+MHDrawVC.h"
#import "MHDrawViewController.h"

@implementation UIViewController (MHDrawVC)
- (MHDrawViewController *)drawVC
{
    UIViewController *vc = self.parentViewController;
    while (vc) {
        if ([vc isKindOfClass:[MHDrawViewController class]]) {
            return (MHDrawViewController *)vc;
        } else if (vc.parentViewController && vc.parentViewController != vc) {
            vc = vc.parentViewController;
        } else {
            vc = nil;
        }
    }
    return nil;
}
@end
