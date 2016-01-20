//
//  LSHView.m
//  LSHOpenYourEyes
//
//  Created by DeNiRo4H on 16-1-19.
//  Copyright (c) 2016年 LSH. All rights reserved.
//

#import "LSHView.h"
#import "ScreenMarco.h"
#import "UIImageView+AFNetworking.h"
#define SPACE_WIDTH 15
#define SFXButton 25
#define NAMELABEL 45

@implementation LSHView

-(instancetype)initWithFrame:(CGRect)frame{
   
    self = [super initWithFrame:frame];
    if(self){
    
        [self initView];
    }
    return self;
}

-(void)initView{
    

    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KscreenWidth, 350)];
    
    //设置背景图
    self.backImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight)];
    


    
    //播放键的button
   self.imageButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 64, 64)];
    self.imageButton.center = self.imageView.center;
    
    [self.imageButton setImage:[UIImage imageNamed:@"shipin.png"] forState:UIControlStateNormal];
    [self.imageView addSubview:self.imageButton];
    
    
    //能点击的button
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.imageView.frame.size.width, self.imageView.frame.size.height)];
    
   
    
    [button addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.titleLabel= [[UILabel alloc]initWithFrame:CGRectMake(10, self.imageView.frame.origin.y +self.imageView.frame.size.height+10, KscreenWidth - 20, 30)];
    
    //横线
    
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(20, self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height + 10, 80, 0.5)];
    line.backgroundColor = [UIColor whiteColor];
    
    //类型
    self.info = [[UILabel alloc]initWithFrame:CGRectMake(10, line.frame.origin.y + 10, KscreenWidth - 20, 20)];
    
    
    //内容
     self.content= [[UILabel alloc]initWithFrame:CGRectMake(10, self.info.frame.origin.y- 10, KscreenWidth - 20, 150)];
//  self.content.backgroundColor = [UIColor blackColor];
    
    //分享 收藏 下载
    self.collect = [[UIButton alloc]initWithFrame:CGRectMake(60, self.content.frame.origin.y +140, SFXButton, SFXButton)];
    [self.collect addTarget:self action:@selector(collectClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.collectLabel = [[UILabel alloc]initWithFrame:CGRectMake(60+SFXButton+SPACE_WIDTH, self.content.frame.origin.y +130, NAMELABEL, NAMELABEL)];

    
    self.share = [[UIButton alloc]initWithFrame:CGRectMake(60+SFXButton+2*SPACE_WIDTH +NAMELABEL, self.content.frame.origin.y +140,SFXButton, SFXButton)];
    self.shareLable = [[UILabel alloc]initWithFrame:CGRectMake(60+2*SFXButton+3*SPACE_WIDTH +NAMELABEL, self.content.frame.origin.y +130, NAMELABEL, NAMELABEL)];
    [self.share addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.downLoad = [[UIButton alloc]initWithFrame:CGRectMake(60+2*SFXButton+4*SPACE_WIDTH +2*NAMELABEL, self.content.frame.origin.y +140, SFXButton, SFXButton)];
    self.downLoadLabel = [[UILabel alloc]initWithFrame:CGRectMake(60+3*SFXButton+5*SPACE_WIDTH +2*NAMELABEL, self.content.frame.origin.y +130, NAMELABEL, NAMELABEL)];
    [self.downLoad addTarget:self action:@selector(downLoadClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.backImage];
    [self addSubview:self.imageView];
    [self addSubview:self.titleLabel];
    [self addSubview:line];
    [self addSubview:self.info];
    [self addSubview:self.content];
    [self addSubview:button];
    [self addSubview:self.collect];
    [self addSubview:self.collectLabel];
    [self addSubview:self.share];
    [self addSubview:self.shareLable];
    [self addSubview:self.downLoad];
    [self addSubview:self.downLoadLabel];
    ;
}

-(void)onClick:(UIButton*)button{

    if([self.delegate respondsToSelector:@selector(viewOnClick:)]){
    
        [self.delegate viewOnClick:button];
    }

}

//收藏
-(void)collectClick:(UIButton *)button{
    
    if([self.delegate respondsToSelector:@selector(viewOnClick:)]){
        
        [self.delegate viewOnClickWithCollection:button];
    }
}
//分享
-(void)shareClick:(UIButton *)button{
    
    if([self.delegate respondsToSelector:@selector(viewOnClick:)]){
        
        [self.delegate viewOnClickWithShare:button];
    }
}

//缓存
-(void)downLoadClick:(UIButton *)button{
    
    if([self.delegate respondsToSelector:@selector(viewOnClick:)]){
        
        [self.delegate viewOnClickWithDownLoad:button];
    }
}


@end
