//
//  MHSettingCell.h
//  App
//
//  Created by dayewang on 2020/7/2.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import "CEBaseTableViewCell.h"
#import "MHSettingModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MHSettingCell : CEBaseTableViewCell
@property (nonatomic ,strong)UILabel *titleL;
@property (nonatomic ,strong)UILabel *contentL;
@property(nonatomic,strong)UIImageView *iconV;


-(void)setModel:(id)model indexPath:(NSIndexPath *)indexPath;
@end

NS_ASSUME_NONNULL_END
