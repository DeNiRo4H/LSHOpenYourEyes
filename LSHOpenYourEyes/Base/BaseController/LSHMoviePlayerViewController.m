//
//  LSHMoviePlayerViewController.m
//  LSHOpenYourEyes
//
//  Created by DeNiRo4H on 16-1-19.
//  Copyright (c) 2016年 LSH. All rights reserved.
//

#import "LSHMoviePlayerViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface LSHMoviePlayerViewController ()

@property(nonatomic, strong)MPMoviePlayerController *moviePlayer;

@end

@implementation LSHMoviePlayerViewController

/*
 懒加载
 */
-(MPMoviePlayerController *)moviePlayer{
    if(!_moviePlayer){
        NSLog(@"%@", self.movieURL);
        _moviePlayer = [[MPMoviePlayerController alloc]initWithContentURL:[NSURL URLWithString:self.movieURL]];
        _moviePlayer.view.frame = self.view.bounds;
        //宽度和高度自适应
        _moviePlayer.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self.view addSubview:_moviePlayer.view];
    }
    return _moviePlayer;
}
-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    self.moviePlayer.fullscreen = YES;//全屏
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.moviePlayer play];
    [self addNotification];
}


-(void)addNotification{
    
    //1 .添加播放状态的通知
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(stateChanged) name:MPMoviePlayerLoadStateDidChangeNotification object:nil];
    
   //2 .播放完成
    [nc addObserver:self selector:@selector(finished) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    
    //3. 退出全屏通知
    [nc addObserver:self selector:@selector(finished) name:MPMoviePlayerDidExitFullscreenNotification object:nil];
}

/*
  播放完成
 */
-(void)finished{
  
    //1 .删除通知监听(一定记得:因为通知中心很耗内存)
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    //2. 返回上一级窗体,谁申请谁释放的原则
    if ([self.delegate respondsToSelector:@selector(moviePlayerDidFinished)]) {
        [self.delegate moviePlayerDidFinished];
    }
}






/*
  状态发生改变
 */
-(void)stateChanged{

    switch(self.moviePlayer.playbackState){
    
        case MPMoviePlaybackStatePlaying:
            NSLog(@"播放");
            break;
        case MPMoviePlaybackStatePaused:
            NSLog(@"暂停");
            break;
        case MPMoviePlaybackStateStopped:
            NSLog(@"停止");
        default:
            break;
    
    }

}









@end
