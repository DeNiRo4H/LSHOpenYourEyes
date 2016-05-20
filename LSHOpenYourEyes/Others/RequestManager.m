//
//  RequestManager.m
//  LSHOpenYourEyes
//
//  Created by DeNiRo4H on 16-1-12.
//  Copyright (c) 2016年 LSH. All rights reserved.
//

#import "RequestManager.h"
#import "AFNetworking.h"
#import "VideoModel.h"
#import "ListModel.h"
#import "PageModel.h"
#import "CurrentPageModel.h"


@interface RequestManager()

@property(nonatomic, strong)AFHTTPRequestOperationManager *manager;

@end

@implementation RequestManager

- (AFHTTPRequestOperationManager *)manager{

    if(_manager == nil){
    
        _manager = [AFHTTPRequestOperationManager manager];
//        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html"@"application/json", nil];
    }
    return _manager;
}


- (void)requestWithUrl:(NSString *)urlString parameters:(NSDictionary *)dic complicate:(Complicate)complicate modelClass:(Class)modelClass{
    
    [self.manager GET:urlString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
    //解析
    if([modelClass isSubclassOfClass:[CurrentPageModel class]]){
        NSArray *array = responseObject[@"issueList"];
        
       CurrentPageModel *currentModel = [[CurrentPageModel alloc]initWithDictionary:[array firstObject] error:nil];
        
        complicate(YES,currentModel);
        
    }else if ([modelClass isSubclassOfClass:[PageModel class]]){
        //直接返回二进制
        complicate(YES,responseObject);
        
    }else if([modelClass isSubclassOfClass:[ListModel class]]){
        
         NSArray *array = responseObject[@"itemList"];
        
        NSArray *listArray = [ListModel arrayOfModelsFromDictionaries:array];

        complicate(YES, listArray);
    }
    }
        
     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
    
}


@end
