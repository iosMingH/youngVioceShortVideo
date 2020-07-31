//
//  MHCoursePlayView.m
//  App
//
//  Created by dayewang on 2020/7/10.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import "MHCoursePlayView.h"

@interface MHCoursePlayView()
@property(nonatomic,strong)UILabel *titleL;
@property(nonatomic,strong)UILabel *contentL;
@property(nonatomic,strong)UIView *playView;
@property(nonatomic,strong)UIView *infoView;


@end

@implementation MHCoursePlayView

- (void)initControl{
    
//    UIView *playView = [UIView hyb_viewWithSuperView:self constraints:^(MASConstraintMaker *make) {
//        make.left.and.right.and.top.mas_equalTo(0);
//        make.height.mas_equalTo(AUTO(210));
//    }];
//    playView.backgroundColor = [UIColor grayColor];
//    _playView = playView;
    
    UIView *infoView = [UIView hyb_viewWithSuperView:self constraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(playView.mas_bottom);
        make.top.mas_equalTo(0);
        make.left.and.right.and.bottom.mas_equalTo(0);
    }];
    infoView.backgroundColor = [UIColor whiteColor];
    _infoView = infoView;
    
    [self initPlayView];
    [self initInfoView];
}

- (void)initPlayView{
    
}

- (void)initInfoView{
    
    UILabel *titleL = [UILabel hyb_labelWithFont:AUTO(16) superView:_infoView constraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SK_MARGINLR);
        make.top.mas_equalTo(AUTO(10));
        make.right.mas_equalTo(-SK_MARGINLR);
    }];
    titleL.textColor = [UIColor blackColor];
    self.titleL = titleL;
    self.titleL.text = @"试听课：如何获得基础流量";
    
    UILabel *contentL = [UILabel hyb_labelWithFont:AUTO(11) superView:_infoView constraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SK_MARGINLR);
        make.top.equalTo(titleL.mas_bottom).offset(AUTO(5));
        make.right.mas_equalTo(-SK_MARGINLR);
    }];
    contentL.textColor = SK_COLOR_BASE_TEXT_GRAY;
    self.contentL = contentL;
     self.contentL.text = @"已观看人数：91220";
}


-(void)setModel:(id)model section:(NSInteger )section{
    
    self.titleL.text = @"试听课：如何获得基础流量";
    self.contentL.text = @"已观看人数：91220";
    
}

@end
