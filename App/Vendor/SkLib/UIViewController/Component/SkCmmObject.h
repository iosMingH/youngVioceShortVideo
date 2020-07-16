//
//  SkCmmObject.h
//  App
//
//  Created by 李焕明 on 16/5/25.
//  Copyright © 2016年 李焕明. All rights reserved.
//

#import "SkObject.h"

typedef NS_OPTIONS(NSUInteger, SkCmmState) {
    SkCmmStateNo       = 0,           //无跳转操作
    SkCmmStatePush     = 1,
    SkCmmStatePresent  = 2,
    SkCmmStateBack     = 3,
    SkCmmStateRoot     = 4,      //直接返回rootview
    //    SkCmmStatePush     = 1 << 0,
    //    SkCmmStatePresent  = 1 << 1,
    //    SkCmmStateBack     = 1 << 2,
    //    SkCmmStateRoot     = 1 << 3,      //直接返回rootview
};

@interface SkCmmObject : SkObject

@property (nonatomic, assign) NSInteger         mSkIndex;               //索引
@property (nonatomic, strong) NSString          *mSkClassName;          //类名
@property (nonatomic, strong) NSString          *mSkTitle;              //标题
@property (nonatomic, assign) SkCmmState        mSkSate;                //状态
@property (nonatomic, assign) BOOL              mSkAnimate;             //切换页面时，是否需要动画
@property (nonatomic, strong) id                mSkExtend;              //延伸--- 例如：webview时候的url，其他情况的dic
@property (nonatomic, strong) NSString          *mSkDbKey;              //延伸--- 用于数据库存储唯一key

@end

