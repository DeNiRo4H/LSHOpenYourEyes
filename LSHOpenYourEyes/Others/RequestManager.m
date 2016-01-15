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

-(AFHTTPRequestOperationManager *)manager{

    if(_manager == nil){
    
        _manager = [AFHTTPRequestOperationManager manager];
    }
    return _manager;
}


-(void)requestWithUrl:(NSString *)urlString parameters:(NSDictionary *)dic complicate:(Complicate)complicate modelClass:(Class)modelClass{
    
    
    
    [self.manager GET:urlString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //解析
    if([modelClass isSubclassOfClass:[CurrentPageModel class]]){
        
        CurrentPageModel *currentModel = [[self anlysisData:responseObject modelClass:modelClass]firstObject];

//        NSLog(@"%@", currentModel);
        
        complicate(YES,currentModel);
        
    }else if ([modelClass isSubclassOfClass:[PageModel class]]){
        //直接返回二进制
        complicate(YES,responseObject);
        
        
    }else if([modelClass isSubclassOfClass:[ListModel class]]){
        
         NSArray *array = responseObject[@"itemList"];
        
        NSArray *listArray = [ListModel arrayOfModelsFromDictionaries:array];
        
//         NSLog(@"%@", listArray);
        
        complicate(YES, listArray);
    }
    }
        
     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
    
}

/**
 *  解析
 *
 *  @param responseObject 请求得到的二进制数据
 *
 *  @return 数组
 */
-(NSArray *)anlysisData:(id) responseObject modelClass:(Class)modelClass{
    
    NSArray *array = responseObject[@"issueList"];
    
    //改动了一下 ,如果下回崩了可以找这里
    return [modelClass arrayOfModelsFromDictionaries:array];

}

@end
