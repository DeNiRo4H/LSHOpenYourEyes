//
//  ListModel.h
//  LSHOpenYourEyes
//
//  Created by DeNiRo4H on 16-1-13.
//  Copyright (c) 2016年 LSH. All rights reserved.
//

#import "BaseModel.h"
#import "VideoModel.h"

//@protocol VideoModel<NSObject>
//
//@end

@interface ListModel : BaseModel

@property(nonatomic, copy)NSString *type;

@property(nonatomic, strong)VideoModel <Optional> *data;


@end
