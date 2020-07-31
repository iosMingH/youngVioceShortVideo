//
//  CommentsPopView.m
//  Douyin
//
//  Created by Qiao Shi on 2018/7/30.
//  Copyright © 2018年 Qiao Shi. All rights reserved.
//

#import "CommentsPopView.h"
#import "NSNotification+Extension.h"
#import "NSAttributedString+Extension.h"

@interface CommentsPopView () <UIGestureRecognizerDelegate,UIScrollViewDelegate,CommentTextViewDelegate>

@property (nonatomic, assign) NSString                         *awemeId;


@property (nonatomic, assign) NSInteger                        pageIndex;
@property (nonatomic, assign) NSInteger                        pageSize;
@property (nonatomic, strong) CommentTextView                  *textView;
@property (nonatomic, strong) UIView                           *container;

@end


@implementation CommentsPopView

- (instancetype)initWithAwemeId:(NSString *)awemeId {
    self = [super init];
    if (self) {
        self.frame = ScreenFrame;
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGuesture:)];
        tapGestureRecognizer.delegate = self;
        [self addGestureRecognizer:tapGestureRecognizer];
        
        _awemeId = awemeId;

        
        _pageIndex = 0;
        _pageSize = 20;
                
        _container = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, ScreenHeight*3/4)];
        _container.backgroundColor = ColorBlackAlpha60;
        [self addSubview:_container];
        
        
        UIBezierPath* rounded = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, ScreenWidth, ScreenHeight*3/4) byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(10.0f, 10.0f)];
        CAShapeLayer* shape = [[CAShapeLayer alloc] init];
        [shape setPath:rounded.CGPath];
        _container.layer.mask = shape;
        
        UIBlurEffect *blurEffect =[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc]initWithEffect:blurEffect];
        visualEffectView.frame = self.bounds;
        visualEffectView.alpha = 1.0f;
        [_container addSubview:visualEffectView];
        
        
        _label = [[UILabel alloc] init];
        _label.textColor = ColorGray;
        _label.text = @"0条评论";
        _label.font = SmallFont;
        _label.textAlignment = NSTextAlignmentCenter;
        [_container addSubview:_label];
        
        _close = [[UIImageView alloc] init];
        _close.image = [UIImage imageNamed:@"icon_closetopic"];
        _close.contentMode = UIViewContentModeCenter;
        [_close addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGuesture:)]];
        [_container addSubview:_close];
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.container);
            make.height.mas_equalTo(35);
        }];
        [_close mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.label);
            make.right.mas_equalTo(-10);
            make.width.height.mas_equalTo(30);
        }];
        
        //用户评论视图
        UIView *commentTableView = [[UIView alloc]init];
        [_container addSubview:commentTableView];
        [commentTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(self.container);
            make.top.equalTo(self.label.mas_bottom);
            make.bottom.mas_equalTo(-50-SafeBottom);
        }];
//        commentTableView.backgroundColor = [UIColor yellowColor];
        
       _textView = [CommentTextView new];
        _textView.delegate = self;
        
    }
    return self;
}


// comment textView delegate
-(void)onSendText:(NSString *)text {
    TOAST(@"评论成功");
}

//guesture
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([NSStringFromClass([touch.view.superview class]) isEqualToString:@"CommentListCell"]) {
        return NO;
    }else {
        return YES;
    }
}

- (void)handleGuesture:(UITapGestureRecognizer *)sender {
    CGPoint point = [sender locationInView:_container];
    if(![_container.layer containsPoint:point]) {
        [self dismiss];
        return;
    }
    point = [sender locationInView:_close];
    if([_close.layer containsPoint:point]) {
        [self dismiss];
    }
}

//update method
- (void)show {
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    [window addSubview:self];
    [UIView animateWithDuration:0.15f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         CGRect frame = self.container.frame;
                         frame.origin.y = frame.origin.y - frame.size.height;
                         self.container.frame = frame;
                     }
                     completion:^(BOOL finished) {
                     }];
            [self.textView show];
}

- (void)dismiss {
    [UIView animateWithDuration:0.15f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         CGRect frame = self.container.frame;
                         frame.origin.y = frame.origin.y + frame.size.height;
                         self.container.frame = frame;
                     }
                     completion:^(BOOL finished) {
                         [self removeFromSuperview];
                         [self.textView dismiss];
                     }];
}

//UIScrollViewDelegate Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    if(offsetY < 0) {
        self.frame = CGRectMake(0, -offsetY, self.frame.size.width, self.frame.size.height);
    }
    if (scrollView.isDragging && offsetY < -50) {
        [self dismiss];
    }
}
@end






#pragma TextView

static const CGFloat kCommentTextViewLeftInset               = 15;
static const CGFloat kCommentTextViewRightInset              = 60;
static const CGFloat kCommentTextViewTopBottomInset          = 15;

@interface CommentTextView ()<UITextViewDelegate, UIGestureRecognizerDelegate>
@property (nonatomic, assign) CGFloat            textHeight;
@property (nonatomic, assign) CGFloat            keyboardHeight;
@property (nonatomic, retain) UILabel            *placeholderLabel;
@property (nonatomic, strong) UIImageView        *atImageView;
@property (nonatomic, strong) UIVisualEffectView *visualEffectView;
@end

