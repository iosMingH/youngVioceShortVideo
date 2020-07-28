//
//  CollectionViewSpaceLayout.h
//  App
//
//  Created by Pro on 2020/6/24.
//  Copyright © 2020 李焕明. All rights reserved.
// 使每个item等间距

#import <UIKit/UIKit.h>

@protocol SpaceLayoutDelegate <NSObject>

@required
//返回cell大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface CollectionViewSpaceLayout : UICollectionViewLayout

@property (nonatomic,weak) id<SpaceLayoutDelegate> delegate;

//距离上下左右的距离
@property (nonatomic,assign) UIEdgeInsets sectionInsets;

//上下两个item的距离
@property (nonatomic,assign) CGFloat lineSpacing;

//左右两个item的距离
@property (nonatomic,assign) CGFloat interitemSpacing;

@end
