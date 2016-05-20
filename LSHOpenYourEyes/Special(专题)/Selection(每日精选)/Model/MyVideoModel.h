//
//  MyVideoModel.h
//  LSHOpenYourEyes
//
//  Created by DeNiRo4H on 16-1-21.
//  Copyright (c) 2016年 LSH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface MyVideoModel : NSManagedObject

@property (nonatomic, retain) NSString * alias;
@property (nonatomic, retain) NSString * blurred;
@property (nonatomic, retain) NSString * category;
@property (nonatomic, retain) NSNumber * collectionCount;
@property (nonatomic, retain) NSString * date;
@property (nonatomic, retain) NSString * detail;
@property (nonatomic, retain) NSNumber * duration;
@property (nonatomic, retain) NSString * feed;
@property (nonatomic, retain) NSString * forWeibo;
@property (nonatomic, retain) NSString * icon;
@property (nonatomic, retain) NSNumber * idx;
@property (nonatomic, retain) NSString * kdescription;
@property (nonatomic, retain) NSNumber * kid;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * playCount;
@property (nonatomic, retain) NSString * playUrl;
@property (nonatomic, retain) NSString * raw;
@property (nonatomic, retain) NSNumber * replyCount;
@property (nonatomic, retain) NSNumber * shareCount;
@property (nonatomic, retain) NSString * sharing;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * type;

@end
