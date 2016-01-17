//
//  TitleView.m
//  TitleScrollView
//
//  Created by 任前辈 on 16/1/6.
//  Copyright © 2016年 SingleProgrammers. All rights reserved.
//

#import "TitleView.h"
#import "ScreenMarco.h"
#define FontSize  16

@interface TitleView()

@property(nonatomic,strong)UIScrollView * scrollView;


@property(nonatomic,strong)UIView * lineView;//线

@end

@implementation TitleView


-(void)setTitles:(NSArray *)titles{
    
    _titles = titles;
    //更新视图显示的内容
    
    [self initView];
    
}


- (UIView *)lineView{
    
    if (_lineView == nil) {
        _lineView = [[UIView alloc] initWithFrame:CGRectZero];
        _lineView.backgroundColor = [UIColor blackColor];
        [self.scrollView addSubview:_lineView];
    }
    
    return _lineView;
}

//初始化子视图
- (void)initView{
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];

    //设置 内容大小
    self.scrollView.contentSize = CGSizeMake([self totalWidth], self.frame.size.height);
    
    [self selectIndex:0];//默认选中第一个
    
    //将scrollView添加到视图上
    [self addSubview:self.scrollView];
    
}
//算出总宽度  并且添加了button
-(float)totalWidth{
    
    float width = 0;
    
    for (NSString * title in _titles) {
        
        float buttonWidth = self.frame.size.width/_titles.count;//button的宽

        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];

        button.frame = CGRectMake(width, 0, buttonWidth, self.frame.size.height);
       
        button.titleLabel.font = [UIFont systemFontOfSize:FontSize];
        
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
        [button setTitle:title forState:UIControlStateNormal];
        
       
        
        [self.scrollView addSubview:button];
        
        width += buttonWidth;
        
        //设置 button的选址状态的颜色
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        
        [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        
//        [button setBackgroundColor:[UIColor redColor]];
        
        [self.buttons addObject:button];
        
    }
    
    return width;//返回总长度
}

-(NSMutableArray *)buttons{
    
    if (_buttons == nil) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

//点击 button 告诉使用者 你点击了 第几个button
-(void)clickButton:(UIButton*)button{

    if (button.selected) {//如果已经选中 直接返回
        return;
    }
    
    for (UIButton * b in _buttons) {
        b.selected = NO;
    }
    
    button.selected = YES;
    
   [UIView animateWithDuration:0.3 animations:^{
      //修改线的位置
       self.lineView.frame = CGRectMake(button.frame.origin.x, self.frame.size.height - 1, button.frame.size.width, 3);
       
   }];
    
    //如果代理对象 可以响应方法
    if ([self.delegate respondsToSelector:@selector(titleView:selectIndex:)]) {
        
        [self.delegate titleView:self selectIndex:[self.buttons indexOfObject:button]];
        
    }
    
    
    
}


//选中第几个
-(void)selectIndex:(NSInteger)index{
    
    
    UIButton * button = self.buttons[index];
    
    
    for (UIButton * b in _buttons) {
        b.selected = NO;
    }
    
    button.selected = YES;
    
    //修改线的位置
    self.lineView.frame = CGRectMake(button.frame.origin.x, self.frame.size.height - 3, button.frame.size.width, 3);
    
}



@end
