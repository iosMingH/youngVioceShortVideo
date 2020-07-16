//
//  MHTopMenuView.h
//  App
//
//  Created by Pro on 2020/3/5.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MHTopMenuView : UIScrollView
/**
 设置选中按钮的字体颜色
 */
@property (nonatomic, strong) UIColor *selectColor;
/**
 设置未选中按钮的字体颜色
 */
@property (nonatomic, strong) UIColor *defaultColor;
/**
 设置滑动线条的背景颜色
 */
@property (nonatomic, strong) UIColor *lineColor;
/**
 顶部按钮的数据源
 */
@property (nonatomic, strong) NSArray *titleArray;

@property (nonatomic, copy) void (^titleButtonClick)(NSInteger tag, UIButton *button);

/**
外面选中按钮后，调节按钮的位置
*/

- (void)setSelectButtonWithTag:(NSInteger )tag;

@end

NS_ASSUME_NONNULL_END
