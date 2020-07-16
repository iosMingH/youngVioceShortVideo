//
//  MHUserHeadView.h
//  App
//
//  Created by Pro on 2020/6/24.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import "CEBaseView.h"
#import "SlideTabBar.h"
static const NSInteger UserInfoHeaderAvatarTag = 0x01;
static const NSInteger UserInfoHeaderSendTag = 0x02;
static const NSInteger UserInfoHeaderFocusTag = 0x03;
static const NSInteger UserInfoHeaderFocusCancelTag = 0x04;
static const NSInteger UserInfoHeaderSettingTag = 0x05;
static const NSInteger UserInfoHeaderGithubTag = 0x06;

//@protocol UserInfoDelegate
//- (void)onUserActionTap:(NSInteger)tag;
//
//@end

NS_ASSUME_NONNULL_BEGIN


@interface MHUserHeadView : UICollectionReusableView

//@property (nonatomic, weak)   id <UserInfoDelegate>        delegate;


@property (nonatomic, strong) SlideTabBar                  *slideTabBar;

- (void)initData:(id)model;
//- (void)overScrollAction:(CGFloat) offsetY;
//- (void)scrollToTopAction:(CGFloat) offsetY;

@end

NS_ASSUME_NONNULL_END
