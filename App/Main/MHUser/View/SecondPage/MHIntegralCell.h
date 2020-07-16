//
//  MHIntegralCell.h
//  App
//
//  Created by dayewang on 2020/7/1.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import "CEBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface MHIntegralCell : CEBaseTableViewCell
-(void)setModel:(id)model indexPath:(NSIndexPath *)indexPath;
@end

@interface MHTableHeadView : CEBaseView;
-(void)setModel:(id)model;

@end

NS_ASSUME_NONNULL_END
