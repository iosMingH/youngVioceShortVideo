//
//  MHShortVideoCCell.h
//  App
//
//  Created by Pro on 2020/6/29.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AlivcQuVideoModel;

NS_ASSUME_NONNULL_BEGIN

@interface MHShortVideoCCell : UICollectionViewCell
/**
 照片视图
 */
@property (strong, nonatomic) UIImageView *imageView;

/**
 状态label
 */
@property (strong, nonatomic) UILabel *statusLabel;

/**
 状态label的容器视图
 */
@property (strong, nonatomic) UIView *statusContainView;

- (void)configUIWithModel:(AlivcQuVideoModel *)viewModel;

@end

NS_ASSUME_NONNULL_END
