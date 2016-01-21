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
+(BOOL)isfavourite:(ListModel*)model{
    
    VideoModel *model1 = model.data;
    
    //根据id找到数据库中对应的数据数组
    NSArray *array = [MyVideoModel MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@"kid=%@",model1.tid]];
    return array.count;
  
}

+(void)insertModel:(ListModel *)model{
    
    VideoModel *model1 = model.data;
    
    
     //创建实体
    MyVideoModel *video = [MyVideoModel MR_createEntity];
    video.type = model.type;
    
    video.kid = model1.tid;
//    video.date = model.date;
    video.idx = model1.idx;
    video.title = model1.title;
    video.kdescription = model1.kdescription;
    video.category = model1.category;
    video.duration = model1.duration;
    video.playUrl = model1.playUrl;
    
    ConsumptionModel *consumption = model1.consumption;
    video.collectionCount = consumption.collectionCount;
    video.shareCount = consumption.shareCount;
    video.playCount = consumption.playCount;
    video.replyCount = consumption.replyCount;
    
    CoverModel *cover = model1.cover;
    video.feed = cover.feed;
    video.detail = cover.detail;
    video.blurred = cover.blurred;
    video.sharing = cover.sharing;
    
    WebUrlModel *webModel = model1.webUrl;
    webModel.raw = webModel.raw;
    webModel.forWeibo = webModel.forWeibo;
    
    //同步到数据库
    [[NSManagedObjectContext MR_defaultContext]
     MR_saveToPersistentStoreAndWait];
    
    

}

+(void)deleteModel:(ListModel *)model{
   
    VideoModel *model1 = model.data;
    //根据id找到数据库中对应的数据数组
    NSArray *array = [MyVideoModel MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@"kid=%@",model1.tid]];
    
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
    ListModel *list = [[ListModel alloc]init];
    
    for(MyVideoModel *video in models){
      
        VideoModel *model =[[VideoModel alloc]init];
        
         model.tid = video.kid ;
//         model.date =video.date ;
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
        
        //list里面有两个数据
        list.type = video.type;
        list.data = model;
        
        //listArrays 里面装的都是listModel:type 和 data数组
        [listArrays addObject:list];
        
       
    
    }
  
     return listArrays;
}



@end
