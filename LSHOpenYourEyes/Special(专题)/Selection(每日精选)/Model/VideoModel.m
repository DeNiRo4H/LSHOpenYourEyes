//
//  VideoModel.m
//  LSHOpenYourEyes
//
//  Created by DeNiRo4H on 16-1-12.
//  Copyright (c) 2016年 LSH. All rights reserved.
//

#import "VideoModel.h"
#import "JSONKeyMapper.h"

@implementation VideoModel
//将关键字对应上属性
+(JSONKeyMapper *)keyMapper{
    
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id":@"tid",
                        @"description":@"kdescription"}];

}
//如果没有全部对应上接口的属性的话要重写这个方法 不然报错
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{

   

}


@end
