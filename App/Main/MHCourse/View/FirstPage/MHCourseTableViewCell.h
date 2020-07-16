//
//  MHCourseTableViewCell.h
//  App
//
//  Created by Pro on 2020/6/28.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MHCourseTableViewCell : CEBaseTableViewCell
@property(nonatomic,strong)UIImageView *coverI;
@property(nonatomic,strong)UILabel *titleL;
@property(nonatomic,strong)UILabel *contentL;
@property(nonatomic,strong)UILabel *remarkL;
-(void)setModel:(id)model indexPath:(NSIndexPath *)indexPath;
@end

//***********推荐视图
@interface MHCourseTitleView : UITableViewHeaderFooterView
-(void)setModel:(id)model section:(NSInteger )section;
@end

//***********排序

@interface MHCourseSortView : UITableViewHeaderFooterView
-(void)setModel:(id)model section:(NSInteger )section;
@end



//*********** 课程介绍推荐图
@interface MHCourseIntroduceHeadView : CEBaseView
-(void)setModel:(id)model section:(NSInteger )section;
@end


//*********** 课程介绍标题
@interface MHCourseIntroduceHeadTitleView : UITableViewHeaderFooterView
-(void)setModel:(id)model section:(NSInteger )section;
@end

NS_ASSUME_NONNULL_END
