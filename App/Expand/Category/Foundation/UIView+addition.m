//
//  UIView+addition.m
//  LSYC
//
//  Created by Lee Zibin on 2018/1/9.
//  Copyright © 2018年 fengxiadesinian. All rights reserved.
//

#import "UIView+addition.h"

@implementation UIView (addition)

static CGFloat theOnlyScreedWidth;
static CGFloat theOnlyScreedHeight;
    
- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (UIView * (^)(CGFloat x))setX
{
    return ^(CGFloat x) {
        self.x = x;
        return self;
    };
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}


- (UIView *(^)(UIColor *color)) setColor
{
    return ^ (UIColor *color) {
        self.backgroundColor = color;
        return self;
    };
}

- (UIView *(^)(CGRect frame)) setFrame
{
    return ^ (CGRect frame) {
        self.frame = frame;
        return self;
    };
}

- (UIView *(^)(CGSize size)) setSize
{
    return ^ (CGSize size) {
        self.bounds = CGRectMake(0, 0, size.width, size.height);
        return self;
    };
}

- (UIView *(^)(CGPoint point)) setCenter
{
    return ^ (CGPoint point) {
        self.center = point;
        return self;
    };
}

- (UIView *(^)(NSInteger tag)) setTag
{
    return ^ (NSInteger tag) {
        self.tag = tag;
        return self;
    };
}

- (void)addTarget:(id)target
           action:(SEL)action;
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:target
                                                                         action:action];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:tap];
}
-(void)setBorderColor:(UIColor *)color width:(CGFloat)width{
    [self.layer setBorderColor:color.CGColor];
    [self.layer setBorderWidth:width];
}
- (void)addBorderColor:(UIColor *)color{
    [self.layer setBorderColor:color.CGColor];
    [self.layer setBorderWidth:0.5];
    [self.layer setCornerRadius:4];
}

-(void)setCorner:(CGFloat)f{
    self.layer.cornerRadius = f;
    self.layer.masksToBounds = YES;
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
}

#pragma mark 阴影设置

-(void)setNavShadow{
    [self setShadowColor:SK_COLOR_BASE_LINE offSet:CGSizeMake(0, 0) alpha:0.7 radius:1];
}

//设置阴影
-(void)setShadowColor:(UIColor *)color
               offSet:(CGSize)sizee
                alpha:(CGFloat)alpha
               radius:(CGFloat)radius{
    self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOffset = sizee;
    self.layer.shadowOpacity = alpha;
    self.layer.shadowRadius = radius;
}

+(UIViewController *)topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}

+(CGFloat)floatWithType:(int)type{
    static NSArray *floatAry;
    if (!floatAry) {
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        CGFloat height = [UIScreen mainScreen].bounds.size.height;
        if (width > height) {
            CGFloat transt = width;
            width = height;
            height = transt;
        }
        floatAry = @[@(width),@(height)];
    }
    return [floatAry[type] floatValue];
}

+(CGFloat)getScreenWidth{
    if (!theOnlyScreedWidth) {
        theOnlyScreedWidth = [UIScreen mainScreen].bounds.size.width;
        theOnlyScreedHeight = [UIScreen mainScreen].bounds.size.height;
        if (theOnlyScreedWidth < theOnlyScreedHeight) {
            CGFloat midChange = theOnlyScreedWidth;
            theOnlyScreedWidth = theOnlyScreedHeight;
            theOnlyScreedHeight = midChange;
        }
    }
    return theOnlyScreedWidth;
}

+(CGFloat)getScreenHeight{
    if (!theOnlyScreedWidth) {
        theOnlyScreedWidth = [UIScreen mainScreen].bounds.size.width;
        theOnlyScreedHeight = [UIScreen mainScreen].bounds.size.height;
        if (theOnlyScreedWidth < theOnlyScreedHeight) {
            CGFloat midChange = theOnlyScreedWidth;
            theOnlyScreedWidth = theOnlyScreedHeight;
            theOnlyScreedHeight = midChange;
        }
    }
    return theOnlyScreedHeight;
}


@end
