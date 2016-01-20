//
//  CoraDataManager.m
//  LSHOpenYourEyes
//
//  Created by DeNiRo4H on 16-1-20.
//  Copyright (c) 2016年 LSH. All rights reserved.
//

#import "CoraDataManager.h"

@implementation CoraDataManager

//是否收藏
+(BOOL)isfavourite:(VideoModel*)model{

    //根据id找到数据库中对应的数据数组
    NSArray *array = [MyVideoModel MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@"kid=%@",model.tid]];
    return array.count;
  
}

+(void)insertModel:(VideoModel *)model{
     //创建实体
    MyVideoModel *video = [MyVideoModel MR_createEntity];
    
    video.kid = model.tid;
//    video.date = model.date;
    video.idx = model.idx;
    video.title = model.title;
    video.kdescription = model.kdescription;
    video.category = model.category;
    video.duration = model.duration;
    video.playUrl = model.playUrl;
    
    ConsumptionModel *consumption = model.consumption;
    video.collectionCount = consumption.collectionCount;
    video.shareCount = consumption.shareCount;
    video.playCount = consumption.playCount;
    video.replyCount = consumption.replyCount;
    
    CoverModel *cover = model.cover;
    video.feed = cover.feed;
    video.detail = cover.detail;
    video.blurred = cover.blurred;
    video.sharing = cover.sharing;
    
    WebUrlModel *webModel = model.webUrl;
    webModel.raw = webModel.raw;
    webModel.forWeibo = webModel.forWeibo;
    
    //同步到数据库
    [[NSManagedObjectContext MR_defaultContext]
     MR_saveToPersistentStoreAndWait];
    
    

}

+(void)deleteModel:(VideoModel *)model{
   
    //根据id找到数据库中对应的数据数组
    NSArray *array = [MyVideoModel MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@"kid=%@",model.tid]];
    
    for(MyVideoModel *video in array){
        //删除对应的实体
        [video MR_deleteEntity];
    }//同步到数据库
    
    [[NSManagedObjectContext MR_defaultContext]
     MR_saveToPersistentStoreAndWait];
  
}

+(NSArray *)findAppALL{
    //找到所有的模型
    NSArray *models = [MyVideoModel MR_findAll];
    
    NSMutableArray *listArrays = [NSMutableArray array];
    
    for(MyVideoModel *video in models){
    
        VideoModel *model =[[VideoModel alloc]init];
        
         model.tid = video.kid ;
         model.date =video.date ;
          model.idx = video.idx;
         model.title = video.title ;
        model.kdescription = video.kdescription ;
         model.category = video.category ;
         model.duration = video.duration ;
         model.playUrl = video.playUrl ;
        
        
        //添加consumption到 model 中
        ConsumptionModel *consumption = [[ConsumptionModel alloc]init];
         consumption.collectionCount = video.collectionCount;
         consumption.shareCount = video.shareCount;
        consumption.playCount = video.playCount ;
         consumption.replyCount = video.replyCount;
         model.consumption = consumption;
        
        //添加CoverModel到 model 中
        CoverModel *cover = [[CoverModel alloc]init];
        cover.feed = video.feed ;
         cover.detail = video.detail;
         cover.blurred = video.blurred;
         cover.sharing = video.sharing;
        model.cover = cover;
        
        //添加WebUrlModel到 model 中
        WebUrlModel *webModel = [WebUrlModel alloc];
         webModel.raw = webModel.raw ;
         webModel.forWeibo = webModel.forWeibo;
        model.webUrl = webModel;
        [listArrays addObject:model];
        
        return listArrays;
    
    }
  
    return nil;
}



@end
