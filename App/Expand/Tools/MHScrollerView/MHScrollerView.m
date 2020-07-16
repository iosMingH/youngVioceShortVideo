//
//  MHScrollerView.m
//  App
//
//  Created by Pro on 2020/3/4.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import "MHScrollerView.h"

#define topHeight 49

@interface MHScrollerView ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView *bigScrollerView;
@property(nonatomic,strong)UIView *line;
@property(nonatomic,strong)UIView *topView;
@property (nonatomic, assign) NSInteger selectIndex;
@property(nonatomic,strong)NSArray *titleArray;
@property (nonatomic, assign) NSInteger count;

@end

@implementation MHScrollerView

-(instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)array{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.selectIndex = 0;
        self.titleArray = array;
        self.count = array.count;
        [self prepareTopUI];
        [self prepareScrollerViewUI];
        
    }
    return self;
}

- (void)prepareTopUI
{
    self.line = [[UIView alloc] initWithFrame:CGRectMake(0, 49, DEVICEWIDTH/self.count, 1)];
    self.line.backgroundColor = [UIColor redColor];
    self.topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICEWIDTH, 50)];
    self.topView.backgroundColor = [UIColor whiteColor];
    
    for (NSInteger i = 0; i < self.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(DEVICEWIDTH / self.count * i , 0, DEVICEWIDTH/self.count, 49);
       [button setTitle:_titleArray[i] forState:UIControlStateNormal];
//        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
       [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        button.tag = i;
        [self.topView addSubview:button];
    }
    [self.topView addSubview:self.line];
    [self addSubview:self.topView];
    [self changeButtonTextColor];
    
    
}

- (void)prepareScrollerViewUI
{
    self.bigScrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 50, DEVICEWIDTH, self.frame.size.height - 50)];
    self.bigScrollerView.contentSize = CGSizeMake(DEVICEWIDTH*self.count, self.frame.size.height - 50);
    self.bigScrollerView.scrollEnabled = YES;
    self.bigScrollerView.pagingEnabled = YES;
    self.bigScrollerView.delegate = self;
    [self addSubview:self.bigScrollerView];
    NSArray *array = @[[UIColor redColor], [UIColor yellowColor], [UIColor grayColor]];
    for (NSInteger i = 0; i < self.count; i ++) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(DEVICEWIDTH*i, 0, DEVICEWIDTH, DEVICEHEIGH-64-50)];
        view.backgroundColor = array[i];
        [self.bigScrollerView addSubview:view];
    }
    
}

- (void)buttonAction:(UIButton *)button
{
    self.selectIndex = button.tag;
    [self changeButtonTextColor];
    [self changeScrollerViewPlace];
    [self changeLinePlaceWithIndex:button.tag];
    
}

//改变滚动视图位置
- (void)changeScrollerViewPlace{
    [UIView animateWithDuration:0.5 animations:^{
        CGPoint offset = self.bigScrollerView.contentOffset;
        offset.x = DEVICEWIDTH * self.selectIndex;
        self.bigScrollerView.contentOffset = offset;
    }];
}

//改变选中字体颜色
- (void)changeButtonTextColor
{
    for (UIView *view in [self.topView subviews]) {
        
        if ([view isKindOfClass:[UIButton class]]) {
            
            UIButton *button = (UIButton *)view;
            
            if (button.tag == self.selectIndex) {
                [button setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
            }else{
                [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }
        }
    }
}


//改变Line位置
- (void)changeLinePlaceWithIndex:(NSInteger )index{
    
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frame = self.line.frame;
        frame.origin.x = DEVICEWIDTH / self.count *index;
        self.line.frame = frame;
    }];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat x = scrollView.contentOffset.x;
    self.selectIndex = x / DEVICEWIDTH;
    [self changeButtonTextColor];
    [self changeLinePlaceWithIndex:self.selectIndex];
}
@end
