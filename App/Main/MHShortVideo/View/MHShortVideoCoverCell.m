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
#define iconWH 30

static const NSInteger kAwemeListLikeCommentTag = 0x01;
static const NSInteger kAwemeListLikeShareTag   = 0x02;

@interface MHShortVideoCoverCell ()

/**
 视频类型图
 */
@property (nonatomic, strong) UIImage *type_image;


/**
 展示视频类型UIImageView
 */
@property (nonatomic, strong) UIImageView *typeImageView;

/**
 用户头像
 */
@property (nonatomic, strong) UIImageView *avatarImageView;

/**
 昵称
 */
@property (nonatomic, strong) UILabel *nickNameLabel;

/**
 描述label
 */
@property (nonatomic, strong) UILabel *desLabel;

/**
 描述label
 */
@property (nonatomic, strong) UIImageView *zaidaiImageView;

@property (nonatomic, strong) UITapGestureRecognizer   *singleTapGesture;

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
    [self.imageView addSubview:self.typeImageView];
    [self.imageView addSubview:self.zaidaiImageView];
    [self.imageView addSubview:self.avatarImageView];
    [self.imageView addSubview:self.desLabel];
    [self.imageView addSubview:self.nickNameLabel];

    
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
       _shareNum.text = @"0";
       _shareNum.textColor =  [UIColor whiteColor];
       _shareNum.font = [UIFont systemFontOfSize:12.0];
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
       _commentNum.text = @"0";
       _commentNum.textColor =  [UIColor whiteColor];
       _commentNum.font = [UIFont systemFontOfSize:12.0];
       [self.imageView addSubview:_commentNum];

       _favorite = [FavoriteView new];
       [self.imageView addSubview:_favorite];
       

       _favoriteNum = [[UILabel alloc]init];
       _favoriteNum.text = @"0";
       _favoriteNum.textColor =  [UIColor whiteColor];
       _favoriteNum.font = [UIFont systemFontOfSize:12.0];
       [self.imageView addSubview:_favoriteNum];

       //init avatar
       CGFloat avatarRadius = 25;
       _avatar = [[UIImageView alloc] init];
       _avatar.image = [UIImage imageNamed:@"img_find_default"];
       _avatar.layer.cornerRadius = avatarRadius;
       _avatar.layer.borderColor =  [UIColor whiteColor].CGColor;
       _avatar.layer.borderWidth = 1;
       [self.imageView addSubview:_avatar];

    //init focus action
       _focus = [FocusView new];
       [self.imageView addSubview:_focus];
       

    //大叶网 =====================
       
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.typeImageView.center = CGPointMake(ScreenWidth - iconWH/2 - 16, iconWH/2 + 8 + SafeTop);
    
     CGFloat avatarRadius = 25;
       //大叶网 =====================

     [_share mas_makeConstraints:^(MASConstraintMaker *make) {
         make.bottom.equalTo(self).offset(-110);
         make.right.equalTo(self).offset(-10);
         make.width.mas_equalTo(50);
         make.height.mas_equalTo(45);
     }];
       [_shareNum mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.equalTo(self.share.mas_bottom);
           make.centerX.equalTo(self.share);
       }];
       [_comment mas_makeConstraints:^(MASConstraintMaker *make) {
           make.bottom.equalTo(self.share.mas_top).offset(-25);
           make.right.equalTo(self).offset(-10);
           make.width.mas_equalTo(50);
           make.height.mas_equalTo(45);
       }];
       [_commentNum mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.equalTo(self.comment.mas_bottom);
           make.centerX.equalTo(self.comment);
       }];
       [_favorite mas_makeConstraints:^(MASConstraintMaker *make) {
           make.bottom.equalTo(self.comment.mas_top).offset(-25);
           make.right.equalTo(self).offset(-10);
           make.width.mas_equalTo(50);
           make.height.mas_equalTo(45);
       }];
       
       [_favoriteNum mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.equalTo(self.favorite.mas_bottom);
           make.centerX.equalTo(self.favorite);
       }];
       [_avatar mas_makeConstraints:^(MASConstraintMaker *make) {
           make.bottom.equalTo(self.favorite.mas_top).offset(-35);
           make.right.equalTo(self).offset(-10);
           make.width.height.mas_equalTo(avatarRadius*2);
       }];
    
        [_focus mas_makeConstraints:^(MASConstraintMaker *make) {
          make.centerX.equalTo(self.avatar);
          make.centerY.equalTo(self.avatar.mas_bottom);
          make.width.height.mas_equalTo(24);
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
//           TOAST(@"分享");
//            SharePopView *popView = [[SharePopView alloc] init];
//            [popView show];
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(MHShortVideoMenuViewDeleteAction)]) {
                   [self.delegate MHShortVideoMenuViewDeleteAction];
           }
            break;
        }
        default: {
            TOAST(@"其他");
            break;
        }
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
    //直播场景下遮盖图为封面图
    if ([model isKindOfClass:[AlivcShortVideoLiveVideoModel class]]) {
        isLive = YES;
        imageUrlString = model.coverUrl;
    }
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

    CGFloat beside = 12;
    CGFloat cyFirst = ScreenHeight - 120 - SafeAreaBottom;
    self.avatarImageView.center = CGPointMake(beside + self.avatarImageView.frame.size.width / 2 ,cyFirst);
    //头像
    if (model.belongUserAvatarImage) {
        self.avatarImageView.hidden = NO;
        self.avatarImageView.image = model.belongUserAvatarImage;
    }else if (model.belongUserAvatarUrl){
        [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:model.belongUserAvatarUrl]];
    }else{
        self.avatarImageView.hidden = YES;
    }
    //昵称
    if (model.belongUserName) {
        self.nickNameLabel.hidden = NO;
        self.nickNameLabel.text = model.belongUserName;
        [self.nickNameLabel sizeToFit];
        self.nickNameLabel.center = CGPointMake(CGRectGetMaxX(self.avatarImageView.frame) + beside + self.nickNameLabel.frame.size.width / 2, self.avatarImageView.center.y);
    }else{
        self.nickNameLabel.hidden = YES;
    }
    
    //描述
