//
//  LSHMoviePlayerViewController.h
//  LSHOpenYourEyes
//
//  Created by DeNiRo4H on 16-1-19.
//  Copyright (c) 2016年 LSH. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LSHMoviePlayerViewControllerDelegate <NSObject>

-(void)moviePlayerDidFinished;

@end


@interface LSHMoviePlayerViewController : UIViewController

@property(nonatomic, strong)NSString *movieURL;
@property(nonatomic ,assign)id<LSHMoviePlayerViewControllerDelegate>delegate;

@end
