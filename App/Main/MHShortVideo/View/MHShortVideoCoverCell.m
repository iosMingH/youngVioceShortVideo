//
//  MHShortVideoCoverCell.m
//  App
//
//  Created by Pro on 2020/4/8.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import "MHShortVideoCoverCell.h"
#import "FocusView.h"
#import "MusicAlbumView.h"
#import "FavoriteView.h"
#import "Aweme.h"
#import "UIImageView+WebCache.h"
#import "SharePopView.h"
#import "CommentsPopView.h"
#import "MHShareWXView.h"
#import "MHPopContentView.h"
#import "MHCourseModel.h"
#define iconWH 30

static const NSInteger kAwemeListLikeCommentTag = 0x01;
static const NSInteger kAwemeListLikeShareTag   = 0x02;

@interface MHShortVideoCoverCell ()

/**
 视频类型图
 */
@property (nonatomic, strong) UIImage *type_image;

/**
 昵称
 */
@property (nonatomic, strong) UILabel *nickNameLabel;

/**
 描述label
 */
@property (nonatomic, strong) UILabel *desLabel;

@property (nonatomic, strong) UITapGestureRecognizer   *singleTapGesture;

@property(nonatomic,strong)UIView *infoView;  //用于存放用户昵称 描述

@property(nonatomic,strong)MHChooseRelationCourseView *courseView;  //课程信息



@end

@implementation MHShortVideoCoverCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self initUI];
    
}

- (UIViewController *)getSuperController{
    
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}


- (void)initUI {
    CGFloat imageX = 0;
    CGFloat imageY = 0;
    CGFloat imageW = ScreenWidth;
    CGFloat imageH = ScreenHeight - KquTabBarHeight;
   
    self.imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
    self.imageView.userInteractionEnabled = YES;
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:self.imageView];
    
    //大叶网============
    //init music alum view

      _share = [[UIImageView alloc]init];
       _share.contentMode = UIViewContentModeCenter;
       _share.image = [UIImage imageNamed:@"p_arrow_big"];
       _share.userInteractionEnabled = YES;
     _share.tag = kAwemeListLikeShareTag;
       [_share addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)]];
     [_share resignFirstResponder];
       [self.imageView addSubview:_share];

       _shareNum = [[UILabel alloc]init];
       _shareNum.text = @"5323";
       _shareNum.textColor =  [UIColor whiteColor];
       _shareNum.font = [UIFont systemFontOfSize:AUTO(12)];
       [self.imageView addSubview:_shareNum];

       _comment = [[UIImageView alloc]init];
       _comment.contentMode = UIViewContentModeCenter;
       _comment.image = [UIImage imageNamed:@"p_message"];
       _comment.userInteractionEnabled = YES;
       _comment.tag = kAwemeListLikeCommentTag;
       [_comment addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)]];
       [_comment resignFirstResponder];
       [self.imageView addSubview:_comment];

       _commentNum = [[UILabel alloc]init];
       _commentNum.text = @"1.2W";
       _commentNum.textColor =  [UIColor whiteColor];
       _commentNum.font = [UIFont systemFontOfSize:AUTO(12)];
       [self.imageView addSubview:_commentNum];

       _favorite = [FavoriteView new];
       [self.imageView addSubview:_favorite];
       

       _favoriteNum = [[UILabel alloc]init];
       _favoriteNum.text = @"50W";
       _favoriteNum.textColor =  [UIColor whiteColor];
       _favoriteNum.font = [UIFont systemFontOfSize:AUTO(12)];
       [self.imageView addSubview:_favoriteNum];

       //init avatar
       CGFloat avatarRadius = AUTO(22);
       _avatar = [[UIImageView alloc] init];
       _avatar.image = [UIImage imageNamed:@"img_find_default"];
       _avatar.layer.cornerRadius = avatarRadius;
       _avatar.layer.borderColor =  [UIColor whiteColor].CGColor;
       _avatar.layer.borderWidth = 1;
       [self.imageView addSubview:_avatar];

    //init focus action
       _focus = [FocusView new];
       [self.imageView addSubview:_focus];
       
    
    _courseView = [[MHChooseRelationCourseView alloc]init];
    [self.imageView addSubview:_courseView];
     [_courseView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnAction:)]];
    
     _infoView = [[UIView alloc]init];
    [self.imageView addSubview:_infoView];
    
    _nickNameLabel = [[UILabel alloc]init];
    [_infoView addSubview:_nickNameLabel];
    _nickNameLabel.text = @"@老炮";
    _nickNameLabel.textColor = SK_COLOR_BASE_TITLEMAIN;
    _nickNameLabel.font = FONT(AUTO(13));
    
    _desLabel = [[UILabel alloc]init];
    [_infoView addSubview:_desLabel];
    _desLabel.numberOfLines = 2;
     _desLabel.textColor = SK_COLOR_BASE_TITLELESS;
    _desLabel.font = FONT(AUTO(12));
    //大叶网 =====================
       
}

