//
//  NSObject+Addtion.m
//  LSYC
//
//  Created by fengxiadesinian on 2018/1/23.
//  Copyright © 2018年 fengxiadesinian. All rights reserved.
//

#import "NSObject+Addtion.h"

@implementation NSObject (Addtion)
//遍历获取所有属性Property
+ (NSArray *) getAllProperty {
    NSMutableArray *arr = [NSMutableArray array];
    unsigned int propertyCount = 0;
    objc_property_t *propertyList = class_copyPropertyList([self class], &propertyCount);
    for (unsigned int i = 0; i < propertyCount; i++ ) {
        objc_property_t *thisProperty = &propertyList[i];
        const char* propertyName = property_getName(*thisProperty);
        [arr addObject:LSString(@"%s",propertyName)];
        
    }
    return arr;
}

-(void)registerClassNames:(id)classNames{
    NSArray *arrClassName;
    if ([classNames isKindOfClass:[NSString class]]) {
        arrClassName = @[classNames];
    }else{
        arrClassName = classNames;
    }
    if ([self isKindOfClass:[UITableView class]]) {
        __block UITableView *tableview = (UITableView *)self;
        [arrClassName enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            Class cla = NSClassFromString(obj);
            id fn = [[cla alloc]init];
            if ([fn isKindOfClass:[UITableViewCell class] ]) {
                [tableview registerClass:cla forCellReuseIdentifier:obj];
            }else if ([fn isKindOfClass:[UITableViewHeaderFooterView class]]){
                [tableview registerClass:cla forHeaderFooterViewReuseIdentifier:obj];
            }
        }];
    }else if ([self isKindOfClass:[UICollectionView class]]){
        __block UICollectionView *collectionview = (UICollectionView *)self;
        [arrClassName enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            Class cla = NSClassFromString(obj);
            id fn = [[cla alloc]init];
            if ([fn isKindOfClass:[UICollectionViewCell class] ]) {
                [collectionview registerClass:cla forCellWithReuseIdentifier:obj];
            }else if ([fn isKindOfClass:[UICollectionReusableView class]]){
                [collectionview registerClass:cla forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:obj];
            }
        }];
    }
}






@end
