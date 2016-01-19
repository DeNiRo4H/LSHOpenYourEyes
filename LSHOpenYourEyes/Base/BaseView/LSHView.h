//
//  LSHView.h
//  LSHOpenYourEyes
//
//  Created by DeNiRo4H on 16-1-19.
//  Copyright (c) 2016年 LSH. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol LSHViewOnClickDelegate<NSObject>
//点击按钮发生的事件
-(void)viewOnClick:(UIButton *)Button;

@end




@interface LSHView : UIView

@property(nonatomic, strong)UIImageView *imageView ;

@property(nonatomic, strong)UIImageView *backImage;

@property(nonatomic, strong) UIButton *imageButton;

@property(nonatomic, strong)  UILabel *titleLabel;//标题

@property(nonatomic, strong) UILabel *content;//内容

@property(nonatomic, strong)UILabel *info;

@property(nonatomic, assign)id<LSHViewOnClickDelegate>delegate;

@property(nonatomic, strong)UIButton *collect;
@property(nonatomic, strong)UILabel *collectLabel;
@property(nonatomic, strong)UIButton *share;
@property(nonatomic, strong)UILabel *shareLable;
@property(nonatomic, strong)UIButton *downLoad;
@property(nonatomic, strong)UILabel *downLoadLabel;



@end
