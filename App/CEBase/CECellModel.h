//
//  CECellModel.h
//  App
//
//  Created by Pro on 2020/6/24.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CECellModel : NSObject<NSMutableCopying>

@property (nonatomic ,copy ,nonnull) NSString *result;
@property (nonatomic ,copy ,nonnull) NSString *className;
@property (nonatomic ) CGFloat cellHeigh;
@property (nonatomic ) CGFloat sectionHeader;
@property (nonatomic ) CGFloat sectionFooter;
@property (nonatomic ,strong ,nullable) id data;

@property (nonatomic ,strong ,nullable) id headerData;
@property (nonatomic ,strong ,nullable) id footerData;

@end

NS_ASSUME_NONNULL_END
