//
//  MHShortVideoPlayCollectionViewDataSource.m
//  App
//
//  Created by Pro on 2020/4/8.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import "MHShortVideoPlayCollectionViewDataSource.h"

#import "MHShortVideoCoverCell.h"
@interface MHShortVideoPlayCollectionViewDataSource()

//@property (nonatomic, strong) NSMutableArray<AlivcQuVideoModel *> *videoList;

@property (nonatomic, copy) NSString *cellID;
@property (nonatomic, copy) CellConfig cellConfig;

@end
@implementation MHShortVideoPlayCollectionViewDataSource

- (instancetype)initWithCellID:(NSString *)cellID cellConfig:(CellConfig)cellConfig{
    if(self = [super init]) {
        self.cellID = cellID;
        self.cellConfig = cellConfig;
    }
    return self;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.videoList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MHShortVideoCoverCell *cell =  [collectionView dequeueReusableCellWithReuseIdentifier:self.cellID forIndexPath:indexPath];
//    cell.model = [self videoModelWithIndexPath:indexPath];;
    if (_cellConfig) {
        _cellConfig(cell, indexPath);
    }
    return cell;
}

- (AlivcShortVideoBasicVideoModel *)videoModelWithIndexPath:(NSIndexPath *)indexPath {
    
    if (self.videoList.count > 0) {
        if (self.videoList.count - indexPath.item >= 1) {
            return self.videoList[indexPath.item];
        }
    }
    return nil;
}


- (void)removeVideoAtIndex:(NSInteger)index {
    [self.videoList removeObjectAtIndex:index];
}
@end
