//
//  CoverModel.h
//  LSHOpenYourEyes
//
//  Created by DeNiRo4H on 16-1-12.
//  Copyright (c) 2016年 LSH. All rights reserved.
//


/*
   封面
 */

#import "BaseModel.h"

@interface CoverModel : BaseModel

@property(nonatomic, copy)NSString<Optional> *feed;
@property(nonatomic, copy)NSString<Optional> *detail;
@property(nonatomic, copy)NSString<Optional> *blurred;
@property(nonatomic, copy)NSString<Optional> *sharing;

@end
