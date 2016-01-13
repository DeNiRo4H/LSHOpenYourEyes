//
//  UrlFile.h
//  LSHOpenYourEyes
//
//  Created by DeNiRo4H on 16-1-11.
//  Copyright (c) 2016年 LSH. All rights reserved.
//

#ifndef LSHOpenYourEyes_UrlFile_h
#define LSHOpenYourEyes_UrlFile_h

/*
   每日精选
 */

//参数 :
//[date : 1452009600000]: 日期转成秒数

#define selectionUrl  @"http://baobab.wandoujia.com/api/v2/feed"

/*
    专题
 */

//参数
//[start  = 0]  从第一个开始
//[num = 10]  每次加载多少个数
//[categoryName = 创意] 分类的类别
//[strategy = date] 按什么排序 有两个:时间 :date
//分享次数:shareCount
//总共有十二个专题(固定的):
//创意  运动  旅行 剧情 动画 广告
//音乐  开胃  预告 综合 记录 时尚

#define specialUrl  @"http://baobab.wandoujia.com/api/v3/videos";


/* 热门排行:
 参数
 [num = 10]
  [strategy = weekly]
周排行  weekly
月排行  monthly
总排行  historical
 */

#define hotRankingUrl @"http://baobab.wandoujia.com/api/v3/ranklist"



#endif
