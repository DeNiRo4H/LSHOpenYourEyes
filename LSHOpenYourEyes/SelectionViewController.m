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
#import "PageModel.h"
#import "CurrentPageModel.h"
#import "DetailViewController.h"

static NSString *cellID = @"cellID";

@interface SelectionViewController ()<UITableViewDataSource,UITableViewDelegate,DJRefreshDelegate>
{

    NSInteger _date;//时间
    
    NSInteger _pageFlag;
    
    NSString *_nextPage;
    
    NSInteger _day;
    
   
}

@property(nonatomic, strong)DJRefresh *refresh;

@property(nonatomic, strong)UITableView *tableView;

@end

@implementation SelectionViewController






- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createTableView];
    
    _pageFlag = 1;//初始值
    _day = 1;
    //设置背景色
    self.view.backgroundColor = [UIColor grayColor];

    [self FirstLoadDataWithUrl:selectionUrl parameters:nil];
    
    [self loadBodyDataWithUrl:selectionUrl parameters:nil];
}

#pragma mark - 创建tableview
-(void)createTableView{
        
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        //cell的高度
        _tableView.rowHeight = 230;
        //代理关系
        _tableView.dataSource = self;
        _tableView.delegate = self;
    
    
//    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //分割线去掉
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
        //注册cell
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SelectionCell class]) bundle:nil] forCellReuseIdentifier:cellID];
        
        [self.view addSubview:_tableView];
    
    
    //创建上拉下拉刷新
    _refresh = [[DJRefresh alloc]initWithScrollView:_tableView delegate:self];
    
    //允许上拉下拉
    _refresh.topEnabled = YES;
    _refresh.bottomEnabled = YES;

    
}


#pragma mark - 加载数据

-(void)FirstLoadDataWithUrl:(NSString *)urlString parameters:(NSDictionary *)dic {
    
    
    //请求得到一些有关页面的属性
    /**
     *  本次请求分为两次 第一次:请求数据外层的一些属性  第二次:请求数据里层的属性
     *
     *  @param success 请求成功
     *  @param object  二进制数据
     *
     *  @return
     */
    [self.manager requestWithUrl:urlString parameters:dic complicate:^(BOOL success, id object) {

        //jsonModel 解析得到
        PageModel *model = [[PageModel alloc]initWithDictionary:object error:nil];
        
//        CurrentPageModel *currentModel = [[CurrentPageModel alloc]init];
//        
//        NSDictionary *dict = [object[@"issueList"] firstObject];
//        currentModel = [currentModel initWithDictionary:dict error:nil];
//        model.currentModel = currentModel;
//        
//        //当前天的日期
//        _date = model.currentModel.publishTime;

        //得到下一页
        _nextPage = model.nextPageUrl;
        
        
        
    } modelClass:[PageModel class]];
    
}

/**
 *  加载主要数据
 */
-(void)loadBodyDataWithUrl:(NSString *)urlString parameters:(NSDictionary *)dict{
    
    [self.refresh finishRefreshing];//结束刷新
    
    [self.manager requestWithUrl:urlString parameters:dict complicate:^(BOOL success, id object) {
     
        if(success == YES){//请求成功
            
            //如果是第一页的话清除数组的所有数据
            if(_pageFlag == 1){
                [self.dataSource removeAllObjects];
            }
            
            [self.dataSource addObject:object];
           
            //刷新tableView
            [self.tableView reloadData];
        }
    
    } modelClass:[CurrentPageModel class]];
    
}


#pragma mark - DataSource协议方法

//返回每组多少行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    CurrentPageModel *currentPageModel = self.dataSource[section];
    
    NSArray *array = currentPageModel.itemList;
    
    ListModel *list = [array firstObject];
    
    if([list.type isEqualToString:@"textHeader"]){
        
       return  array.count - 1;
        
    }
    
    return array.count;
}



//返回多少组
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return self.dataSource.count;
}

//返回组标题
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    
    CurrentPageModel *currentPageModel = self.dataSource[section];
    
    NSDate *date1 = [[NSDate alloc]initWithTimeIntervalSinceNow:-3600*24*_day];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"MM-dd"];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:date1];
    
    NSLog(@"%@",currentDateStr);
    
    
    ListModel *firstList = currentPageModel.itemList[0];
     //如果第一个的type值为textHeader就返回日期,否则不返回
    if([firstList.type isEqualToString:@"textHeader"]){
    
//     return [NSString stringWithFormat:@"%ld", currentPageModel.date];
        return currentDateStr;
        
    }
    
    
    
    return  nil;
    
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    SelectionCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    CurrentPageModel *currentPageModel = self.dataSource[indexPath.section];
    
    ListModel *list = [[ListModel alloc]init];
    
    //得到列表第一个model
    ListModel *firstList = currentPageModel.itemList[0];
    
    //获得每组显示的列表
   //如果列表中第一个为textHeader 从第二个开始
    if([firstList.type isEqualToString:@"textHeader"]){
        
        list = currentPageModel.itemList[indexPath.row +1];
    }else{
         list = currentPageModel.itemList[indexPath.row];
    }
    VideoModel *model = list.data;
    
    cell.model = model;
    
    return cell;

}

/**
 *  选中某个cell的后跳转
 *
 */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    DetailViewController *detail = [[DetailViewController alloc]init];
    
    //dataSource里面放的是一天的内容 ,注意:有些有六个数据,
    
    //详细页面记得要判断,不然的话容易报错
    detail.dataSource = self.dataSource;
    
    [self.navigationController pushViewController:detail
        animated:YES];
    
 
}






#pragma mark - 创建DJFresh
-(void)refresh:(DJRefresh *)refresh didEngageRefreshDirection:(DJRefreshDirection)direction{

    if(direction == DJRefreshDirectionTop){
        
        _pageFlag = 1;//设置为第一页
        
        //重新请求今天的页数
        [self loadBodyDataWithUrl:selectionUrl parameters:nil];
        
    }else if(direction == DJRefreshDirectionBottom){
        
        //先保存上一次请求的下一页
        NSString *nextpage = _nextPage;
        
         _pageFlag ++;
        
        
//        NSLog(@"%ld", _pageFlag);
//        NSLog(@"%@", nextpage);
        
        //获取当前页的日期和下一页的url
        [self FirstLoadDataWithUrl:_nextPage parameters:nil];
        
        //根据nextPage获取下一页的内容
        [self loadBodyDataWithUrl:nextpage parameters:nil];
    }

}


@end
