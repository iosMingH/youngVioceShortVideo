//
//  FUQcodeTools.h
//  App
//
//  Created by 吴智民 on 2017/10/25.
//  Copyright © 2017年 HuanMingLi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FUQcodeTools : NSObject


/**
 创建二维码

 @param contenx <#contenx description#>
 @param fw <#fw description#>
 @return <#return value description#>
 */
+(UIImage*)newQcode:(NSString*)contenx width:(CGFloat)fw;

@end
