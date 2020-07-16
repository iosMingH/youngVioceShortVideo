//
//  UIViewController+CEBase.m
//  App
//
//  Created by Pro on 2020/6/24.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import "UIViewController+CEBase.h"

@implementation UIViewController (CEBase)

+ (UIViewController *)layByClassName:(NSString *)viewControllerClassName{
    return [[NSClassFromString(viewControllerClassName)alloc]init];
}

@end
