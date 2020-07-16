//
//  MMEditView.m
//  LSYC
//
//  Created by fengxiadesinian on 2018/1/16.
//  Copyright © 2018年 fengxiadesinian. All rights reserved.
//

#import "MMEditView.h"

#define kAltWidth 300
@interface MMEditView()

@end
@implementation MMEditView
+(MMEditView *)creatAltViewWithTitle:(NSString *)title detail:(NSString *)detail arrTitles:(NSArray *)arrTitles block:(EditIndexBlock)block{
   return  [MMEditView creatEditViewWithTitle:title detail:detail text:nil holder:nil arrTitles:arrTitles block:block];
}


+(MMEditView *)creatEditViewWithTitle:(NSString *)title detail:(NSString *)detail text:(NSString *)text holder:(NSString *)holder arrTitles:(NSArray *)arrTitles block:(EditIndexBlock)block{
    return  [MMEditView creatEditViewWithTitle:title detail:detail text:text  holder:holder unit:nil arrTitles:arrTitles block:block];
}
+(MMEditView *)creatEditViewWithTitle:(NSString *)title detail:(NSString *)detail text:(NSString *)text holder:(NSString *)holder unit:(NSString *)unit arrTitles:(NSArray *)arrTitles block:(EditIndexBlock)block{
    return  [[[MMEditView alloc]init] creatEditViewWithTitle:title detail:detail text:text holder:holder unit:unit arrTitles:arrTitles block:block];
}
-(MMEditView *)creatEditViewWithTitle:(NSString *)title detail:(NSString *)detail text:(NSString *)text holder:(NSString *)holder unit:(NSString *)unit arrTitles:(NSArray *)arrTitles block:(EditIndexBlock)block{
    kWeakObject(self);
    //点击背景隐藏
    [MMPopupWindow sharedWindow].touchWildToHide = YES;
    self.type = MMPopupTypeAlert;
    self.backgroundColor = kWhiteColor;
    [self setCorner:10];
    UIView *currentView;
    if (title.hyb_trim.length !=0) {
        _lblTitle = [UILabel hyb_labelWithText:title font:18 superView:self constraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(20);
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.centerX.mas_equalTo(self);
        }];
        _lblTitle.numberOfLines = 0;
        _lblTitle.textAlignment = NSTextAlignmentCenter;
        _lblTitle.textColor = k333Color;
        
        currentView = _lblTitle;
    }
    if (detail.hyb_trim.length != 0) {
        _lblDetail = [UILabel hyb_labelWithText:detail font:15 superView:self constraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(currentView.mas_bottom).offset(11);
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.centerX.mas_equalTo(self);
        }];
        _lblDetail.numberOfLines = 0;
        _lblDetail.textAlignment = NSTextAlignmentCenter;
        _lblDetail.textColor = k666Color;
        
        currentView = _lblDetail;
    }
    
    UIView *viewTfBack;
    if (holder.hyb_trim.length != 0) {
        viewTfBack = [UIView hyb_viewWithSuperView:self constraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(currentView.mas_bottom).offset(15);
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.centerX.mas_equalTo(self);
            make.height.mas_equalTo(44);
        }];
        [viewTfBack setCorner:5];
        viewTfBack.backgroundColor = kBackColor;
        
        currentView = viewTfBack;
        
        if (unit.hyb_trim.length !=0) {
          _lblUnit =   [UILabel hyb_labelWithText:unit font:13 superView:viewTfBack constraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(viewTfBack);
                make.right.mas_equalTo(viewTfBack).offset(-5);
                make.width.mas_equalTo(40);
            }];
            _lblUnit.textColor = k333Color;
        }
        
        _tfEdit = [UITextField hyb_textFieldWithHolder:holder text:text delegate:self superView:viewTfBack constraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(viewTfBack).offset(15);
            if (_lblUnit) {
                make.right.mas_equalTo(_lblUnit.mas_left).offset(-5);
            }else {
                make.right.mas_equalTo(viewTfBack).offset(-5);
            }
            make.top.bottom.mas_equalTo(viewTfBack);
        }];
        _tfEdit.font = kFont(13);
        _tfEdit.keyboardType = UIKeyboardTypeDecimalPad;
        _tfEdit.clearButtonMode = UITextFieldViewModeWhileEditing;
        [_tfEdit addTarget:self action:@selector(checkForbidText:) forControlEvents:UIControlEventEditingChanged];
    }
    
    UIView *viewLineTop = [UIView hyb_viewWithSuperView:self constraints:^(MASConstraintMaker *make) {
        //        if (holder.hyb_trim.length == 0) {
        //           make.top.mas_equalTo(currentView.mas_bottom).offset(15);
        //        }else{
        make.top.mas_equalTo(currentView.mas_bottom).offset(15);
        //        }
        
        make.left.right.mas_equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
    viewLineTop.backgroundColor = kLineColor;
    
    for (NSInteger i =0 ; i < arrTitles.count; i++) {
        UIButton *btn = [UIButton hyb_buttonWithTitle:arrTitles[i] superView:self constraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(i*(kAltWidth/arrTitles.count));
            make.top.mas_equalTo(viewLineTop);
            make.height.mas_equalTo(50);
            make.width.mas_equalTo((kAltWidth/arrTitles.count)-1);
        } touchUp:^(UIButton *sender) {
                if (block) {
                    block(i,sender,_tfEdit.text);
                }
                [weakObject hide];
        }];
        [btn setTitleColor:kMainColor forState:UIControlStateNormal];
        if (i!=arrTitles.count -1) {
            UIView *viewLineCenter = [UIView hyb_viewWithSuperView:self constraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(btn.mas_right);
                make.top.mas_equalTo(viewLineTop);
                make.height.mas_equalTo(50);
                make.width.mas_equalTo(0.5);
            }];
            viewLineCenter.backgroundColor = kLineColor;
        }
    }
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kAltWidth);
        make.bottom.mas_equalTo(viewLineTop).offset(50);
    }];
    
    [self show];
    return self;
}


