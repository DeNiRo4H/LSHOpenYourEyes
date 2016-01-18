//
//  DetailViewController.h
//  LSHOpenYourEyes
//
//  Created by DeNiRo4H on 16-1-16.
//  Copyright (c) 2016年 LSH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageModel.h"
#import "CurrentPageModel.h"
#import "ListModel.h"
#import "VideoModel.h"

@interface DetailViewController : UIViewController

@property(nonatomic, strong)CurrentPageModel *currentModel;

@property(nonatomic,assign) NSInteger index;


@end
