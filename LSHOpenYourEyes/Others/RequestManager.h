//
//  RequestManager.h
//  LSHOpenYourEyes
//
//  Created by DeNiRo4H on 16-1-12.
//  Copyright (c) 2016年 LSH. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^Complicate)(BOOL success,id object);

@interface RequestManager : NSObject

//请求数据
/**
 *  请求接口
 *
 *  @param urlString  请求地址
 *  @param dic        请求参数
 *  @param complicate  回调
 *  @param modelClass 返回模型类
 */
- (void)requestWithUrl:(NSString*)urlString parameters:(NSDictionary *)dic complicate:(Complicate)complicate modelClass:(Class)modelClass;

@end