- (void)layoutSubviews {
    [super layoutSubviews];
    __weak typeof(self) weakSelf = self;
     CGFloat avatarRadius = AUTO(22);
       //大叶网 =====================

     [_share mas_makeConstraints:^(MASConstraintMaker *make) {
         make.bottom.equalTo(self).offset(-Height_TabBar-AUTO(120));
         make.right.equalTo(self).offset(-AUTO(10));
         make.width.mas_equalTo(AUTO(50));
         make.height.mas_equalTo(AUTO(45));
     }];
       [_shareNum mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.equalTo(self.share.mas_bottom).offset(-AUTO(8));
           make.centerX.equalTo(self.share);
       }];
       [_comment mas_makeConstraints:^(MASConstraintMaker *make) {
           make.bottom.equalTo(self.share.mas_top).offset(-AUTO(25));
           make.right.equalTo(self).offset(-AUTO(10));
           make.width.mas_equalTo(AUTO(50));
           make.height.mas_equalTo(AUTO(45));
       }];
       [_commentNum mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.equalTo(self.comment.mas_bottom).offset(-AUTO(5));
           make.centerX.equalTo(self.comment);
       }];
       [_favorite mas_makeConstraints:^(MASConstraintMaker *make) {
           make.bottom.equalTo(self.comment.mas_top).offset(-AUTO(25));
           make.right.equalTo(self).offset(-AUTO(9));
           make.width.mas_equalTo(AUTO(50));
           make.height.mas_equalTo(AUTO(45));
       }];
       
       [_favoriteNum mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.equalTo(self.favorite.mas_bottom).offset(-AUTO(5));
           make.centerX.equalTo(self.favorite);
       }];
    
       [_avatar mas_makeConstraints:^(MASConstraintMaker *make) {
           make.bottom.equalTo(self.favorite.mas_top).offset(-AUTO(25));
           make.right.equalTo(self).offset(-AUTO(13));
           make.width.height.mas_equalTo(avatarRadius*2);
       }];
    
        [_focus mas_makeConstraints:^(MASConstraintMaker *make) {
          make.centerX.equalTo(self.avatar);
          make.centerY.equalTo(self.avatar.mas_bottom);
          make.width.height.mas_equalTo(AUTO(24));
      }];
    
    
    
    [_courseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-Height_TabBar-AUTO(10));
        make.height.mas_equalTo(AUTO(100));
    }];
    
    [_infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(-AUTO(50));
        make.height.mas_equalTo(AUTO(60));
        make.bottom.equalTo(weakSelf.courseView.mas_top);
    }];
    
    //描述
        [_desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SK_MARGINLR);
            make.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];
    
    //昵称
    [_nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SK_MARGINLR);
        make.right.mas_equalTo(0);
        make.bottom.equalTo(weakSelf.desLabel.mas_top);
        make.height.mas_equalTo(AUTO(30));
    }];
    
       //大叶网 =====================
}

#pragma mark - public method

- (void)addPlayer:(AliPlayer *)player {
    
    UIView *playView = player.playerView;
    UIViewController *controller = [self getSuperController];
    if ([NSStringFromClass([controller class])isEqualToString:@"MHShortVideoLivePlayViewController"]) {
        CGFloat imageX = 0;
        CGFloat imageY = 0;
        CGFloat imageW = ScreenWidth;
        CGFloat imageH = ScreenHeight;
        self.imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);

    }
    playView.frame = self.imageView.bounds;
    [self.imageView addSubview:playView];
    [self.imageView sendSubviewToBack:playView];
}

//gesture
- (void)handleGesture:(UITapGestureRecognizer *)sender {
    switch (sender.view.tag) {
        case kAwemeListLikeCommentTag: {
            CommentsPopView *popView = [[CommentsPopView alloc] initWithAwemeId:@""];
           [popView show];
//            TOAST(@"评论");
            
//            if (self.delegate && [self.delegate respondsToSelector:@selector(MHShortVideoMenuViewDownloadAction)]) {
//                   [self.delegate MHShortVideoMenuViewDownloadAction];
//               }
            break;
        }
        case kAwemeListLikeShareTag: {
//            if (self.delegate && [self.delegate respondsToSelector:@selector(MHShortVideoMenuViewDeleteAction)]) {
//                   [self.delegate MHShortVideoMenuViewDeleteAction];
//           }
            MHPopContentView *popView = [[MHPopContentView alloc]initWithHeight:AUTO(166) withRoundSize:CGSizeMake(0, 0)];

           MHShareWXView *view = [[MHShareWXView alloc]initWithFrame:CGRectMake(0, -AUTO(30), popView.contentV.width, popView.contentV.height)];
           [popView.contentV addSubview:view];

           [popView show];
            break;
        }
        default: {
            TOAST(@"其他");
            break;
        }
    }
    
}

#pragma mark - action

- (void)btnAction:(UIButton *)sender{
    
    MHCourseModel *model = [[MHCourseModel alloc]init];
    if (self.delegate && [self.delegate respondsToSelector:@selector(MHPushCourseDetailViewControllerWithModel:)]) {
           [self.delegate MHPushCourseDetailViewControllerWithModel:model];
   }
    
}

