//
//  MHUserViewController.h
//  App
//
//  Created by Pro on 2020/6/24.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import "CEBaseController.h"
#import "ENestScrollPageView.h"


NS_ASSUME_NONNULL_BEGIN

@interface MHUserViewController : CEBaseController
/** 列表 */
@property (nonatomic, strong) UICollectionView                 *collectionView;
@property (nonatomic, assign) NSInteger                        selectIndex;
@end

NS_ASSUME_NONNULL_END
