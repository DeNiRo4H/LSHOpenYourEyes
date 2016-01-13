//
//  PlayInfoModel.h
//  LSHOpenYourEyes
//
//  Created by DeNiRo4H on 16-1-12.
//  Copyright (c) 2016年 LSH. All rights reserved.
//

#import "BaseModel.h"

@interface PlayInfoModel : BaseModel

@property(nonatomic, copy)NSString *height;//分辨率
@property(nonatomic, copy)NSString *width;

@property(nonatomic, copy)NSString *name;//高清/普通
@property(nonatomic, copy)NSString *type;//视频类型
@property(nonatomic, copy)NSString *url;//视频


@end
