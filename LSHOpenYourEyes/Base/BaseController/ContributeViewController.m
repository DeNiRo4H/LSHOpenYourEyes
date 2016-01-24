//
//  ContributeViewController.m
//  LSHOpenYourEyes
//
//  Created by DeNiRo4H on 16-1-21.
//  Copyright (c) 2016年 LSH. All rights reserved.
//

#import "ContributeViewController.h"

@interface ContributeViewController ()

@end

@implementation ContributeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
}
- (IBAction)button:(id)sender {
    // 1.让按钮失效(文字变为"已下载")

    self.send.enabled = NO;
    // 2.显示下载成功的信息("成功下载xxx")
    UILabel *label = [[UILabel alloc] init];
    label.text = [NSString stringWithFormat:@"欢迎来稿"];
    label.font = [UIFont systemFontOfSize:12];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor blackColor];
    label.frame = CGRectMake(0, 0, 150, 50);
    label.center = self.view.center;
    label.alpha = 0.0;
    
    // 巧妙利用控件的尺寸和圆角半径,能产生一个圆
    label.layer.cornerRadius = 20;
    // 超出主层边界的内容统统剪掉
    //    label.layer.masksToBounds = YES;
    label.clipsToBounds = YES;
    
    [self.view addSubview:label];
    
    // 3.动画
    [UIView animateWithDuration:1.0 animations:^{
        label.alpha = 0.5;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.0 delay:1.0 options:UIViewAnimationOptionCurveLinear animations:^{
            label.alpha = 0.0;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{

    [self.name resignFirstResponder];
    [self.email resignFirstResponder];
    [self.playName resignFirstResponder];
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
