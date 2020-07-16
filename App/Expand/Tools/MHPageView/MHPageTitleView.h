//
//  MHPageTitleView.h
//  App
//
//  Created by Pro on 2020/6/3.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PageTitleViewDelegate <NSObject>
- (void)pageTitleViewCurrentIndex:(NSInteger)currentIndex;
@end

@interface MHPageTitleView : UIView
@property (nonatomic,assign) id<PageTitleViewDelegate> delegate;

/// 创建视图
/// @param frame 区域大小
/// @param titles 标题
/// @param index 从那一页开始
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles index:(NSInteger )index;

- (void)setTitleChangeProgress:(CGFloat)progress beforeIndex:(NSInteger)beforIndex targetIndex:(NSInteger)targetIndex;

- (void)setScrollLineColor:(UIColor *)color;
@end

NS_ASSUME_NONNULL_END
