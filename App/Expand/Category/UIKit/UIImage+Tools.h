//
//  UIImage+Tools.h
//  App
//
//  Created by mac on 2017/11/16.
//  Copyright © 2017年 HuanMingLi. All rights reserved.
//


#import <UIKit/UIKit.h>

typedef void (^GIFimageBlock)(UIImage *GIFImage);  

@interface UIImage (Tools)



/**
 图片转base64

 @return <#return value description#>
 */
- (NSString *) imageToBase64;


/**
 字串转图片

 @param imgSrc <#imgSrc description#>
 @return <#return value description#>
 */
+ (UIImage *) base64ToImage: (NSString *) imgSrc;




/** 根据本地GIF图片名 获得GIF image对象 */
+ (UIImage *)imageWithGIFNamed:(NSString *)name;

/** 根据一个GIF图片的data数据 获得GIF image对象 */
+ (UIImage *)imageWithGIFData:(NSData *)data;

/** 根据一个GIF图片的URL 获得GIF image对象 */
+ (void)imageWithGIFUrl:(NSString *)url and:(GIFimageBlock)gifImageBlock;



+(UIImage*)imageResizing:(NSString*)name;

@end
