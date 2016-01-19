//
//  DetailViewController.m
//  LSHOpenYourEyes
//
//  Created by DeNiRo4H on 16-1-16.
//  Copyright (c) 2016年 LSH. All rights reserved.
//

#import "DetailViewController.h"
#import "ScreenMarco.h"
#import "UIImageView+AFNetworking.h"
#import <MediaPlayer/MediaPlayer.h>
#import "LSHView.h"
#import "LSHMoviePlayerViewController.h"
#import "ConsumptionModel.h"


@interface DetailViewController ()<LSHViewOnClickDelegate,LSHMoviePlayerViewControllerDelegate>
{

    NSInteger i;
}

@property(nonatomic, strong)UIScrollView *scrollView;

@property(nonatomic, strong)MPMoviePlayerViewController *player;

@property(nonatomic, strong)VideoModel *video;


@end

@implementation DetailViewController

-(void)viewWillAppear:(BOOL)animated{
   
    [super viewWillAppear:animated];
    //隐藏
    self.tabBarController.tabBar.hidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated{

    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self addScrollViewData];
    
}

/*
  懒加载
 */

//初始化scrollview
-(UIScrollView *)scrollView{

    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, KscreenWidth, KscreenHeight)];
        _scrollView.pagingEnabled = YES;
        //初始偏移量
        _scrollView.contentOffset = CGPointMake(self.index*KscreenWidth, 0);
        //不允许垂直滚动
        _scrollView.showsVerticalScrollIndicator = NO;
    
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}




-(void)addScrollViewData{
    
    NSMutableArray *array = [NSMutableArray array];
    
    self.scrollView.contentSize = CGSizeMake(5 * KscreenWidth ,KscreenHeight);
    
    
    for(ListModel *list in self.currentModel.itemList){

        if([list.type isEqualToString:@"textHeader"]){
            continue;
        }else{
        
        LSHView *view = [[LSHView alloc]initWithFrame:CGRectMake(i * self.scrollView.frame.size.width,0, self.scrollView.frame.size.width, self.scrollView.frame.size.height)];
            //建立代理关系
            view.delegate = self;
            
        self.video = list.data;
        CoverModel *cover = self.video.cover;
        ConsumptionModel *consumption = self.video.consumption;
            
        
                //背景图
        [view.backImage setImageWithURL:[NSURL URLWithString:cover.blurred]];
            
                //播放图片
        [view.imageView setImageWithURL:[NSURL URLWithString:cover.feed]];
           //设置标题
        view.titleLabel.text = self.video.title;
            //设置标题的颜色
        view.titleLabel.textColor = [UIColor whiteColor];
            
            //设置子标题
        NSInteger minute = [self.video.duration integerValue] / 60;
       NSInteger second = [self.video.duration integerValue] % 60;
       view.info.text = [NSString stringWithFormat:@"#%@ / %ld\' %ld\" ",self.video.category,minute,second];
       view.info.textColor = [UIColor whiteColor];
       view.info.font = [UIFont systemFontOfSize:14];
        
            //设置内容
        view.content.text = self.video.kdescription;
        view.content.numberOfLines = 0;
        view.content.textColor = [UIColor whiteColor];
        view.content.font = [UIFont systemFontOfSize:14];
        
            //收藏
            [view.collect setImage:[UIImage imageNamed:@"shoucang"] forState:UIControlStateNormal];
            view.collectLabel.text = consumption.collectionCount;
            view.collectLabel.textColor = [UIColor whiteColor];
            
            //分享
            [view.share  setImage:[UIImage imageNamed:@"fenxiang"] forState:UIControlStateNormal];
            view.shareLable.text = consumption.shareCount;
            view.shareLable.textColor = [UIColor whiteColor];
            //下载
            [view.downLoad setImage:[UIImage imageNamed:@"xiazai"] forState:UIControlStateNormal];
            view.downLoadLabel.text = consumption.replyCount;
            
            view.downLoadLabel.textColor = [UIColor whiteColor];
            
            
        [self.scrollView addSubview:view];
        [self.view addSubview:self.scrollView];
            
        }
        i++;
        
    
    }
    
    
}

#pragma mark 实现协议方法
-(void)viewOnClick:(UIButton *)Button{
   
    LSHMoviePlayerViewController *movie = [[LSHMoviePlayerViewController alloc]init];
    movie.delegate = self;
    ListModel *list =[self.currentModel.itemList firstObject];
    VideoModel *video = [[VideoModel alloc]init];
    NSInteger index = self.scrollView.contentOffset.x / KscreenWidth;
    //如果第一个类型为textHeader那么读取下一个
    if([list.type isEqualToString:@"textHeader"] ){
        list = self.currentModel.itemList[index+1];
    }else{
    list = self.currentModel.itemList[index];
    }
     video = list.data;
    movie.movieURL = video.playUrl;
    
     [self presentViewController:movie animated:YES completion:^{
         
         NSLog(@"推送完成");
     }];
    
}
//电影结束之后会调用的协议方法
-(void)moviePlayerDidFinished
{
    //谁申请谁释放  将当前模态视图控制器释放
   [self dismissViewControllerAnimated:YES completion:^{
   }];
}



@end
