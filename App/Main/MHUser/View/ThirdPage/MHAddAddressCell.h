//
//  MHAddAddressCell.h
//  App
//
//  Created by dayewang on 2020/7/3.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import "CEBaseTableViewCell.h"
#import "MHAddAddressModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MHAddAddressCell : CEBaseTableViewCell
@property(nonatomic ,strong)MHAddAddressModel *model;
@property (nonatomic ,strong)UILabel *titleL;
@property (nonatomic ,strong)UITextField *contentT;
@end

NS_ASSUME_NONNULL_END
