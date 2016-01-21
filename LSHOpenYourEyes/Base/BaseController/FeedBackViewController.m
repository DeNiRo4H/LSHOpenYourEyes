//
//  FeedBackViewController.m
//  LSHOpenYourEyes
//
//  Created by DeNiRo4H on 16-1-21.
//  Copyright (c) 2016年 LSH. All rights reserved.
//

#import "FeedBackViewController.h"
#import "ScreenMarco.h"

@interface FeedBackViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *send;

@end

@implementation FeedBackViewController

- (IBAction)send:(id)sender {
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    [self createButton];
}


-(void)createButton{
    
    NSArray *name = @[@"喜欢",@"不喜欢",@"还行"];
    for(int i=0 ;i< 3;i++){
    
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(i*80+ 80, 160, 60, 40)];
//        button.backgroundColor = [UIColor redColor];
        [button setTitle:name[i] forState:UIControlStateNormal];
//        button.titleLabel.font
        [self.view addSubview:button];
        
        UIButton *button1 = [[UIButton alloc]initWithFrame:CGRectMake(i*80+ 80, 280, 60, 40)];
        //        button.backgroundColor = [UIColor redColor];
        [button1 setTitle:name[i] forState:UIControlStateNormal];
        //        button.titleLabel.font
        [self.view addSubview:button1];
    }

}

//文本return时
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;

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
