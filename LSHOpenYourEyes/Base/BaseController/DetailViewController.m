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


@interface DetailViewController ()

@property(nonatomic, strong)UIScrollView *scrollView;

@property(nonatomic, strong)MPMoviePlayerViewController *player;
@end

@implementation DetailViewController

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
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, HEITHT)];
        _scrollView.pagingEnabled = YES;
        
        _scrollView.contentOffset = CGPointMake(self.index*WIDTH, 0);
        
        _scrollView.showsVerticalScrollIndicator = NO;
        
        
        
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}





-(void)addScrollViewData{
   
    self.scrollView.contentSize = CGSizeMake(5 * WIDTH ,HEITHT);
    int i = 0;
    
    for(ListModel *list in self.currentModel.itemList){

        
        if([list.type isEqualToString:@"textHeader"]){
            continue;
        }else{
        
            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(i * self.scrollView.bounds.size.width,0, WIDTH, HEITHT)];
            
            VideoModel *video = list.data;
            CoverModel *cover = video.cover;
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 300)];
            //设置背景图
            UIImageView *backImage = [[UIImageView alloc]initWithFrame:self.view.bounds];
            
             //背景图
            [backImage setImageWithURL:[NSURL URLWithString:cover.blurred]];
           
            //播放图片
            [imageView setImageWithURL:[NSURL URLWithString:cover.feed]];
            
//            UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
//            
//            [imageView addSubview:button];
//            
//            [button addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
//            
            
            //初始化播放器
//            self.player = [[MPMoviePlayerController alloc]initWithContentURL:[NSURL URLWithString:video.playUrl]];
//            //设置播放器的大小
//            self.player.view.frame = CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height);
//            
//
//            
//            //把播放器添加都imageview
//            [imageView addSubview:self.player.view];
            
            //标题
            UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 310, WIDTH - 40, 30)];
            titleLabel.text = video.title;
            titleLabel.textColor = [UIColor whiteColor];
            //横线
            
//            NSLog(@"%f",titleLabel.frame.origin.y + titleLabel.frame.size.height + 10);
            UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(20, titleLabel.frame.origin.y + titleLabel.frame.size.height + 10, 50, 0.5)];
            line.backgroundColor = [UIColor whiteColor];
            
            //类型
            UILabel *info = [[UILabel alloc]initWithFrame:CGRectMake(10, line.frame.origin.y + 10, WIDTH - 40, 20)];
            
            NSInteger minute = [video.duration integerValue] / 60;
            
            NSInteger second = [video.duration integerValue] % 60;
            
            info.text = [NSString stringWithFormat:@"#%@ / %ld\' %ld\" ",video.category,minute,second];
            info.textColor = [UIColor whiteColor];
            info.font = [UIFont systemFontOfSize:14];
            
            //内容
            UILabel *content = [[UILabel alloc]initWithFrame:CGRectMake(10, 320, WIDTH - 40, 200)];
            content.text = video.kdescription;
            content.numberOfLines = 0;
            content.textColor = [UIColor whiteColor];
            content.font = [UIFont systemFontOfSize:14];
            
            [view addSubview:backImage];
            [view addSubview:imageView];
            [view addSubview:titleLabel];
            [view addSubview:line];
            [view addSubview:info];
            [view addSubview:content];
  
            
            [self.scrollView addSubview:view];
            i++;
        }
    
    }
    
    
}







@end
