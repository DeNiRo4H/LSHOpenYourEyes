//
//  CoraDataManager.h
//  LSHOpenYourEyes
//
//  Created by DeNiRo4H on 16-1-20.
//  Copyright (c) 2016年 LSH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VideoModel.h"
#import "MyVideoModel.h"
#import "MagicalRecord.h"
#import "ConsumptionModel.h"
#import "ProviderModel.h"
#import "CoverModel.h"
#import "WebUrlModel.h"

@interface CoraDataManager : NSObject


+(BOOL)isfavourite:(VideoModel*)model;

+(void)insertModel:(VideoModel *)model;

+(void)deleteModel:(VideoModel *)model;

+(NSArray *)findAppALL;

@end
