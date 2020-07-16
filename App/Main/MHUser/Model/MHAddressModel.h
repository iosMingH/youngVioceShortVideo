//
//  MHAddressModel.h
//  App
//
//  Created by dayewang on 2020/7/2.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import "CECellModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MHAddressModel : CECellModel
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *content;
@property(nonatomic,strong)NSString *remark;
@end

NS_ASSUME_NONNULL_END
