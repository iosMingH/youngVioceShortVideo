//
//  MHMyOrderDetailModel.h
//  App
//
//  Created by dayewang on 2020/7/14.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import "CECellModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MHMyOrderDetailModel : CECellModel
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;


@end


//商品详情
@interface MHMyOrderDetailInfoModel : CECellModel
@property (nonatomic, copy) NSString *iconStr;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *remark;

@end



NS_ASSUME_NONNULL_END
