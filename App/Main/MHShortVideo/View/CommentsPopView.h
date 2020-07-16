//
//  CommentsPopView.h
//  Douyin
//
//  Created by Qiao Shi on 2018/7/30.
//  Copyright © 2018年 Qiao Shi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentsPopView:UIView

@property (nonatomic, strong) UILabel           *label;
@property (nonatomic, strong) UIImageView       *close;

- (instancetype)initWithAwemeId:(NSString *)awemeId;
- (void)show;
- (void)dismiss;

@end


@protocol CommentTextViewDelegate

@required
-(void)onSendText:(NSString *)text;

@end


@interface CommentTextView : UIView

@property (nonatomic, strong) UIView                         *container;
@property (nonatomic, strong) UITextView                     *textView;
@property (nonatomic, strong) id<CommentTextViewDelegate>    delegate;

- (void)show;
- (void)dismiss;

@end




