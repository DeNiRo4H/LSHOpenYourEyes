//
//  MyCenterDetailViewController.m
//  LSHOpenYourEyes
//
//  Created by DeNiRo4H on 16-1-21.
//  Copyright (c) 2016年 LSH. All rights reserved.
//

#import "MyCenterDetailViewController.h"
#import "SelectionCell.h"
#import "CoraDataManager.h"
#import "ListModel.h"
#import "VideoModel.h"
#import "DetailViewController.h"

static NSString *cellID = @"cellID";
@interface MyCenterDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)NSMutableArray *dataSource;
@end

@implementation MyCenterDetailViewController


-(UITableView *)tableView{
    
    if(_tableView == nil){
        
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _tableView.rowHeight = 230;
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor grayColor];
        
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SelectionCell class]) bundle:nil] forCellReuseIdentifier:cellID];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self createNavigationItem];
    
    [self createDataSource];
  
}




 //从数据库里面取出数据
-(void)createDataSource{
    
    //初始化shuj
    self.dataSource = [NSMutableArray array];
//    NSArray *nameArray = @[@" ",@"我的收藏",@"我的下载",@"我的意见",@"更多应用"];
//    NSLog(@"%ld", [nameArray indexOfObject:self.name]);
    //获取本地数据
    [self.dataSource addObjectsFromArray:[CoraDataManager findAppALL]];
    
    NSLog(@"%@", self.dataSource);
    
    if(self.dataSource.count == 0){
        UILabel *message = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 120)];
//        message.backgroundColor = [UIColor redColor];
        message.text = @"暂无收藏缓存";
        message.center = self.tableView.center;
        message.font = [UIFont systemFontOfSize:18];
        message.textColor = [UIColor yellowColor];
        [_tableView addSubview:message];
    }
    
    [self.tableView reloadData];//刷新
   
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

   return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SelectionCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    ListModel *list = self.dataSource[indexPath.row];
    
    //被选中后的风格
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor grayColor];
    VideoModel *model = list.data;
    
    cell.model = model;
    
    return cell;
   
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DetailViewController *detail = [[DetailViewController alloc]init];
    
    detail.dataSource = self.dataSource;
    detail.index = indexPath.row;
    
    [self.navigationController pushViewController:detail animated:YES];
    
}





@end
