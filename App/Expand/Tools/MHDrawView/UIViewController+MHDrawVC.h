//
//  UIViewController+MHDrawVC.h
//  App
//
//  Created by dayewang on 2020/7/8.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MHDrawViewController;
NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (MHDrawVC)
@property (nonatomic, readonly, strong) MHDrawViewController *drawVC;
@end

NS_ASSUME_NONNULL_END
