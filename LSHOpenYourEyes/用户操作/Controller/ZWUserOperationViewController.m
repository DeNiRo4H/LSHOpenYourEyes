//
//  ZWUserOperationViewController.m
//  网络自习-Day4-电影项目
//
//  Created by 张玮 on 15/12/23.
//  Copyright © 2015年 8brother. All rights reserved.
//

#import "ZWUserOperationViewController.h"
#import "ZWOperationView.h"
#import "ZWOperationViewModel.h"
#import "UIView+ZWCustomTranstion.h"
#import "UMSocial.h"

#define kWidth  self.view.bounds.size.width
#define kHeight self.view.bounds.size.height

#define kTabBarHeight 49
#define kStartMargin  70
#define kStartY       150
#define kHeightMargin 120
#define kOperationViewWidth  90
#define kOperationViewHeight 90
#define kCount     4
#define kRowCount  2
#define kColCount  2

#define kDefaultTag 100

//定义动画类型枚举
typedef enum {
    
    startAnimation, // 开始
    endAnimation    // 结束
    
}AnimationStyle;

@interface ZWUserOperationViewController ()

@property (nonatomic, strong) UIButton * button;//整下方返回按钮

@end

@implementation ZWUserOperationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置退出模态视图的类型 Custom 类型 ??
//    self.modalPresentationStyle = UIModalPresentationCustom;
    
    [self setupFrostedGlassView];//毛玻璃视图
    [self setupOperationButton];//操作按钮
    [self customTabBar];//自定义tabBar 覆盖原来的

    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self buttonAnimation:startAnimation];
    [self animationOfOperationView:startAnimation];
}

#pragma mark - 操作按钮构建
// 九宫格创建button
- (void)setupOperationButton
{
    
    
    
    NSArray * titles = @[@"想看",
                         @"评分",
                         @"影单",
                         @"台词海报"];
    NSArray * images = @[@"my_calendar_add_interest",
                         @"my_calendar_add_write",
                         @"my_calendar_add_build",
                         @"my_package"];
    
    for (int i = 0; i < kCount; i++) {
        
        ZWOperationView * operationView = [ZWOperationView operationView];
        
        int row = i / kColCount;// 行
        int col = i % kColCount;// 列
        
        operationView.tag = kDefaultTag + i;
        
        CGFloat margin = (kWidth - 2 * kStartMargin - kColCount * kOperationViewWidth) / (kColCount - 1) ;
        
        NSLog(@"%f",margin);
        
        operationView.frame = CGRectMake(kStartMargin + col * (margin + kOperationViewWidth), kStartY + (row * kHeightMargin + kOperationViewHeight) + 500, kOperationViewWidth, kOperationViewHeight);
        
        ZWOperationViewModel *model = [[ZWOperationViewModel alloc] init];
        model.title = titles[i];
        model.imageName = images[i];
        //调用model的getter方法 进行视图的刷新
        operationView.model = model;
        
        [self.view addSubview:operationView];
    }
    

}

#pragma mark - OperationView移动动画实现

- (void)animationOfOperationView:(AnimationStyle)animationStyle
{
    for (int i = 0; i < kCount; i++) {
        ZWOperationView * op = (id)[self.view viewWithTag:i + kDefaultTag];
        int row = i / kColCount;
        int col = i % kColCount;
        CGFloat margin = (kWidth - 2 * kStartMargin - kColCount * kOperationViewWidth) / (kColCount - 1);
        CGFloat duration = 0.3;
        CGFloat delay = 0;
        
        int expression = 0;
        
        if (animationStyle == startAnimation) {
            expression = kCount - i - 1;
        }else{
            expression = i;
        }
        
        switch (expression) {
            case 0:
                delay = 0.2;
                break;
            case 1:
                delay = 0.1;
                break;
            case 2:
                delay = 0.05;
                break;
            case 3:
                delay = 0;
                break;
                
            default:
                break;
        }
        
        int originY = 0;
        
        if (animationStyle == startAnimation) {
            originY = kStartY + (row * kHeightMargin + kOperationViewHeight);
        }else{
            originY = kStartY + (row * kHeightMargin + kOperationViewHeight) + 500;
        }
        
        [UIView animateKeyframesWithDuration:duration delay:delay options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
            op.frame = CGRectMake(kStartMargin + col * (margin + kOperationViewWidth), originY , kOperationViewWidth, kOperationViewHeight);
        } completion:^(BOOL finished) {
            
        }];
    }

}

#pragma mark - 返回按钮动画模块

- (void)customTabBar
{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, kHeight - kTabBarHeight, kWidth, kTabBarHeight)];
    imageView.backgroundColor = [UIColor lightGrayColor];
    
    //添加返回button
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake((kWidth - 44) / 2, 3, 44, 44)];
    [button setImage:[UIImage imageNamed:@"sanheng"] forState:UIControlStateNormal];
    CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI_2 * 0.5); //45°
    button.transform = transform;
    [imageView addSubview:button];
    [button addTarget:self action:@selector(onClick) forControlEvents:UIControlEventTouchUpInside];
    
    imageView.userInteractionEnabled = YES;

    _button = button;
    
    [self.view addSubview:imageView];
}

- (void)buttonAnimation:(AnimationStyle)animationStyle
{
    [UIView animateWithDuration:0.15 delay:0.15 options:UIViewAnimationOptionCurveLinear animations:^{
        if (animationStyle == startAnimation) {
            CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI_2); //弧度的一半 是90°
            _button.transform = transform;
        }else{
            CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI_2 * 0.5); //弧度的一半 是90°
            _button.transform = transform;
        }
        
    } completion:^(BOOL finished) {
        if (animationStyle == endAnimation) {
            [self.view setTransitionWithtype:fade subType:fromRight duration:0];
            [self dismissViewControllerAnimated:NO completion:nil];
        }
    }];
}

- (void)onClick
{
    [self buttonAnimation:endAnimation];
    [self animationOfOperationView:endAnimation];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self onClick];
}

#pragma mark - 毛玻璃效果视图

- (void)setupFrostedGlassView
{    
    //UIBlurEffect 模糊效果
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];// 模糊效果
    //UIVisualEffectView 视图效果 创建时绑定 效果
    UIVisualEffectView *frostedGlassView = [[UIVisualEffectView alloc] initWithEffect:blur];
    
    frostedGlassView.frame = self.view.bounds;
    
    [self.view addSubview:frostedGlassView];
}











@end
