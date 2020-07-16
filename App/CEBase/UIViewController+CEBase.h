//
//  UIViewController+CEBase.h
//  App
//
//  Created by Pro on 2020/6/24.
//  Copyright © 2020 李焕明. All rights reserved.
//
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
#define LayVCByClassName(a) [UIViewController layByClassName:a]

@class CEBaseViewController;
@interface UIViewController (CEBase)
+ (CEBaseViewController *)layByClassName:(NSString *)viewControllerClassName;
@end

NS_ASSUME_NONNULL_END
