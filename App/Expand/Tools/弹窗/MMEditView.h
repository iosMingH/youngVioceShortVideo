//
//  MMEditView.h
//  LSYC
//
//  Created by fengxiadesinian on 2018/1/16.
//  Copyright © 2018年 fengxiadesinian. All rights reserved.
//

//#import <MMPopupView/MMPopupView.h>
typedef void(^EditIndexBlock)(NSUInteger index, UIButton *sender,NSString *stfstring);
typedef void(^CalculationBlock)(float sale,NSString *stfstring);
typedef enum InputTextType{
    InputTextTypeAnyWord=0,           //文字
    InputTextTypeOnlyNumber,              //加载菊花
    InputTextTypePercent
}InputTextType;
@interface MMEditView : MMPopupView
<
UITextFieldDelegate
>
@property(nonatomic,assign)InputTextType inputType;
@property(nonatomic,strong)UILabel *lblTitle;
@property(nonatomic,strong)UILabel *lblDetail;
@property(nonatomic,strong)UILabel *lblUnit; //单位 编辑的时候右边有可能有单位
@property(nonatomic,strong)UITextField *tfEdit;
@property(nonatomic,strong)UITextView  *tvRefuse; //拒绝时的弹窗
@property(nonatomic,strong) UILabel *lblLending;//放贷额
@property(nonatomic,strong)NSString *safeValue;//安全值 计算放贷额用的
@property(nonatomic,strong)NSString *value;//估值
@property(nonatomic,strong)NSString *slending;//放贷额





//正常的弹窗
+(MMEditView *)creatAltViewWithTitle:(NSString *)title detail:(NSString *)detail arrTitles:(NSArray *)arrTitles block:(EditIndexBlock)block;




/**
 创建编辑弹窗

 @param title 标题
 @param detail 描述
 @param text 输入框文字
 @param holder 描述
 @param arrTitles 按钮数组
 @param block 点击返回
 */

+(MMEditView *)creatEditViewWithTitle:(NSString *)title detail:(NSString *)detail text:(NSString *)text holder:(NSString *)holder arrTitles:(NSArray *)arrTitles block:(EditIndexBlock)block;
+(MMEditView *)creatEditViewWithTitle:(NSString *)title detail:(NSString *)detail text:(NSString *)text holder:(NSString *)holder unit:(NSString *)unit arrTitles:(NSArray *)arrTitles block:(EditIndexBlock)block;
//拒绝的弹窗
+(MMEditView *)creatRefuseAltViewWithTitle:(NSString *)title holder:(NSString *)holder arrTitles:(NSArray *)arrTitles block:(EditIndexBlock)block;


/**
 创建actionSheet;

 @param arrTitles 按钮标题
 @param block 点击返回
 */
+(MMEditView *)creatSheetViewWithArrTitles:(NSArray *)arrTitles block:(HYBButtonIndexBlock)block;
+(MMEditView *)creatSheetViewWithCacelTitle:(NSString *)cacelTitle arrTitles:(NSArray *)arrTitles block:(HYBButtonIndexBlock)block;


//计算放贷额

/**
 

 @param arrTitles 标题
 @param safeValue 安全值
 @param value 估值
 @param sale 放贷比例
 @param block 返回数据
 @return 返回
 */
+(MMEditView *)creatCalculationViewWithArrTitles:(NSArray *)arrTitles safeValue:(NSString *)safeValue value:(NSString *)value sale:(NSString *)sale block:(CalculationBlock)block;






@end
