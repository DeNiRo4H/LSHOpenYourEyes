//
//  CurrentPageModel.h
//  LSHOpenYourEyes
//
//  Created by DeNiRo4H on 16-1-14.
//  Copyright (c) 2016年 LSH. All rights reserved.
//

#import "BaseModel.h"
#import "ListModel.h"

@protocol  ListModel<NSObject>
@end



@interface CurrentPageModel : BaseModel

@property NSInteger date;

@property NSInteger count;

@property NSInteger publishTime;

@property(nonatomic, copy)NSString<Optional> *type;

@property(nonatomic, strong)NSArray<Optional,ConvertOnDemand,ListModel> *itemList;

@end
