//
//  MHRelationCourseController.h
//  App
//
//  Created by dayewang on 2020/7/28.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import "CEBaseController.h"
#import "MHCourseModel.h"
NS_ASSUME_NONNULL_BEGIN
 
@protocol PassValueDelegate <NSObject>

-(void)passValue:(id)value indexPath:(NSIndexPath *)indexPath;

@end

@interface MHRelationCourseController : CEBaseController

@property (nonatomic, weak) id<PassValueDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
