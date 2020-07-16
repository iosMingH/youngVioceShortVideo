//
//  SkUserDefaults.h
//  App
//
//  Created by 李焕明 on 16/5/27.
//  Copyright © 2016年 李焕明. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SkSet.h"
#import "SkUser.h"
#import "SkPublicConfig.h"

#define KEY_BOOL_FIRST          @"KEY_BOOL_FIRST"
#define KEY_BOOL_PUSH           @"KEY_BOOL_PUSH"
#define KEY_BOOL_LOGIN          @"KEY_BOOL_LOGIN"
#define KEY_BOOL_SIGIN          @"KEY_BOOL_SIGIN"
#define KEY_BOOL_HIDDEN         @"KEY_BOOL_HIDDEN"
#define KEY_BOOL_JUMP           @"KEY_BOOL_JUMP"
#define KEY_BOOL_ADJUMP           @"KEY_BOOL_ADJUMP"

#define KEY_BACKVIEW_SELECTINDEX @"KEY_BACKVIEW_SELECTINDEX"

#define KEY_INTEGER_INDEX       @"KEY_INTEGER_INDEX"

#define KEY_STRING_TERMINAL     @"KEY_STRING_TERMINAL"
#define KEY_STRING_ACCOUNTID    @"KEY_STRING_ACCOUNTID"

#define KEY_ARRAY_GOOD          @"KEY_ARRAY_GOOD"        //点赞
#define KEY_ARRAY_BAD           @"KEY_ARRAY_BAD"        //踩
#define KEY_ARRAY_CALLLOG       @"KEY_ARRAY_CALLLOG"    //通话记录
#define KEY_ARRAY_TerminalGetConfigs @"KEY_ARRAY_TerminalGetConfigs"//终端配置文件

@interface SkUserDefaults : NSObject

+ (void)writeIsBool:(BOOL)pBool key:(NSString *)pKey;
+ (BOOL)readIsBoolWithKey:(NSString *)pKey;

+ (void)writeInterger:(NSInteger)pInteger key:(NSString *)pKey;
+ (NSInteger)readIntergerWithKey:(NSString *)pKey;

+ (void)writeString:(NSString *)pString key:(NSString *)pKey;
+ (NSString *)readStringWithKey:(NSString *)pKey;

+ (void)writeArray:(NSArray *)pArray key:(NSString *)pKey;
+ (NSArray *)readArrayWithKey:(NSString *)pKey;

+ (void)writeDate:(NSDate *)pDate;
+ (NSDate *)readDate;

+ (void)writeObject:(SkObject *)pObject;
+ (SkObject *)readObject:(NSString *)pObjectName;

+ (SkSet *)readSet;
+ (SkUser *)readUser;
+ (SkPublicConfig *)readPublicConfig;

@end