//拒绝的弹窗
+(MMEditView *)creatRefuseAltViewWithTitle:(NSString *)title holder:(NSString *)holder arrTitles:(NSArray *)arrTitles block:(EditIndexBlock)block{
  return  [[[MMEditView alloc]init]creatRefuseAltViewWithTitle:title holder:holder arrTitles:arrTitles block:block];
}


-(MMEditView *)creatRefuseAltViewWithTitle:(NSString *)title holder:(NSString *)holder arrTitles:(NSArray *)arrTitles block:(EditIndexBlock)block{
    kWeakObject(self);
    //点击背景隐藏
    [MMPopupWindow sharedWindow].touchWildToHide = NO;
    
    self.type = MMPopupTypeAlert;
    self.backgroundColor = kWhiteColor;
    [self setCorner:4];
    UIView *currentView;
    if (title.hyb_trim.length !=0) {
        _lblTitle = [UILabel hyb_labelWithText:title font:18 superView:self constraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(20);
            make.left.mas_equalTo(15);
            make.left.mas_equalTo(-15);
            make.centerX.mas_equalTo(self);
        }];
        _lblTitle.textAlignment = NSTextAlignmentCenter;
        _lblTitle.textColor = k333Color;
        
        currentView = _lblTitle;
    }

    
    

    
    
   UIView *viewTfBack = [UIView hyb_viewWithSuperView:self constraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_lblTitle.mas_bottom).offset(15);
        make.right.mas_equalTo(-15);
        make.left.mas_equalTo(15);
        make.height.mas_equalTo(93);
    }];
    [viewTfBack setCorner:5];
    viewTfBack.backgroundColor = kBackColor;
        
    currentView = viewTfBack;
    
    
    
    _tvRefuse = [UITextView hyb_viewWithSuperView:viewTfBack constraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 5, 0, 5));
    }];
    _tvRefuse.backgroundColor = kBackColor;
    [_tvRefuse setCorner:5];
    
    _tvRefuse.placeholder = @"请填写拒绝原因";
    
    
    UIView *viewLineTop = [UIView hyb_viewWithSuperView:self constraints:^(MASConstraintMaker *make) {
        //        if (holder.hyb_trim.length == 0) {
        //           make.top.mas_equalTo(currentView.mas_bottom).offset(15);
        //        }else{
        make.top.mas_equalTo(currentView.mas_bottom).offset(15);
        //        }
        
        make.left.right.mas_equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
    viewLineTop.backgroundColor = kLineColor;
    
    for (NSInteger i =0 ; i < arrTitles.count; i++) {
        UIButton *btn = [UIButton hyb_buttonWithTitle:arrTitles[i] superView:self constraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(i*(kAltWidth/arrTitles.count));
            make.top.mas_equalTo(viewLineTop);
            make.height.mas_equalTo(50);
            make.width.mas_equalTo((kAltWidth/arrTitles.count)-1);
        } touchUp:^(UIButton *sender) {
            if (i == 0) {
                [weakObject hide];
            }else{
                if (_tvRefuse.text.length == 0) {
//                    [TWProgressHUD showMessage:@"请填写拒绝原因" inView:self];
                }else{
                    [weakObject hide];
                    if (block) {
                        block(i,sender,_tvRefuse.text);
                    }
                }
            }
        }];
        [btn setTitleColor:kMainColor forState:UIControlStateNormal];
        if (i!=arrTitles.count -1) {
            UIView *viewLineCenter = [UIView hyb_viewWithSuperView:self constraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(btn.mas_right);
                make.top.mas_equalTo(viewLineTop);
                make.height.mas_equalTo(50);
                make.width.mas_equalTo(0.5);
            }];
            viewLineCenter.backgroundColor = kLineColor;
        }
    }
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kAltWidth);
        make.bottom.mas_equalTo(viewLineTop).offset(50);
    }];
    
    [self show];
    return self;
}
/**
 创建actionSheet;

 @param cacelTitle 取消按钮
 @param arrTitles 按钮标题
 @param block 点击返回
 */
