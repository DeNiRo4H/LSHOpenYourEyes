//
//  MyCenterViewController.m
//  LSHOpenYourEyes
//
//  Created by DeNiRo4H on 16-1-21.
//  Copyright (c) 2016年 LSH. All rights reserved.
//

#import "MyCenterViewController.h"
#import "MyCenterCell.h"
#import "MyCenterDetailViewController.h"
#import "ScreenMarco.h"
#import "FeedBackViewController.h"
#import "ContributeViewController.h"

static NSString *cellID = @"cellID";

@interface MyCenterViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic ,strong)UITableView *tableView;

@property(nonatomic, strong)NSMutableArray *dataSource;

@end

@implementation MyCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    [self createNavigationItem];
    [self createNavigationBar];
    [self createDataSource];
}

-(void)createNavigationBar{
    
    UINavigationController *nc = self.navigationController;
    nc.navigationBar.barTintColor = [UIColor colorWithRed:0.21 green:0.24 blue:0.25 alpha:0.1];
    //    nc.navigationBar.barStyle = UIBarStyleBlack;
    //设置为不透明,它默认是透明的
//    nc.navigationBar.translucent =  NO;
    
}

-(void)createNavigationItem{
    
    //添加导航栏左侧的item,
    UIImage *image = [UIImage imageNamed:@"sanheng.png"];
    UIImage *lImage = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:lImage style:UIBarButtonItemStylePlain  target:self action:@selector(onClick:)];
    
    self.navigationItem.leftBarButtonItem = item;
    
    
    
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
    
    shadow.shadowOffset = CGSizeMake(0, 1);
    [self.navigationController.navigationBar setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
    [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0], NSForegroundColorAttributeName,shadow, NSShadowAttributeName,
    [UIFont fontWithName:@ "Snell Roundhand"  size:25.0], NSFontAttributeName, nil]];
    self.navigationController.topViewController.title = @"MYCENTER";
    
}

////如果点击了左边item 让推出的控制器释放(谁申请谁释放)
//先不写了,控制器设计没还没弄好,......
//-(void)onClick:(UIBarButtonItem *)barButton{
//
//    if([self.delegate respondsToSelector:@selector(onClickWithLeftNavigationItem)]){
//        
//        [self.delegate onClickWithLeftNavigationItem];
//    }
//}

-(void)onClick:(UIBarButtonItem *)barButton{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


-(UITableView *)tableView{

    if(_tableView == nil){
        
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.rowHeight = 100;
        _tableView.dataSource = self;
        _tableView.delegate = self;
         _tableView.backgroundColor = [UIColor grayColor];
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        
        UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KscreenWidth, 200)];
        footView.backgroundColor = [UIColor grayColor];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(KscreenWidth/2-150/2, 130, 150, 40)];
//        label.center = footView.center;
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"Vision 1.0";
        label.font = [UIFont fontWithName:@ "Snell Roundhand"  size:25.0];
        [footView addSubview:label];

        _tableView.tableFooterView = footView;
        
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MyCenterCell class]) bundle:nil] forCellReuseIdentifier:cellID];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
/**
 *  制作假数据
 */
-(void)createDataSource{
    NSArray *nameArray = @[@"我的收藏",@"我的下载",@"我的意见",@"投稿"];
   
    self.dataSource = [NSMutableArray array];
    
    [self.dataSource addObjectsFromArray:nameArray];
    [self.tableView reloadData];
}




-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    MyCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor grayColor];
    cell.name.text = self.dataSource[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MyCenterDetailViewController *myCenterDetail = [[MyCenterDetailViewController alloc]init];
    
    if (indexPath.row == 2) {
        FeedBackViewController *feedBack = [[FeedBackViewController alloc]init];
        [self.navigationController pushViewController:feedBack animated:YES];
    }else if(indexPath.row == 3){
        ContributeViewController *contribute = [[ContributeViewController alloc]init];
        [self.navigationController pushViewController:contribute animated:YES];
       
    }
        else{
    myCenterDetail.name = self.dataSource[indexPath.row];
    [self.navigationController pushViewController:myCenterDetail animated:YES];
    }
}



#pragma mark - 毛玻璃效果视图

- (void)setupFrostedGlassView
{
    //UIBlurEffect 模糊效果
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];// 模糊效果
    //UIVisualEffectView 视图效果 创建时绑定 效果
    UIVisualEffectView *frostedGlassView = [[UIVisualEffectView alloc] initWithEffect:blur];
    
    frostedGlassView.frame = self.view.bounds;
    
    [self.view addSubview:frostedGlassView];
}



@end
