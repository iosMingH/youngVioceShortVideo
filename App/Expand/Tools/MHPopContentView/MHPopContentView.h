//
//  MHPopContentView.h
//  App
//
//  Created by dayewang on 2020/7/13.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MHPopContentView : UIView
@property (nonatomic, strong) UIView            *contentV;
@property (nonatomic, strong) UILabel           *titieL;
@property (nonatomic, strong) UIImageView       *close;
@property (nonatomic, strong) NSArray *shouldClickClasses;

- (void)show;
- (void)dismiss;
- (instancetype)initWithHeight:(CGFloat )height withRoundSize:(CGSize )roundSize;

@end

NS_ASSUME_NONNULL_END
