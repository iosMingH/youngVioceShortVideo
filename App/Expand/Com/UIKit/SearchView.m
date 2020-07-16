//
//  SearchView.m
//  LSYC
//
//  Created by fengxiadesinian on 2018/1/29.
//  Copyright © 2018年 fengxiadesinian. All rights reserved.
//

#import "SearchView.h"
@interface SearchView()
<
UITextFieldDelegate
>
@property(nonatomic,strong)UIView *superView;
@property(nonatomic,strong)NSString *holder;
@property(nonatomic)HYBStringBlock block;
@end
@implementation SearchView
+(SearchView *)creatWithsuperView:(UIView *)superView block:(HYBStringBlock)block{
    return [SearchView creatWithPlaceholder:nil superView:superView block:block];
}
+(SearchView *)creatWithPlaceholder:(NSString *)placeholder superView:(UIView *)superView block:(HYBStringBlock)block{
 return [[[SearchView alloc]init] creatWithPlaceholder:placeholder  superView:superView  block:block];
}
-(SearchView *)creatWithPlaceholder:(NSString *)placeholder  superView:(UIView *)superView block:(HYBStringBlock)block{
    _block = block;
    _superView = superView;
    _holder = placeholder;
    [self updateUI];
    //点击其他隐藏键盘
    [self setUpForDismissKeyboard];
    return self;
}
//创建界面
-(void)updateUI{
    __weak typeof(self) weakSelf = self;
    self.backgroundColor = SK_COLOR_BASE_NAV;
    [_superView addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(weakSelf.superView);
        make.height.mas_equalTo(50);
    }];
   _searchBox  = [UITextField hyb_textFieldWithHolder:@"" superView:self constraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(UIEdgeInsetsMake(7, 15, 7, 15));
    }];
    _searchBox.tag = 12345678;
    _searchBox.delegate = self;
    _searchBox.returnKeyType = UIReturnKeySearch;
//    [_searchBox setValue:kFont(12) forKeyPath:@"_placeholderLabel.font"];
    _searchBox.attributedPlaceholder = [[NSAttributedString alloc] initWithString:_holder.length!=0?_holder:@"搜索" attributes:@{NSFontAttributeName:kFont(14)}];
    _searchBox.backgroundColor = SK_COLOR_BASE_BACKGROUND;
    [_searchBox setCorner:18.0];
    [_searchBox addTarget:self action:@selector(checkForbidText:) forControlEvents:UIControlEventEditingChanged];
    
    UIView *imv = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 15)];
    imv.contentMode = UIViewContentModeScaleAspectFit;
//    imv.image = kImage(@"搜索");
//    imv.backgroundColor = [UIColor yellowColor];
    _searchBox.leftView = imv;
    _searchBox.leftViewMode = UITextFieldViewModeAlways;
    _searchBox.clearButtonMode = UITextFieldViewModeAlways;
    
    
//    UIView *viewLine = [UIView hyb_viewWithSuperView:self constraints:^(MASConstraintMaker *make) {
//        make.left.right.bottom.mas_equalTo(self);
//        make.height.mas_equalTo(0.5);
//    }];
//    viewLine.backgroundColor = SK_COLOR_BASE_BACKGROUND;
   


}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    _block(textField.text);
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (_endEdit) {
        _endEdit(textField.text);
    }
}

- (void)checkForbidText:(UITextField *)textField{
    if (textField.text.hyb_trim.length == 0) {
        _block(@"");
    }else{
        NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"\\/*<>&|\t^%%~+-= "];
        NSString *oriStr = textField.text;
        NSString *string = [oriStr substringWithRange:NSMakeRange(oriStr.length-1, 1)];
        
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length > 0) {
            textField.text = [oriStr substringToIndex:oriStr.length-1];
        }

    }
}


- (void)setUpForDismissKeyboard {
    __weak typeof(self) weakSelf = self;
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    UITapGestureRecognizer *singleTapGR =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAnywhereToDismissKeyboard:)];
    NSOperationQueue *mainQuene =[NSOperationQueue mainQueue];
    [nc addObserverForName:UIKeyboardWillShowNotification
                    object:nil
                     queue:mainQuene
                usingBlock:^(NSNotification *note){
                    [weakSelf.superView addGestureRecognizer:singleTapGR];
                }];
    [nc addObserverForName:UIKeyboardWillHideNotification
                    object:nil
                     queue:mainQuene
                usingBlock:^(NSNotification *note){
                    [weakSelf.superView removeGestureRecognizer:singleTapGR];
                }];
}

- (void)tapAnywhereToDismissKeyboard:(UIGestureRecognizer *)gestureRecognizer {
    //此method会将self.view里所有的subview的first responder都resign掉
    [_superView endEditing:YES];
}



@end
