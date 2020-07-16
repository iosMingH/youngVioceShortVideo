//
//  AES.h
//  App
//
//  Created by Pro on 2020/4/13.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AES : NSObject

+ (NSString *)AESEncrypt:(NSString *)encryptContent key:(NSString *)key;

+ (NSString *)AESDecrypt:(NSString *)encryptContent key:(NSString *)key;
@end

NS_ASSUME_NONNULL_END
