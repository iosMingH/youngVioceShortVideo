//
//  CEBaseTableView.m
//  App
//
//  Created by Pro on 2020/6/24.
//  Copyright © 2020 李焕明. All rights reserved.
//

#import "CEBaseTableView.h"
#import "CECellModel.h"
#import "CEBaseTableViewCell.h"

@implementation CEBaseTableView

- (UITableViewCell *)dequeueReusableCellWithModel:(CECellModel *)model{
    if (model == nil) {
        return nil;
    }
    model.result = (model.result.length > 0 )?model.result:@"result";
    model.className = (model.className.length > 0)?model.className:@"UITableViewCell";
    CEBaseTableViewCell *cell = [self dequeueReusableCellWithIdentifier:model.result];
    if (cell == nil) {
        cell = [[NSClassFromString(model.className) alloc]initWithStyle:0 reuseIdentifier:model.result];
        cell.selectionStyle = 0;
    }
    cell.data = model.data;
    return cell;
}

@end
