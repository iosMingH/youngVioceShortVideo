

//
//  NavSearchView.m
//  LSYC
//
//  Created by fengxiadesinian on 2018/6/26.
//  Copyright © 2018年 fengxiadesinian. All rights reserved.
//

#import "NavSearchView.h"
@interface NavSearchView ()
<
UITextFieldDelegate
>

@property(nonatomic,strong)UIImageView *imgSearch;
@property(nonatomic,strong)UIView *vwBg;
@property(nonatomic,strong)UIView *vwSuperview;
@property(nonatomic,strong)UITextField *tfSearch;
@property(nonatomic)HYBStringBlock block;
@property(nonatomic,strong)CEBaseController *fn;
@end

@implementation NavSearchView
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, DEVICEWIDTH , 35);
        self.backgroundColor = SK_COLOR_BASE_BACKGROUND;
        [self setCorner:self.height/2.0];
        _imgSearch = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 15, 15)];
        _imgSearch.centerY = self.centerY;
        _imgSearch.image = kImage(@"搜索");
        [self addSubview:_imgSearch];
        
        _tfSearch = [[UITextField alloc]initWithFrame:CGRectMake(_imgSearch.right +5, 0, self.width - _imgSearch.right - 20-100, self.height)];
//        _tfSearch.placeholder = @"";
        _tfSearch.font = kFont(13);
        _tfSearch.delegate = self;
        _tfSearch.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self addSubview:_tfSearch];
    }
    return self;
}


+(NavSearchView *)creatViewWithVC:(CEBaseController *)vc placeholder:(NSString *)placeHolder block:(HYBStringBlock)block{
    return   [[[NavSearchView alloc]init]creatViewWithVC:vc placeholder:placeHolder block:block];
}
-(NavSearchView *)creatViewWithVC:(CEBaseController *)vc placeholder:(NSString *)placeHolder block:(HYBStringBlock)block{
    kWeakObject(self);
    vc.navigationItem.titleView = self;
    _block = block;
    _tfSearch.placeholder = placeHolder;
    _vwBg = [UIView hyb_viewWithSuperView:vc.view constraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(vc.view);
    } onTaped:^(UITapGestureRecognizer *sender) {
        [weakObject.tfSearch resignFirstResponder];
        weakObject.vwBg.hidden = YES;
    }];
    _vwBg.hidden = YES;
    _vwBg.backgroundColor = [UIColor colorWithWhite:0 alpha:0.33];
    
    return self;
}




-(void)textFieldDidBeginEditing:(UITextField *)textField{
//    if (self.vwBg.hidden) {
        self.vwBg.hidden = NO;
//    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    self.vwBg.hidden = YES;
    _block(textField.text);
    return YES;
}


@end
