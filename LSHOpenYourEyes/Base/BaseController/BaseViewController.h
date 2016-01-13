//
//  BaseViewController.h
//  LSHOpenYourEyes
//
//  Created by DeNiRo4H on 16-1-11.
//  Copyright (c) 2016年 LSH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RequestManager.h"//请求类

@interface BaseViewController : UIViewController

@property(nonatomic, strong)RequestManager *manager;

@property(nonatomic, strong)NSMutableArray *dataSource;

@end
