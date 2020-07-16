//
//  MHMyOrderDetailCell.h
//  App
//
//  Created by dayewang on 2020/7/14.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import "CEBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN
//下单状况
@interface MHMyOrderDetailCell : CEBaseTableViewCell
-(void)setModel:(id)model indexPath:(NSIndexPath *)indexPath;

@end

//商品信息
@interface MHMyOrderDetailInfoCell : CEBaseTableViewCell
-(void)setModel:(id)model indexPath:(NSIndexPath *)indexPath;

@end


//商品信息
@interface MHMyOrderDetailTitleHeadView : UITableViewHeaderFooterView
-(void)setModel:(id)model section:(NSInteger )section;

@end

NS_ASSUME_NONNULL_END
