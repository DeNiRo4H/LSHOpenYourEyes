//
//  ConsumptionModel.h
//  LSHOpenYourEyes
//
//  Created by DeNiRo4H on 16-1-12.
//  Copyright (c) 2016年 LSH. All rights reserved.
//
/*
   用户的相关数据
 */
#import "BaseModel.h"

@interface ConsumptionModel : BaseModel

@property(nonatomic, copy)NSNumber<Optional> *collectionCount;//收藏的次数
@property(nonatomic, copy)NSNumber<Optional> *playCount;//播放的次数
@property(nonatomic, copy)NSNumber<Optional> *replyCount;//回复的次数
@property(nonatomic, copy)NSNumber<Optional> *shareCount;//分享次数

@end
