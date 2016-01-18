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


@end

@implementation RootVCManager


+(UIViewController *)rootVC{
    
    //类名数组
    NSArray *array = @[@"SelectionViewController",@"SpecialViewController",@"HotRenkingViewController"];
    //设置图片数组
    NSArray *imageNames = @[@"selection",@"special",@"hotRanking"];
    
      NSArray *titles = @[@"每日精选",@"专题",@"热门排行"];
    
    NSMutableArray *controllers = [NSMutableArray array];
    
    int i = 0 ;
    for(NSString *name in array){
        
        //根据名字得到navigation
        UINavigationController *na = [RootVCManager navigationWithClass:NSClassFromString(name) titles:titles[i]];
        na.topViewController.title = titles[i];
        

//
        //下面导航条上正常状态时的图片
        NSString *normalImage = imageNames[i];
        //下面导航条上被选中状态时的图片
        NSString *selectedImage = [NSString stringWithFormat:@"%@_press",normalImage];
        
        //下面导航条的项
        UITabBarItem *item = [[UITabBarItem alloc]initWithTitle:titles[i] image:[UIImage imageNamed:normalImage] selectedImage:[UIImage imageNamed:selectedImage]];
        
        //设置
        na.tabBarItem = item;
        
        [controllers addObject:na];
        i++;
    }
    
    //创建下面的导航栏
    UITabBarController *tabVC = [[UITabBarController alloc]init];
    
    tabVC.tabBar.barTintColor = [UIColor whiteColor];
    
    tabVC.tabBar.tintColor = [UIColor blackColor];
    
    tabVC.viewControllers = controllers;
    
    return  tabVC;

}

//根据类名创建uiviewcontroller 设置为navigation的根视图
+(UINavigationController *)navigationWithClass:(Class)className titles:(NSString *)title{

    
    UIViewController *vc = [[className alloc]init];
    
//    vc.title = title;
//    NSLog(@"%@", [UIFont familyNames]);

    BaseNavigationViewController *baseNaVC = [[BaseNavigationViewController alloc]initWithRootViewController:vc];
  
    return baseNaVC;

}


@end
