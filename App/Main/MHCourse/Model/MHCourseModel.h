//
//  MHCourseModel.h
//  App
//
//  Created by Pro on 2020/6/28.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MHCourseModel : CECellModel
@property(nonatomic, copy)NSString *title;
@property(nonatomic, copy)NSString *content;
@property(nonatomic, copy)NSString *remark;
@end

NS_ASSUME_NONNULL_END
