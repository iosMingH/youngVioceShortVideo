//
//  MHMyCourseCell.h
//  App
//
//  Created by dayewang on 2020/7/6.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import "CEBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface MHMyCourseCell : CEBaseTableViewCell
-(void)setModel:(id)model indexPath:(NSIndexPath *)indexPath;
@end

@interface MHMyCourseTitleView : UITableViewHeaderFooterView
-(void)setModel:(id)model section:(NSInteger )section;
@end


NS_ASSUME_NONNULL_END
