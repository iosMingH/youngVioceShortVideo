//
//  SkObject.m
//  App
//
//  Created by 李焕明 on 16/5/25.
//  Copyright © 2016年 李焕明. All rights reserved.
//

#import "SkObject.h"
#import <objc/runtime.h>

@implementation SkObject

//子类的单例需要自己去实现
+ (instancetype)sharedInstance
{
    NSString *className = [NSString stringWithFormat:@"%@", [self class] ];
    Class class = NSClassFromString( className );
    static dispatch_once_t once;
    static id singleton;
    dispatch_once(&once, ^ {
        singleton = [[class alloc] init];
    });
    return singleton;
}

//- (id)init
//{
//    self = [super init];
//    if (self) {
//
//        //设置默认值
//        unsigned int propertyCount = 0;
//        objc_property_t *propertyList = class_copyPropertyList([self class], &propertyCount);
//
//        for ( int i = 0; i < propertyCount; i++ ) {
//            objc_property_t *thisProperty = propertyList + i;
//            const char* propertyName = property_getName(*thisProperty);
//            NSString *strPropertyName = [NSString stringWithUTF8String:propertyName];
//            NSString *strFirst = [[strPropertyName substringToIndex:1] capitalizedString ];
//            strPropertyName = [strPropertyName substringFromIndex:1];
//            NSString *objName = [NSString stringWithFormat:@"%@%@", strFirst, strPropertyName];
//
//            NSString *setMethodName = [NSString stringWithFormat:@"set%@:", objName ];
//            [self performSelector:NSSelectorFromString(setMethodName) withObject: @"" ];
//        }
//    }
//    return self;
//}

- (void)copyWithOtherObject:(SkObject *)pObject
{
    unsigned int propertyCount = 0;
    objc_property_t *propertyList = class_copyPropertyList([self class], &propertyCount);
    
    for ( int i = 0; i < propertyCount; i++ ) {
        objc_property_t *thisProperty = propertyList + i;
        const char* propertyName = property_getName(*thisProperty);
        NSString *strPropertyName = [NSString stringWithUTF8String:propertyName];
        NSString *strFirst = [[strPropertyName substringToIndex:1] capitalizedString ];
        strPropertyName = [strPropertyName substringFromIndex:1];
        NSString *objName = [NSString stringWithFormat:@"%@%@", strFirst, strPropertyName];
        
        NSString *setMethodName = [NSString stringWithFormat:@"set%@:", objName ];
        NSString *getMethodName = [NSString stringWithUTF8String:propertyName];
        [self performSelector:NSSelectorFromString(setMethodName) withObject: [pObject performSelector:NSSelectorFromString(getMethodName)]];
    }
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    unsigned int propertyCount = 0;
    objc_property_t *propertyList = class_copyPropertyList([self class], &propertyCount);
    
    for ( int i = 0; i < propertyCount; i++ ) {
        objc_property_t *thisProperty = propertyList + i;
        const char* propertyName = property_getName(*thisProperty);
        NSString *methodName = [NSString stringWithUTF8String:propertyName];
        [aCoder encodeObject:[self performSelector:NSSelectorFromString(methodName)] forKey:methodName];
    }
}
- (id)initWithCoder:(NSCoder *)aDecoder{
    if ( self = [super init]) {
        unsigned int propertyCount = 0;
        objc_property_t *propertyList = class_copyPropertyList([self class], &propertyCount);
        
        for ( int i = 0; i < propertyCount; i++ ) {
            objc_property_t *thisProperty = propertyList + i;
            const char* propertyName = property_getName(*thisProperty);
            NSString *strPropertyName = [NSString stringWithUTF8String:propertyName];
            NSString *strFirst = [[strPropertyName substringToIndex:1] capitalizedString ];
            strPropertyName = [strPropertyName substringFromIndex:1];
            NSString *objName = [NSString stringWithFormat:@"%@%@", strFirst, strPropertyName];
            
            NSString *setMethodName = [NSString stringWithFormat:@"set%@:", objName ];
            NSString *getMethodName = [NSString stringWithUTF8String:propertyName];
            [self performSelector:NSSelectorFromString(setMethodName) withObject: [aDecoder decodeObjectForKey:getMethodName] ];
        }
    }
    return self;
}

@end











