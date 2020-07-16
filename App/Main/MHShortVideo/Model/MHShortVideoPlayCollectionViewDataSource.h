//
//  MHShortVideoPlayCollectionViewDataSource.h
//  App
//
//  Created by Pro on 2020/4/8.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MHShortVideoCoverCell;
@class AlivcQuVideoModel;
@class AlivcShortVideoBasicVideoModel;

typedef void(^CellConfig)(MHShortVideoCoverCell * _Nullable cell,NSIndexPath * _Nullable indexPath);

NS_ASSUME_NONNULL_BEGIN

@interface MHShortVideoPlayCollectionViewDataSource : NSObject<UICollectionViewDataSource>
@property (nonatomic, strong) NSMutableArray<AlivcShortVideoBasicVideoModel *> *videoList;

- (instancetype)initWithCellID:(NSString *)cellID cellConfig:(CellConfig)cellConfig;

- (AlivcQuVideoModel *)videoModelWithIndexPath:(NSIndexPath *)indexPath;

- (void)removeVideoAtIndex:(NSInteger)index;
@end

NS_ASSUME_NONNULL_END
