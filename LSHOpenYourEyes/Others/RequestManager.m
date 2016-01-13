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
        
//          NSLog(@"%@",responseObject);
        //解析
        NSArray *issueList = [self anlysisData:responseObject];
        
        NSLog(@"%@", issueList);
        
        complicate(YES,issueList);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
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
-(NSArray *)anlysisData:(id) responseObject{
    
    NSArray *issueList = [responseObject[@"issueList"] firstObject][@"itemList"];
    
    return [ListModel arrayOfModelsFromDictionaries:issueList];

}

@end
