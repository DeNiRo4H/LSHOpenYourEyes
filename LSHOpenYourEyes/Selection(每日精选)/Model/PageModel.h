//
//  PageModel.h
//  LSHOpenYourEyes
//
//  Created by DeNiRo4H on 16-1-14.
//  Copyright (c) 2016年 LSH. All rights reserved.
//

#import "BaseModel.h"


@protocol CurrentPageModel <NSObject>
@end

@interface PageModel : BaseModel

@property(nonatomic, copy)NSString<Optional> *nextPageUrl;

@property (nonatomic, strong)NSNumber<Optional> *nextPublishTime;

//@property NSInteger date;
//
//@property NSInteger count;
//
//@property NSInteger publishTime;
//
//@property(nonatomic, copy)NSString<Optional> *type;
//
//@property(nonatomic, strong)CurrentPageModel<Optional> *currentModel;

@end
