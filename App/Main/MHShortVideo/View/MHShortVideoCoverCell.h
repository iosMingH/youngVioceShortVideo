//
//  MHShortVideoCoverCell.h
//  App
//
//  Created by Pro on 2020/4/8.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AliyunPlayer/AliyunPlayer.h>
#import "AlivcQuVideoModel.h"
#import "AlivcShortVideoLiveVideoModel.h"
#import "AlivcShortVideoBasicVideoModel.h"

@class Aweme;
@class FocusView;
@class MusicAlbumView;
@class FavoriteView;

NS_ASSUME_NONNULL_BEGIN

@protocol MHShortVideoMenuViewDelegate<NSObject>

-(void)MHShortVideoMenuViewDownloadAction;

-(void)MHShortVideoMenuViewDeleteAction;

@end

@interface MHShortVideoCoverCell : UICollectionViewCell
@property (nonatomic, strong) AlivcShortVideoBasicVideoModel *model;

@property (nonatomic, strong) UIImageView      *avatar;
@property (nonatomic, strong) FocusView        *focus;
@property (nonatomic, strong) MusicAlbumView   *musicAlum;

@property (nonatomic, strong) UIImageView      *share;
@property (nonatomic, strong) UIImageView      *comment;

@property (nonatomic, strong) FavoriteView     *favorite;

@property (nonatomic, strong) UILabel          *shareNum;
@property (nonatomic, strong) UILabel          *commentNum;
@property (nonatomic, strong) UILabel          *favoriteNum;


@property(nonatomic,strong)UIImageView *imageView;


- (void)addPlayer:(AliPlayer *)player;


@property(nonatomic, weak)id<MHShortVideoMenuViewDelegate> _Nullable delegate;
@end

NS_ASSUME_NONNULL_END