@implementation CommentTextView
- (instancetype)init {
    self = [super init];
    if(self) {
        self.frame = ScreenFrame;
        self.backgroundColor = ColorClear;
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGuesture:)]];
        
        
        _container = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight - 50 - SafeBottom, ScreenWidth, 50 + SafeBottom)];
        _container.backgroundColor = ColorBlackAlpha40;
        [self addSubview:_container];
        
        _keyboardHeight = SafeBottom;
        
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
        _textView.backgroundColor = ColorClear;
        
        _textView.clipsToBounds = NO;
        _textView.textColor = ColorWhite;
        _textView.font = BigFont;
        _textView.returnKeyType = UIReturnKeySend;
        _textView.scrollEnabled = NO;
        _textView.textContainer.lineBreakMode = NSLineBreakByTruncatingTail;
        _textView.textContainerInset = UIEdgeInsetsMake(kCommentTextViewTopBottomInset, kCommentTextViewLeftInset, kCommentTextViewTopBottomInset, kCommentTextViewRightInset);
        _textView.textContainer.lineFragmentPadding = 0;
        _textHeight = ceilf(_textView.font.lineHeight);
        
        _placeholderLabel = [[UILabel alloc]init];
        _placeholderLabel.text = @"有爱评论，说点儿好听的~";
        _placeholderLabel.textColor = ColorGray;
        _placeholderLabel.font = BigFont;
        _placeholderLabel.frame = CGRectMake(kCommentTextViewLeftInset, 0, ScreenWidth - kCommentTextViewLeftInset - kCommentTextViewRightInset, 50);
        [_textView addSubview:_placeholderLabel];
        
        _atImageView = [[UIImageView alloc] init];
        _atImageView.contentMode = UIViewContentModeCenter;
        _atImageView.image = [UIImage imageNamed:@"iconWhiteaBefore"];
        [_textView addSubview:_atImageView];
        [_container addSubview:_textView];
        
        _textView.delegate = self;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _atImageView.frame = CGRectMake(ScreenWidth - 50, 0, 50, 50);
    
    UIBezierPath* rounded = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(10.0f, 10.0f)];
    CAShapeLayer* shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];
    _container.layer.mask = shape;
    
    [self updateTextViewFrame];
}


- (void)updateTextViewFrame {
    CGFloat textViewHeight = _keyboardHeight > SafeBottom ? _textHeight + 2*kCommentTextViewTopBottomInset : ceilf(_textView.font.lineHeight) + 2*kCommentTextViewTopBottomInset;
    _textView.frame = CGRectMake(0, 0, ScreenWidth, textViewHeight);
    _container.frame = CGRectMake(0, ScreenHeight - _keyboardHeight - textViewHeight, ScreenWidth, textViewHeight + _keyboardHeight);
}

//keyboard notification
- (void)keyboardWillShow:(NSNotification *)notification {
    _keyboardHeight = [notification keyBoardHeight];
    [self updateTextViewFrame];
    _atImageView.image = [UIImage imageNamed:@"iconBlackaBefore"];
    _container.backgroundColor = ColorWhite;
    _textView.textColor = ColorBlack;
    self.backgroundColor = ColorBlackAlpha60;
}

- (void)keyboardWillHide:(NSNotification *)notification {
    _keyboardHeight = SafeBottom;
    [self updateTextViewFrame];
    _atImageView.image = [UIImage imageNamed:@"iconWhiteaBefore"];
    _container.backgroundColor = ColorBlackAlpha40;
    _textView.textColor = ColorWhite;
    self.backgroundColor = ColorClear;
}

//textView delegate
-(void)textViewDidChange:(UITextView *)textView {
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithAttributedString:textView.attributedText];
    
    if(!textView.hasText) {
        [_placeholderLabel setHidden:NO];
        _textHeight = ceilf(_textView.font.lineHeight);
    }else {
        [_placeholderLabel setHidden:YES];
        _textHeight = [attributedText multiLineSize:ScreenWidth - kCommentTextViewLeftInset - kCommentTextViewRightInset].height;
    }
    [self updateTextViewFrame];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if([text isEqualToString:@"\n"]) {
        if(_delegate) {
            [_delegate onSendText:textView.text];
            [_placeholderLabel setHidden:NO];
            textView.text = @"";
            _textHeight = ceilf(textView.font.lineHeight);
            [textView resignFirstResponder];
        }
        return NO;
    }
    return YES;
}

//handle guesture tap
- (void)handleGuesture:(UITapGestureRecognizer *)sender {
    CGPoint point = [sender locationInView:_textView];
    if(![_textView.layer containsPoint:point]) {
        [_textView resignFirstResponder];
    }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *hitView = [super hitTest:point withEvent:event];
    if(hitView == self){
        if(hitView.backgroundColor == ColorClear) {
            return nil;
        }
    }
    return hitView;
}

//update method
- (void)show {
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    [window addSubview:self];
}

- (void)dismiss {
    [self removeFromSuperview];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
