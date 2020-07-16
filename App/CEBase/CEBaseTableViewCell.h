//
//  CEBaseTableViewCell.h
//  App
//
//  Created by Pro on 2020/6/24.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^CellHandleBlock)(_Nullable id response);

@interface CEBaseTableViewCell : UITableViewCell
@property (nonatomic ,strong) id data;
@property (nonatomic ,copy) CellHandleBlock Block;

@end

NS_ASSUME_NONNULL_END