+(MMEditView *)creatSheetViewWithArrTitles:(NSArray *)arrTitles block:(HYBButtonIndexBlock)block{
  return   [MMEditView creatSheetViewWithCacelTitle:nil arrTitles:arrTitles block:block];
}
+(MMEditView *)creatSheetViewWithCacelTitle:(NSString *)cacelTitle arrTitles:(NSArray *)arrTitles block:(HYBButtonIndexBlock)block{
  return  [[[MMEditView alloc]init]creatSheetViewWithCacelTitle:cacelTitle arrTitles:arrTitles block:block];
    
}
-(MMEditView *)creatSheetViewWithCacelTitle:(NSString *)cacelTitle arrTitles:(NSArray *)arrTitles block:(HYBButtonIndexBlock)block{
    kWeakObject(self);
    //点击背景隐藏
    [MMPopupWindow sharedWindow].touchWildToHide = YES;
    self.type = MMPopupTypeSheet;
//    self.backgroundColor = kBackColor;
    
    UIButton *btnLast;//最后一个按钮
    UIView *viewbtnBG = [UIView hyb_viewWithSuperView:self constraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(arrTitles.count*50);
    }];
    viewbtnBG.backgroundColor = kWhiteColor;
    [viewbtnBG setCorner:10];
    for (NSInteger i =0 ; i < arrTitles.count; i++) {
        UIButton *btn = [UIButton hyb_buttonWithTitle:arrTitles[i] superView:viewbtnBG constraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(i*50);
            make.height.mas_equalTo(50);
        } touchUp:^(UIButton *sender) {
            [weakObject hide];
            if (block) {
                block(i,sender);
            }
        }];
        btn.backgroundColor = kWhiteColor;
        [btn setTitleColor:kMainColor forState:UIControlStateNormal];
        btn.titleLabel.font = kFont(15);
        
        [UIView hyb_addBottomLineToView:btn height:0.5 color:kLineColor];
        if (i == arrTitles.count -1) { //最后一个按钮
            btnLast = btn;
        }

    }