//    model.videoDescription
    if (model.title) {
        self.desLabel.hidden = NO;
        self.desLabel.text = model.title;
        [self.desLabel sizeToFit];
        self.desLabel.center = CGPointMake(beside + self.desLabel.frame.size.width / 2, CGRectGetMaxY(self.avatarImageView.frame) + beside + self.desLabel.frame.size.height / 2);
    }else{
        self.desLabel.hidden = YES;
    }
    self.zaidaiImageView.hidden = YES;
    
    NSString *collection = [NSString stringWithFormat:@"%@",model.collection];
    if ([collection isEqualToString:@"1"]) {
        [_favorite startLikeAnim:YES];

    }else{
         [_favorite startLikeAnim:NO];

    }
    
    if ([model isKindOfClass:[AlivcQuVideoModel class]]) {
        AlivcQuVideoModel *quModel = (AlivcQuVideoModel *)model;
        if (quModel.narrowTranscodeStatusString && quModel.narrowTranscodeStatusString.length >0) {
             self.zaidaiImageView.hidden = NO;
        }
  
       
    }
    
    if ([model isKindOfClass:[AlivcShortVideoLiveVideoModel class]]) {

        self.typeImageView.image= [UIImage imageNamed:@"alivc_icon_play_liveOnline"];
            return;
    }
    
}

- (void)setSelected:(BOOL)selected {
[super setSelected:selected];
    if (selected) {

        
    }else{

    }

}


- (UIImageView *)avatarImageView{
    if (!_avatarImageView) {
        _avatarImageView = [[UIImageView alloc]init];
        _avatarImageView.frame = CGRectMake(0, 0, 36, 36);
        _avatarImageView.layer.cornerRadius = 4;
        _avatarImageView.clipsToBounds = YES;
        _avatarImageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _avatarImageView;
}

- (UILabel *)nickNameLabel{
    if (!_nickNameLabel) {
        _nickNameLabel = [[UILabel alloc]init];
        _nickNameLabel.textColor = [UIColor whiteColor];
        _nickNameLabel.frame = CGRectMake(0, 0, 100, 30);
    }
    return _nickNameLabel;
}

- (UILabel *)desLabel{
    if (!_desLabel) {
        _desLabel = [[UILabel alloc]init];
        _desLabel.textColor = [UIColor whiteColor];
        _desLabel.frame = CGRectMake(0, 0, 150, 30);
        _desLabel.font = [UIFont systemFontOfSize:12];
    }
    return _desLabel;
}

- (UIImageView *)typeImageView {
    if (!_typeImageView) {
        _typeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, iconWH, iconWH)];
        _typeImageView.backgroundColor = [UIColor clearColor];
        _typeImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _typeImageView;
}

- (UIImageView *)zaidaiImageView {
    
    if (!_zaidaiImageView) {
        _zaidaiImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"alivc_little_icon_narrowband"]];
        [_zaidaiImageView sizeToFit];
        _zaidaiImageView.center = CGPointMake(15 + _zaidaiImageView.frame.size.width / 2, SafeTop + 22);
       
    }
    return _zaidaiImageView;
}

@end
