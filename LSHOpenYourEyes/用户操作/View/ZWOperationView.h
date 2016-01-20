//
//  ZWOperationView.h
//  网络自习-Day4-电影项目
//
//  Created by 张玮 on 15/12/24.
//  Copyright © 2015年 8brother. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZWOperationViewModel.h"

@interface ZWOperationView : UIView

@property (weak, nonatomic) IBOutlet UIButton *operationButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (nonatomic ,strong) ZWOperationViewModel * model;

+ (ZWOperationView *)operationView;

@end
