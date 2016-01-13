//
//  SelectionViewController.m
//  LSHOpenYourEyes
//
//  Created by DeNiRo4H on 16-1-11.
//  Copyright (c) 2016年 LSH. All rights reserved.
//

#import "SelectionViewController.h"

#import "ScreenMarco.h"
#import "SelectionCell.h"
#import "VideoModel.h"
#import "UrlFile.h"
#import "ListModel.h"
#import "DJRefresh.h"//下拉上拉刷新

static NSString *cellID = @"cellID";

@interface SelectionViewController ()<UITableViewDataSource,UITableViewDelegate>
{

//    NSInteger date;//时间

}


@property(nonatomic, strong)UITableView *tableView;

@end

@implementation SelectionViewController






- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createTableView];

    [self createData];
}

#pragma mark - 创建tableview
-(void)createTableView{
        
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        //cell的高度
        _tableView.rowHeight = 230;
        //代理关系
        _tableView.dataSource = self;
        _tableView.delegate = self;
    
    //分割线去掉
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
        //注册cell
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SelectionCell class]) bundle:nil] forCellReuseIdentifier:cellID];
        
        [self.view addSubview:_tableView];
    
}


#pragma mark - 加载数据

-(void)createData{
    
    
    
    
    
//    NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
//    
//    NSDate *dt = [NSDate date];
//    
//    unsigned unitFlags = NSCalendarUnitYear |NSCalendarUnitMonth | NSCalendarUnitDay |NSCalendarUnitHour| NSCalendarUnitMinute |NSCalendarUnitSecond;
//    NSDateComponents *comp = [gregorian components:unitFlags  fromDate:dt];
//    comp.hour = 8;
//    comp.minute = 0;
//    comp.second = 0;
//    
//    NSDate *date = [gregorian dateFromComponents:comp];
//    
//    NSLog(@"%@", date);
//    
//    
//    NSTimeInterval timeStemp = [date timeIntervalSinceReferenceDate];
//    
//    
//    //请求参数
//    NSInteger timeStemp = 1;
//    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"date":@(timeStemp)];
//
//    NSLog(@"%f",timeStemp);
    
    
    [self.manager requestWithUrl:selectionUrl parameters:nil complicate:^(BOOL success, id object) {
//        NSLog(@"%@", object);
        
        [self.dataSource addObjectsFromArray:object];
       
        [self.tableView reloadData];
        
    } modelClass:[ListModel class]];
    
    
}

#pragma mark - DataSource协议方法

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

     return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    SelectionCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    ListModel *list = self.dataSource[indexPath.row];
    
    VideoModel *model = list.data;
    
    cell.model = model;
    
    return cell;

}



@end
