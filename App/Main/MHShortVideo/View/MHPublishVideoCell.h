//
//  MHPublishVideoCell.h
//  App
//
//  Created by dayewang on 2020/7/27.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


//话题
@interface MHPublishVideoCell : UICollectionViewCell
@property(nonatomic,strong)UILabel *lblName;
-(void)setModel:(id)model indexPath:(NSIndexPath *)indexPath;
@end

// 视频描述  图片
@interface MHPublishHeadView : UICollectionReusableView
-(void)setModel:(id)model indexPath:(NSIndexPath *)indexPath;
@end

//标题
@interface MHPublishTitleHeadView : UICollectionReusableView
-(void)setModel:(id)model indexPath:(NSIndexPath *)indexPath;
@end


NS_ASSUME_NONNULL_END
