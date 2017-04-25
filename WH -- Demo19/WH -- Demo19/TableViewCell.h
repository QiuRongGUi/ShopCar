//
//  TableViewCell.h
//  WH -- Demo19
//
//  Created by QIUGUI on 2017/4/24.
//  Copyright © 2017年 QIUGUI. All rights reserved.
//

#import <UIKit/UIKit.h>


@class WineModel,TableViewCell;

@protocol TableViewCellDelegate  <NSObject>

- (void)TableViewCellWithClikeAddCell:(TableViewCell *)cell;
- (void)TableViewCellWithClikeDeleocCell:(TableViewCell *)cell;
- (void)TableViewCellWithClikeSeleocCell:(TableViewCell *)cell;
@end
@interface TableViewCell : UITableViewCell


/** <#class#>*/
@property(nonatomic,strong) WineModel *mod;

@property(nonatomic,assign) id<TableViewCellDelegate> delegate;


@end
