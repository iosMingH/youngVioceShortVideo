//
//  MHPageContentView.h
//  App
//
//  Created by Pro on 2020/6/3.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PageContentViewDelegate <NSObject>

-(void)pageContentViewProgress:(CGFloat)progress beforeIndex:(NSInteger)beforIndex targetIndex:(NSInteger)targetIndex;

@end

@interface MHPageContentView : UIView
@property (nonatomic,assign) id<PageContentViewDelegate> delegate;
@property (nonatomic,assign) NSInteger pageCount;
/// 创建视图
/// @param frame 区域大小
/// @param childVcs 控制器数组
/// @param parentViewController 父类
/// @param index 从那一页显示
- (instancetype)initWithFrame:(CGRect)frame childVcs:(NSMutableArray *)childVcs parentViewController:(UIViewController *)parentViewController index:(NSInteger )index;

- (void)setPageContentViewChangeCurrentIndex:(NSInteger)currentIndex;
@end

NS_ASSUME_NONNULL_END
