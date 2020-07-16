//
//  NSString+Tools.m
//  App
//
//  Created by mac on 2017/11/16.
//  Copyright © 2017年 HuanMingLi. All rights reserved.
//


#import "NSString+Tools.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Tools)

/**
 *  MD5 加密
 *
 *  @return 加密后字符串
 */
- (NSString *)md5String
{
    if(self == nil || [self length] == 0) return nil;
    unsigned char digest[CC_MD5_DIGEST_LENGTH], i;
    CC_MD5([self UTF8String], (int)[self lengthOfBytesUsingEncoding:NSUTF8StringEncoding], digest);
    NSMutableString *ms = [NSMutableString string];
    for(i=0;i<CC_MD5_DIGEST_LENGTH;i++)
    {
        [ms appendFormat: @"%02x", (int)(digest[i])];
    }
    return [ms copy];
}


//-(NSString*)imgPrefix
//{
//    if ([self hasPrefix:@"http"]){
//        return self;
//    } else {
//        return [NSString stringWithFormat:@"%@%@",SERVAER_IP,self];
//    }
//}



@end
