//
//  MyCenterViewController.h
//  LSHOpenYourEyes
//
//  Created by DeNiRo4H on 16-1-21.
//  Copyright (c) 2016年 LSH. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyCenterViewDelegate <NSObject>

-(void)onClickWithLeftNavigationItem;

@end

@interface MyCenterViewController : UIViewController

@property(nonatomic, weak)id<MyCenterViewDelegate>delegate;

@end
