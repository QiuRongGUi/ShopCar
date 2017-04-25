//
//  WineModel.h
//  WH -- Demo19
//
//  Created by QIUGUI on 2017/4/24.
//  Copyright © 2017年 QIUGUI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WineModel : NSObject
/** <#class#>*/
@property(nonatomic,copy) NSString *image;
/** <#class#>*/
@property(nonatomic,copy) NSString *money;
/** <#class#>*/
@property(nonatomic,copy) NSString *name;

@property(nonatomic,assign) BOOL seleoctedShop;

@property(nonatomic,assign) int shopCount;


@end
