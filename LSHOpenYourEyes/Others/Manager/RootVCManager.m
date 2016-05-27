//
//  RootVCManager.m
//  LSHOpenYourEyes
//
//  Created by DeNiRo4H on 16-1-11.
//  Copyright (c) 2016年 LSH. All rights reserved.
//

#import "RootVCManager.h"
#import "SelectionViewController.h"
#import "SpecialViewController.h"
#import "HotRenkingViewController.h"
#import "BaseNavigationViewController.h"




@interface RootVCManager()
{

   
  
}

@end

@implementation RootVCManager


+ (UIViewController *)rootVC{
    
    //类名数组
    NSArray *array = @[@"SelectionViewController",@"SpecialViewController",@"HotRenkingViewController"];
    //设置图片数组
    NSArray *imageNames = @[@"selection",@"special",@"hotRanking"];
    
      NSArray *titles = @[@"SELECTION",@"SPECAIL",@"HOT"];
    
    NSArray *titleArray = @[@"每日精选",@"专题",@"热门排行"];
    
    NSMutableArray *controllers = [NSMutableArray array];
    
    int i = 0 ;
    for(NSString *name in array){
        
        //根据名字得到navigation
        UINavigationController *na = [RootVCManager navigationWithClass:NSClassFromString(name) titles:titles[i]];
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
        titleLabel.text = titles[i];
        titleLabel.textColor = [UIColor whiteColor];
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
        view.tintColor = [UIColor brownColor];
        [view addSubview:titleLabel];
         na.navigationItem.titleView = view;
        
         
        
        //        item.title = @"返回";
//        na.tabBarItem.leftBarButtonItem = item1;
        
        na.topViewController.title = titles[i];
        na.navigationBar.tintColor = [UIColor whiteColor];
        na.navigationBar.barTintColor = [UIColor colorWithRed:0.21 green:0.24 blue:0.25 alpha:0.1];

//
        //下面导航条上正常状态时的图片
        NSString *normalImage = imageNames[i];
        //下面导航条上被选中状态时的图片
        NSString *selectedImage = [NSString stringWithFormat:@"%@_press",normalImage];
        
        //下面导航条的项
        UITabBarItem *item = [[UITabBarItem alloc]initWithTitle:titleArray[i] image:[UIImage imageNamed:normalImage] selectedImage:[UIImage imageNamed:selectedImage]];
        
        //设置
        na.tabBarItem = item;
        
        [controllers addObject:na];
        i++;
    }
    
    //创建下面的导航栏
    UITabBarController *tabVC = [[UITabBarController alloc]init];
    
    tabVC.tabBar.barTintColor = [UIColor colorWithRed:0.21 green:0.24 blue:0.25 alpha:0.1];
    
    tabVC.tabBar.tintColor = [UIColor blackColor];
    
    tabVC.viewControllers = controllers;
    
    return  tabVC;

}

//根据类名创建uiviewcontroller 设置为navigation的根视图
+(UINavigationController *)navigationWithClass:(Class)className titles:(NSString *)title{

    
    UIViewController *vc = [[className alloc]init];
    vc.view.backgroundColor = [UIColor colorWithRed:0.21 green:0.24 blue:0.25 alpha:0.1];
    
//    vc.title = title;
//    NSLog(@"%@", [UIFont familyNames]);

    BaseNavigationViewController *baseNaVC = [[BaseNavigationViewController alloc]initWithRootViewController:vc];

    

    return baseNaVC;

}


//点击按钮之后弹出的
-(void)onClick:(UIButton *)button{

    NSLog(@"点击了item");

}





@end
