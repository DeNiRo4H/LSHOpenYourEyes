//
//  BaseNavigationViewController.m
//  LSHOpenYourEyes
//
//  Created by DeNiRo4H on 16-1-11.
//  Copyright (c) 2016年 LSH. All rights reserved.
//

#import "BaseNavigationViewController.h"

@interface BaseNavigationViewController ()

@end

@implementation BaseNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //没有效果......
    self.navigationBar.titleTextAttributes = @{
                                               NSFontAttributeName:[UIFont fontWithName:@"Snell Roundhand" size:20],
                                               };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
