//
//  MHCourseIntroductionView.h
//  App
//
//  Created by dayewang on 2020/7/9.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ENestScrollPageView.h"
NS_ASSUME_NONNULL_BEGIN
//************ 课程介绍
@protocol IntroductionDelegate;
@interface MHCourseIntroductionView : EScrollPageItemBaseView
@property (nonatomic, assign) id <IntroductionDelegate> delegate;
@end

@protocol IntroductionDelegate<NSObject>
@optional
//跳转到其他控制器
- (void)introductionPush_nextControllerDelegate:(NSInteger)param cmm:(id)cmm;
@end


//**************听课列表
@protocol LectureDelegate;
@interface MHLectureListView : EScrollPageItemBaseView
@property (nonatomic, assign) id <LectureDelegate> delegate;
@end

@protocol LectureDelegate<NSObject>
@optional
//跳转到其他控制器
- (void)lecturePush_nextControllerDelegate:(NSInteger)param cmm:(id)cmm;
@end


/***************************************/

@interface MHCourseVideoDetailHeadView : CEBaseView

@property(nonatomic,retain)UIImageView *bgImageView;        //背景图
-(void)setModel:(id)model section:(NSInteger )section;
@end




//**************学员心得
@interface MHStudentExperienceView : EScrollPageItemBaseView

@end



//**************店铺 客服 购买  按钮
@interface MHCourseVideoDetailToolView : CEBaseView

@end
NS_ASSUME_NONNULL_END
