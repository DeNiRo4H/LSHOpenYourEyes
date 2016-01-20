//
//  UIView+ZWCustomTranstion.m
//  UI-12.01-ViewContoller模态试图控制器
//
//  Created by 张玮 on 15/12/1.
//  Copyright © 2015年 8brother. All rights reserved.
//

#import "UIView+ZWCustomTranstion.h"

@implementation UIView (ZWCustomTranstion)

- (void)setTransitionWithtype:(typeEnum)type subType:(subTypeEnum)subType duration:(NSTimeInterval)duration
{
    //    fade,    //交叉淡化过渡(不支持过渡方向)
    //    push,     //新视图把旧视图推出去
    //    moveIn,   //新视图移到旧视图上面
    //    reveal,   //将旧视图移开,显示下面的新视图
    //    //    注意：
    //    //
    //    //    下面这些私有的动画效果，在实际应用中要谨慎使用。因为在app store审核时可能会以为这些动画效果而拒绝通过。
    //    cube,     //立方体翻滚效果
    //    oglFlip,  //上下左右翻转效果
    //    suckEffect,   //收缩效果，如一块布被抽走(不支持过渡方向)
    //    rippleEffect, //滴水效果(不支持过渡方向)
    //    pageCurl,     //向上翻页效果
    //    pageUnCurl,   //向下翻页效果
    //    cameraIrisHollowOpen, //相机镜头打开效果(不支持过渡方向)
    //    cameraIrisHollowClose //相机镜头关上效果(不支持过渡方向)
    NSArray *typeArray = @[@"fade",@"push",@"moveIn",@"reveal",@"cube",@"oglFlip",@"suckEffect",@"rippleEffect",@"pageCurl",@"pageUnCurl",@"cameraIrisHollowOpen",@"cameraIrisHollowClose"];
    NSArray *subTypeArray = @[@"fromTop",@"fromBottom",@"fromLeft",@"fromRight"];
    CATransition *transition = [CATransition animation];
    transition.type = typeArray[type];
    transition.subtype = subTypeArray[subType];
    transition.duration = duration;
    [self.window.layer addAnimation:transition forKey:nil];
}

@end
