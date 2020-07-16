//
//  MHSettingModel.h
//  App
//
//  Created by dayewang on 2020/7/2.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import "CECellModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MHSettingModel : CECellModel
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;
@end

NS_ASSUME_NONNULL_END
