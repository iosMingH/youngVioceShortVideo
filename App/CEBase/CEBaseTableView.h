//
//  CEBaseTableView.h
//  App
//
//  Created by Pro on 2020/6/24.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class CECellModel;
@class CEBaseTableViewCell;
@interface CEBaseTableView : UITableView

- (CEBaseTableViewCell *)dequeueReusableCellWithModel:(CECellModel *)model;

@end

NS_ASSUME_NONNULL_END