#pragma mark - setter & getter

- (void)setModel:(AlivcShortVideoBasicVideoModel *)model {
    if (!model) {
        return;
    }
    //默认遮盖图为首帧图
    BOOL isLive = NO;
//    NSString *imageUrlString = model.firstFrameUrl;
    
     NSString *imageUrlString = model.coverUrl;
//    //直播场景下遮盖图为封面图
//    if ([model isKindOfClass:[AlivcShortVideoLiveVideoModel class]]) {
//        isLive = YES;
//        imageUrlString = model.coverUrl;
//    }
    //设置图片
    __weak typeof(self) weakSelf = self;
    if (imageUrlString && imageUrlString.length >0) {
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:imageUrlString] placeholderImage:[UIImage imageNamed:@""] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            
            if(image.size.width < image.size.height&&IPHONEX) {
                weakSelf.imageView.contentMode = UIViewContentModeScaleAspectFill;
            }else {
                weakSelf.imageView.contentMode = UIViewContentModeScaleAspectFit;
            }
            //赋值给model
            if (isLive) {
                model.coverImage = image;
            }else{
                model.firstFrameImage = image;
            }
            
        }];
    }
    
    //测试是否有课程信息 到时候要修改
    if (model.title.length >= 4) {
        self.courseView.hidden = YES;
        [_infoView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.mas_equalTo(0);
            make.height.mas_equalTo(AUTO(60));
            make.bottom.mas_equalTo(-Height_TabBar-AUTO(20));
        }];
      
    }else{
        self.courseView.hidden = NO;
        [_infoView mas_remakeConstraints:^(MASConstraintMaker *make) {
           make.left.and.right.mas_equalTo(0);
           make.height.mas_equalTo(AUTO(60));
            make.bottom.equalTo(weakSelf.courseView.mas_top);
       }];
        
    }


    
    NSString *collection = [NSString stringWithFormat:@"%@",model.collection];
    if ([collection isEqualToString:@"1"]) {
        [_favorite startLikeAnim:YES];

    }else{
         [_favorite startLikeAnim:NO];

    }
    self.desLabel.text = model.title;
 
    
//底部课程信息
      [_courseView setValueModel:@"0"];
}

- (void)setSelected:(BOOL)selected {
[super setSelected:selected];
    if (selected) {

        
    }else{

    }

}

@end



#import "MHCourseModel.h"
//********************选择关联课程
@interface MHChooseRelationCourseView ()
@property(nonatomic,strong)UIImageView *coverI;
@property(nonatomic,strong)UILabel *titleL;
@property(nonatomic,strong)UILabel *contentL;
@property(nonatomic,strong)UILabel *remarkL;
@end

@implementation MHChooseRelationCourseView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        __weak typeof(self) weakSelf = self;
          _coverI = [UIImageView hyb_viewWithSuperView:self constraints:^(MASConstraintMaker *make) {
                  make.left.mas_equalTo(15);
                  make.centerY.equalTo(weakSelf);
                  make.width.mas_equalTo(AUTO(80));
                  make.height.mas_equalTo(AUTO(56));
              }];
              _coverI.backgroundColor = [UIColor grayColor];
              
              _titleL = [UILabel hyb_labelWithFont:AUTO(13) superView:self constraints:^(MASConstraintMaker *make) {
                  make.top.equalTo(weakSelf.coverI.mas_top).offset(0);
                  make.left.equalTo(weakSelf.coverI.mas_right).offset(10);
                  make.right.mas_equalTo(-10);
              }];
              _titleL.numberOfLines = 2;
              _titleL.textColor = SK_COLOR_BASE_TITLEMAIN;
              
              _contentL = [UILabel hyb_labelWithFont:AUTO(12) superView:self constraints:^(MASConstraintMaker *make) {
                  make.left.equalTo(weakSelf.coverI.mas_right).offset(10);
                  make.bottom.equalTo(weakSelf.coverI.mas_bottom);
                  make.width.mas_equalTo(AUTO(100));
              }];
              _contentL.textColor = SK_COLOR_BASE_TITLELESS;
              
              _remarkL = [UILabel hyb_labelWithFont:AUTO(15) superView:self constraints:^(MASConstraintMaker *make) {
                         make.right.mas_equalTo(-15);
                         make.bottom.equalTo(weakSelf.coverI.mas_bottom);
                         make.width.mas_equalTo(AUTO(100));
                     }];
              _remarkL.textAlignment = NSTextAlignmentRight;
              _remarkL.textColor = SK_COLOR_BASE_ORANGE;
              
    }
    return self;
}


-(void)setValueModel:(id)model{
    MHCourseModel *messagem = (MHCourseModel *)model;
//    _titleL.text = messagem.title;
//    _contentL.text = messagem.content;
//    _remarkL.text = messagem.remark;
    _titleL.text = @"六至十二岁孩童逻辑思维培养课程六至十二 岁孩童逻辑思维培养课程...";
    _contentL.text = @"课程分类";
    _remarkL.text = @"￥199";
}
@end
