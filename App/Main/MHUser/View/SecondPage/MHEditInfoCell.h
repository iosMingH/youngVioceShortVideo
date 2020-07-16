//
//  MHEditInfoCell.h
//  App
//
//  Created by dayewang on 2020/7/1.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import "CEBaseTableViewCell.h"
#import "MHEditInfoModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MHEditInfoCell : CEBaseTableViewCell
@property(nonatomic ,strong)MHEditInfoModel *model;
@property (nonatomic ,strong)UILabel *titleL;
@property (nonatomic ,strong)UITextField *contentT;
@end

NS_ASSUME_NONNULL_END
