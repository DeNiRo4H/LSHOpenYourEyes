//
//  ZWOperationView.m
//  网络自习-Day4-电影项目
//
//  Created by 张玮 on 15/12/24.
//  Copyright © 2015年 8brother. All rights reserved.
//

#import "ZWOperationView.h"

@implementation ZWOperationView

+ (ZWOperationView *)operationView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"ZWOperationView" owner:nil options:nil] lastObject];
}

- (void)setModel:(ZWOperationViewModel *)model
{
    _model = model;
    self.backgroundColor = [UIColor clearColor];
    [_operationButton setBackgroundImage:[UIImage imageNamed:_model.imageName] forState:UIControlStateNormal];
    _titleLabel.text = _model.title;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
