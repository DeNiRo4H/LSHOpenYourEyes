//
//  FeedBackViewController.m
//  LSHOpenYourEyes
//
//  Created by DeNiRo4H on 16-1-21.
//  Copyright (c) 2016年 LSH. All rights reserved.
//

#import "FeedBackViewController.h"
#import "ScreenMarco.h"

#define changeHeight 20

@interface FeedBackViewController ()<UITextFieldDelegate,UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UITextField *textField;


@end

@implementation FeedBackViewController

- (IBAction)send:(id)sender {
    
    // 1.让按钮失效(文字变为"已下载")
   self.send.enabled = NO;
    
    // 2.显示下载成功的信息("成功下载xxx")
    UILabel *label = [[UILabel alloc] init];
    label.text = [NSString stringWithFormat:@"发送成功"];
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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    [self createButton];
}


-(void)createButton{
    
    NSArray *name = @[@"喜欢",@"不喜欢",@"还行"];
    for(int i=0 ;i< 3;i++){
    
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(i*80+ 50, 160, 60, 40)];
//        button.backgroundColor = [UIColor redColor];
        [button setTitle:name[i] forState:UIControlStateNormal];
//        button.titleLabel.font
        
        button.tag = i +10;
        [button addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:button];
        
        UIButton *button1 = [[UIButton alloc]initWithFrame:CGRectMake(i*80+ 50, 280, 60, 40)];
        button1.tag  = i + 20;
        [button1 addTarget:self action:@selector(twoOnClick:) forControlEvents:UIControlEventTouchUpInside];
        //        button.backgroundColor = [UIColor redColor];
        [button1 setTitle:name[i] forState:UIControlStateNormal];
        //        button.titleLabel.font
        [self.view addSubview:button1];
    }

}


-(void)onClick:(UIButton *)button{
    UIButton *button0 = (UIButton *)[self.view viewWithTag:10];
    UIButton *button1 = (UIButton *)[self.view viewWithTag:11];
    UIButton *button2 = (UIButton *)[self.view viewWithTag:12];
    if (button.tag - 10 ==0) {
        [button setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
        [button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    if (button.tag -10 ==1){
        
        [button1 setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
        [button0 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
       
    }
    if (button.tag -10 ==2){
        
        [button2 setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
        [button0 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
    }
    

}
-(void)twoOnClick:(UIButton *)button{
    UIButton *button0 = (UIButton *)[self.view viewWithTag:20];
    UIButton *button1 = (UIButton *)[self.view viewWithTag:21];
    UIButton *button2 = (UIButton *)[self.view viewWithTag:22];
    if (button.tag - 20 ==0) {
        [button setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
        [button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    if (button.tag -20 ==1){
        
        [button1 setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
        [button0 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
    }
    if (button.tag -20 ==2){
        
        [button2 setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
        [button0 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
    }

  
}

//文本return时
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    self.navigationController.navigationBarHidden = NO;
    return YES;

}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{

    [self.textField resignFirstResponder];
    [self.textView resignFirstResponder];
    self.navigationController.navigationBarHidden = NO;
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
