//
//  MHStudentExperienceCell.h
//  App
//
//  Created by dayewang on 2020/7/9.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import "CEBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface MHStudentExperienceCell : CEBaseTableViewCell
@property(nonatomic,strong)UIImageView *coverI;
@property(nonatomic,strong)UILabel *titleL;
@property(nonatomic,strong)UILabel *contentL;
@property(nonatomic,strong)UILabel *remarkL;
-(void)setModel:(id)model indexPath:(NSIndexPath *)indexPath;
@end



//*********** 课程播放页标题
@interface MHCoursePlayHeadTitleView : UITableViewHeaderFooterView
-(void)setModel:(id)model section:(NSInteger )section;
@end



//*********** 课程播放列表
@interface MHCourseListeningListCell : CEBaseTableViewCell
-(void)setModel:(id)model indexPath:(NSIndexPath *)indexPath;
@end


//*********** 课程cell
@interface MHCourseListeningSingleCell : UICollectionViewCell
-(void)setModel:(id)model indexPath:(NSIndexPath *)indexPath;
@end

NS_ASSUME_NONNULL_END
