//
//  MHMyCourseModel.h
//  App
//
//  Created by dayewang on 2020/7/6.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import "CECellModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MHMyCourseModel : CECellModel
@property(nonatomic, copy)NSString *title;
@property(nonatomic, copy)NSString *content;
@property(nonatomic, copy)NSString *remark;
@end

NS_ASSUME_NONNULL_END
