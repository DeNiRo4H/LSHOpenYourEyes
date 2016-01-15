//
//  VideoModel.h
//  LSHOpenYourEyes
//
//  Created by DeNiRo4H on 16-1-12.
//  Copyright (c) 2016年 LSH. All rights reserved.
//

#import "BaseModel.h"
#import "ConsumptionModel.h"
#import "ConsumptionModel.h"
#import "ProviderModel.h"
#import "CoverModel.h"
#import "WebUrlModel.h"

@protocol ConsumptionModel <NSObject>
@end

@protocol ProviderModel <NSObject>
@end

@protocol CoverModel <NSObject>
@end

@protocol WebUrlModel <NSObject>
@end



@interface VideoModel : BaseModel

@property(nonatomic, copy)NSString<Optional> *text;
@property (nonatomic,copy)NSString<Optional> *tid;
@property(nonatomic, strong)NSNumber<Optional> *date;//日期
@property(nonatomic, strong)NSNumber<Optional> *idx;
@property(nonatomic, copy)NSString<Optional> *title;//标题
@property(nonatomic, copy)NSString<Optional> *kdescription;//描述
@property(nonatomic,strong)NSNumber<Optional> *duration;//播放时长
@property(nonatomic, copy)NSString<Optional> *playUrl;//播放地址
@property(nonatomic, copy)NSString<Optional> *category;//分类名


@property(nonatomic, strong)ConsumptionModel <Optional, ConvertOnDemand,ConsumptionModel > *consumption;//分享 收藏等

@property(nonatomic, strong)ProviderModel <Optional, ConvertOnDemand,
ProviderModel> *provider;//提供者

@property(nonatomic, strong)CoverModel <Optional, ConvertOnDemand,CoverModel> *cover;//封面相关

@property(nonatomic, strong)WebUrlModel <Optional, ConvertOnDemand,WebUrlModel> *webUrl;//好像没什么卵用

@end
