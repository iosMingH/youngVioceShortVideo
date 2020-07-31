//
//  MHAllCourseListView.h
//  App
//
//  Created by dayewang on 2020/7/13.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import "CEBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface MHAllCourseListView : CEBaseView


@end


//评论弹出框
@interface MHPopCourseCommentView :CEBaseView
-(void)show;
-(void)close;
@property (nonatomic ,strong)UIButton *navPopViw;

@end

NS_ASSUME_NONNULL_END
