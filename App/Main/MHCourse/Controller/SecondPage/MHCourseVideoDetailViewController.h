//
//  MHCourseVideoDetailViewController.h
//  App
//
//  Created by dayewang on 2020/7/3.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import "CEBaseController.h"
#import "ENestScrollPageView.h"
NS_ASSUME_NONNULL_BEGIN

@interface MHCourseVideoDetailViewController : CEBaseController

@end



/***************子类继承***********************/

@interface Test1ItemView:EScrollPageItemBaseView<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,retain)UITableView *tableView;
@end



NS_ASSUME_NONNULL_END
