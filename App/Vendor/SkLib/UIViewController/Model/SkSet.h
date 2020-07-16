//
//  SkSet.h
//  App
//
//  Created by 李焕明 on 16/5/25.
//  Copyright © 2016年 李焕明. All rights reserved.
//

#import "SkObject.h"

@interface SkConfig : SkObject
@property (nonatomic, strong) NSString *ConfigVersionID;
@property (nonatomic, strong) NSString *CreateTime;
@property (nonatomic, strong) NSString *Field;
@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *Name;
@property (nonatomic, strong) NSString *ProjectID;
@property (nonatomic, strong) NSString *Remark;
@property (nonatomic, strong) NSString *UpdateTime;
@property (nonatomic, strong) NSString *Value;
@end

@interface SkSet : SkObject<NSCoding>
@property (nonatomic, strong) NSArray *Configs;
@property (nonatomic, strong) NSString *NewHouseFirstPayable;//快速提取，省得获取慢

@end