//    [viewbtnBG mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.bottom.mas_equalTo(btnLast.bottom);
//    }];
//
    UIButton *btnCacel = [UIButton hyb_buttonWithTitle:cacelTitle?cacelTitle:@"取消" superView:self constraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(viewbtnBG.mas_bottom).offset(10);
        make.height.mas_equalTo(50);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
//        make.left.right.mas_equalTo(0);
    } touchUp:^(UIButton *sender) {
        [weakObject hide];
    }];
    btnCacel.titleLabel.font = kFont(15);
    [btnCacel setTitleColor:k333Color forState:UIControlStateNormal];
    btnCacel.backgroundColor = kWhiteColor;
    [btnCacel setCorner:10];
    
    [UIView hyb_addTopLineToView:btnCacel height:0.5 color:kLineColor];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kScreenWidth);
        make.bottom.mas_equalTo(btnCacel.mas_bottom).offset(kBottomHeight+10);
    }];

    
    
    [self show];
    return self;
}



/**
 计算放贷额

 @param arrTitles 标题
 @param value 估值
 @param block 返回
 @return
 */
+(MMEditView *)creatCalculationViewWithArrTitles:(NSArray *)arrTitles safeValue:(NSString *)safeValue value:(NSString *)value sale:(NSString*)sale block:(CalculationBlock)block;{
    return [[[MMEditView alloc]init]creatCalculationViewWithArrTitles:arrTitles safeValue:safeValue value:value sale:sale block:block];
}
-(MMEditView *)creatCalculationViewWithArrTitles:(NSArray *)arrTitles safeValue:(NSString *)safeValue value:(NSString *)value sale:(NSString *)sale block:(CalculationBlock)block;{
    kWeakObject(self);
    //点击背景隐藏
    _safeValue = safeValue;
    _value = value;
    [MMPopupWindow sharedWindow].touchWildToHide = YES;
    self.type = MMPopupTypeAlert;
    self.backgroundColor = kWhiteColor;
    [self setCorner:4];
    UILabel *lblTitle = [UILabel hyb_labelWithText:@"计算出资额" font:18 superView:self constraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.centerX.mas_equalTo(self);
    }];
    lblTitle.numberOfLines = 0;
    lblTitle.textAlignment = NSTextAlignmentCenter;
    lblTitle.textColor = k333Color;
    
    
    UILabel *lblValue = [UILabel hyb_labelWithText:LSString(@"估值：%.2f元",[value floatValue]) font:15 superView:self constraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(lblTitle.mas_bottom).offset(10);
    }];
    UILabel *lblLendingScale = [UILabel hyb_labelWithText:@"出资比例：" font:15 superView:self constraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(lblValue.mas_bottom).offset(10);
    }];
    
    UIView *viewBg = [UIView hyb_viewWithSuperView:self constraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(lblLendingScale);
        make.left.mas_equalTo(lblLendingScale.mas_right);
        make.height.mas_equalTo(38);
        make.width.mas_equalTo(100);
    }];
    viewBg.backgroundColor = kBackColor;
    [viewBg setCorner:2];
    
    UITextField *tfInput = [UITextField hyb_viewWithSuperView:viewBg constraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.top.bottom.mas_equalTo(0);
        make.right.mas_equalTo(-15);
    }];
    if(sale){
       tfInput.text = LSString(@"%.2f",[sale floatValue]*100);
    }
    
    tfInput.font = kFont(15);
    tfInput.keyboardType = UIKeyboardTypeDecimalPad;
    tfInput.backgroundColor = kClearColor;
    tfInput.clearButtonMode = UITextFieldViewModeWhileEditing;
    tfInput.delegate = self;
    [tfInput addTarget:self action:@selector(tfChange:) forControlEvents:UIControlEventEditingChanged];
    
     [UILabel hyb_labelWithText:@"%" font:15 superView:viewBg constraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(viewBg);
        make.right.mas_equalTo(-10);
    }];
    
    NSString *lending = LSString(@"出资额：%.2f元",[sale floatValue]*0.01*[value floatValue]);
    _lblLending = [UILabel hyb_labelWithText:lending font:15 superView:self constraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lblLendingScale.mas_bottom).offset(10);
        make.left.mas_equalTo(15);
    }];

    UIView *viewLineTop = [UIView hyb_viewWithSuperView:self constraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_lblLending.mas_bottom).offset(15);
        make.left.right.mas_equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
    viewLineTop.backgroundColor = kLineColor;
    for (NSInteger i =0 ; i < arrTitles.count; i++) {
        UIButton *btn = [UIButton hyb_buttonWithTitle:arrTitles[i] superView:self constraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(i*(kAltWidth/arrTitles.count));
            make.top.mas_equalTo(viewLineTop);
            make.height.mas_equalTo(50);
            make.width.mas_equalTo((kAltWidth/arrTitles.count)-1);
        } touchUp:^(UIButton *sender) {
            if (i == 1) {
                if (tfInput.text.hyb_trim.length == 0) {
                    [MMEditView creatAltViewWithTitle:@"提示" detail:@"请输入出资比例" arrTitles:@[@"确定"] block:^(NSUInteger index, UIButton *sender, NSString *stfstring) {
                    }];
                    return ;
                }
                NSString *str = LSString(@"%.2f", [value integerValue] *[tfInput.text floatValue]*0.01);
                if (block) {
                    block([tfInput.text floatValue]*0.01,str);
                }
            }
            [weakObject hide];
        }];
        [btn setTitleColor:kMainColor forState:UIControlStateNormal];
        if (i!=arrTitles.count -1) {
            UIView *viewLineCenter = [UIView hyb_viewWithSuperView:self constraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(btn.mas_right);
                make.top.mas_equalTo(viewLineTop);
                make.height.mas_equalTo(50);
                make.width.mas_equalTo(0.5);
            }];
            viewLineCenter.backgroundColor = kLineColor;
        }
    }
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kAltWidth);
        make.bottom.mas_equalTo(viewLineTop).offset(50);
    }];
    [self show];
    return self;
}

