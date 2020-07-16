//
//  takePhoto.m
//  App
//
//  Created by wodada on 2017/1/2.
//  Copyright © 2017年 李焕明. All rights reserved.
//
#define AppRootView  ([[[[[UIApplication sharedApplication] delegate] window] rootViewController] view])

#define AppRootViewController  ([[[[UIApplication sharedApplication] delegate] window] rootViewController])

#import "takePhoto.h"

@implementation takePhoto
{
    NSUInteger sourceType;
}

+ (takePhoto *)sharedModel{
    static takePhoto *sharedModel = nil;
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken, ^{
        sharedModel = [[self alloc] init];
    });
    return sharedModel;
}

+(void)chooseViewController:(UIViewController *)viewController sharePicture:(sendPictureBlock)block{
    
    takePhoto *tP = [takePhoto sharedModel];
    
    tP.sPictureBlock =block;
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: nil                                                                             message: nil                                                                       preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIImagePickerController* imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = tP;
    imagePickerController.allowsEditing = YES;
    
    //添加Button
    [alertController addAction: [UIAlertAction actionWithTitle: @"拍照" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //处理点击拍照
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        [viewController presentViewController:imagePickerController animated:YES completion:NULL];
    }]];
    [alertController addAction: [UIAlertAction actionWithTitle: @"从相册选取" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        //处理点击从相册选取
        imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
       imagePickerController.modalPresentationStyle = UIModalPresentationFullScreen;
        [viewController presentViewController:imagePickerController animated:YES completion:NULL];
    }]];
    
    [alertController addAction: [UIAlertAction actionWithTitle: @"取消" style: UIAlertActionStyleCancel handler:nil]];
 
    [viewController presentViewController: alertController animated: YES completion: nil];

}

#pragma mark - image picker delegte

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    takePhoto *TPhoto = [takePhoto sharedModel];
    [picker dismissViewControllerAnimated:YES completion:^{}];
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    [TPhoto sPictureBlock](image);
}

//实现navigationController的代理
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //    viewController.navigationItem.leftBarButtonItem.tintColor = [UIColor blackColor];
    //    viewController.navigationItem.rightBarButtonItem.tintColor = [UIColor blackColor];
    
    // bug fixes: UIIMagePickerController使用中偷换StatusBar颜色的问题
//    if ([navigationController isKindOfClass:[UIImagePickerController class]] && ((UIImagePickerController *)navigationController).sourceType == UIImagePickerControllerSourceTypePhotoLibrary) {
//        [[UIApplication sharedApplication] setStatusBarHidden:NO];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
//    }
}

@end