-(void)tfChange:(UITextField *)tf{
    if ([tf.text floatValue]>100) {
        tf.text = [tf.text substringToIndex:2];
    }
    float sale = [tf.text floatValue]*0.01;
    _lblLending.text = LSString(@"出资额：%.2f元",sale*[_value floatValue]);
}

-(void)checkForbidText:(UITextField *)textField{
    //      禁止输入无关字符
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"\\/*<>&|\t^%%~+= "];
    NSString *oriStr = textField.text;
    NSString *string = [oriStr substringWithRange:NSMakeRange(oriStr.length-1, 1)];
    
    NSRange range = [string rangeOfCharacterFromSet:tmpSet];
    if (range.length > 0) {
        textField.text = [oriStr substringToIndex:oriStr.length-1];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    //删除处理
    if ([string isEqualToString:@""]) {
        return YES;
    }
    //首位不能为.号
    if (range.location == 0 && [string isEqualToString:@"."]) {
        return NO;
    }
    return [self isRightInPutOfString:textField.text withInputString:string range:range];
}
- (BOOL)isRightInPutOfString:(NSString *) string withInputString:(NSString *) inputString range:(NSRange) range{
    if (_inputType == InputTextTypeAnyWord) {
        return YES;
    }else {
        //判断只输出数字和.号
        NSString *passWordRegex = @"[0-9\\.]";
        NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
        if (![passWordPredicate evaluateWithObject:inputString]) {
            return NO;
        }
        if (_inputType == InputTextTypePercent) {
            //逻辑处理
            if ([string floatValue] > 99.99999) {
                return NO;
            }
        }
    }
    
    if ([string containsString:@"."]) {
        if ([inputString isEqualToString:@"."]) {
            return NO;
        }
        NSRange subRange = [string rangeOfString:@"."];
        if (range.location - subRange.location > 2) {
            return NO;
        }
    }
    return YES;
}



@end
