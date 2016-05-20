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
#import "MyCenterViewController.h"
#import "MBProgressHUD.h"



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
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [self FirstLoadDataWithUrl:selectionUrl parameters:nil];
    
    [self loadBodyDataWithUrl:selectionUrl parameters:nil];
    
    [self createNavigationItem];
}
-(void)createNavigationItem{
  
    
    //添加导航栏左侧的item,
    UIImage *image = [UIImage imageNamed:@"sanheng.png"];
    UIImage *lImage = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:lImage style:UIBarButtonItemStylePlain  target:self action:@selector(onClick:)];
    
    
    self.navigationItem.leftBarButtonItem = item;
}

-(void)onClick:(UIBarButtonItem *)barButton{

    MyCenterViewController *center = [[MyCenterViewController alloc]init];
    UINavigationController *na = [[UINavigationController alloc]initWithRootViewController:center];
    
    [self presentViewController:na animated:YES completion:^{
        
    }];
    
}



#pragma mark - 创建tableview
-(void)createTableView{
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,64, WIDTH, HEITHT -110) style:UITableViewStylePlain];
        //cell的高度
        _tableView.rowHeight = 230;
        //代理关系
        _tableView.dataSource = self;
        _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor grayColor];
    
    //自动调整tableview和导航条的位置
    self.automaticallyAdjustsScrollViewInsets = NO;
    
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
        if(success){
        //jsonModel 解析得到
        PageModel *model = [[PageModel alloc]initWithDictionary:object error:nil];
        //得到下一页
        _nextPage = model.nextPageUrl;
        }
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    } modelClass:[PageModel class]];
    
}

/**
 *  加载主要数据
 */
-(void)loadBodyDataWithUrl:(NSString *)urlString parameters:(NSDictionary *)dict{
    
//    [self.refresh finishRefreshing];//结束刷新
    [self.refresh finishRefreshingDirection:DJRefreshDirectionBottom animation:YES];
    [self.refresh finishRefreshingDirection:DJRefreshDirectionTop animation:YES];
    
    [self.manager requestWithUrl:urlString parameters:dict complicate:^(BOOL success, id object) {
     
        if(success == YES){//请求成功
            
            //如果是第一页的话清除数组的所有数据
            if(_pageFlag == 1){
                [self.dataSource removeAllObjects];
            }

            [self.dataSource addObject:object];
            
            //刷新tableView
            [self.tableView reloadData];
        }else{
            if(_pageFlag > 1){
              _pageFlag--;
            }
        }
    
    } modelClass:[CurrentPageModel class]];
    
}


#pragma mark - DataSource协议方法

//返回每组多少行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    CurrentPageModel *currentPageModel = self.dataSource[section];
//    NSString *type = currentPageModel.type;//nomal 或者weekendExtra//campaign
    
    NSArray *array = currentPageModel.itemList;
    
    ListModel *firstList = [array firstObject];
    ListModel *lastList = [array lastObject];
    int count = 0;
    if(!([firstList.type isEqualToString:@"video"])){
        count++;
    }
    if (!([lastList.type isEqualToString:@"video"])){
        count++;
    }

    
    return array.count - count;
}



//返回多少组
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return self.dataSource.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEITHT/15)];
    view.backgroundColor  = [UIColor grayColor];
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,WIDTH, HEITHT/15)];
    title.center = view.center;
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor whiteColor];
//    title.backgroundColor = [UIColor redColor];
    title.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
    
    
    
    CurrentPageModel *currentPageModel = self.dataSource[section];
    long long int time = currentPageModel.date;
    
    NSDate *timeDate = [[NSDate alloc]initWithTimeIntervalSince1970:time/1000.0];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"MM-dd"];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:timeDate];
    
    //    NSLog(@"%@",currentDateStr);
    
    
    ListModel *firstList = currentPageModel.itemList[0];
    
    NSMutableString *mutString  = [NSMutableString string];
    //如果第一个的type值为textHeader就返回日期,否则不返回
    if([firstList.type isEqualToString:@"textHeader"]){
        
        //     return [NSString stringWithFormat:@"%ld", currentPageModel.date];
        [mutString appendString:currentDateStr];
        
    }else if([firstList.type isEqualToString:@"imageHeader"]){
        //如果itemList第一个元素为weekendExtra 的时候 组头视图为weekendExtra
        
        [mutString appendString:currentPageModel.type];
    }else if ([firstList.type isEqualToString:@"campaign"]){
         [mutString appendString:currentDateStr];
    }
    
    
    
    
    // 设置标题属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSFontAttributeName] = [UIFont fontWithName:@ "Snell Roundhand"  size:25.0];
    title.attributedText = [[NSAttributedString alloc]initWithString:mutString attributes:textAttrs];
    
    [view addSubview:title];
 
    return view;

}

//返回组标题
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    
    CurrentPageModel *currentPageModel = self.dataSource[section];
    long long int time = currentPageModel.date;
    
    NSDate *timeDate = [[NSDate alloc]initWithTimeIntervalSince1970:time/1000.0];

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"MM-dd"];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:timeDate];
    
//    NSLog(@"%@",currentDateStr);
    
    
    ListModel *firstList = currentPageModel.itemList[0];
     //如果第一个的type值为textHeader就返回日期,否则不返回
    if([firstList.type isEqualToString:@"textHeader"]){
    
//     return [NSString stringWithFormat:@"%ld", currentPageModel.date];
        return currentDateStr;
        
    }else if([firstList.type isEqualToString:@"imageHeader"]){
        //如果itemList第一个元素为weekendExtra 的时候 组头视图为weekendExtra
        return currentPageModel.type;
    }else if ([firstList.type isEqualToString:@"campaign"]){
      return currentDateStr;
    }
    
    
    return  nil;
    
}
//



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    SelectionCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    CurrentPageModel *currentPageModel = self.dataSource[indexPath.section];
    
    ListModel *list = [[ListModel alloc]init];
    
    //得到列表第一个model
    ListModel *firstList = currentPageModel.itemList[0];
    
    //获得每组显示的列表
   //如果列表中第一个为textHeader 从第二个开始
//    if([firstList.type isEqualToString:@"textHeader"]||[firstList.type isEqualToString:@"imageHeader"]||[firstList.type isEqualToString:@"campaign"]||[firstList.type isEqualToString:@"banner1"]){
    if(![firstList.type isEqualToString:@"video"]){
        list = currentPageModel.itemList[indexPath.row +1];
    }else{
         list = currentPageModel.itemList[indexPath.row];
    }
    VideoModel *model = list.data;
    cell.model = model;
    
    

    //cell被选中的风格
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor grayColor];
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
   CurrentPageModel *currentPageModel = self.dataSource[indexPath.section];
    
//    NSLog(@"%@",currentPageModel);
    
    //这一天的数据传过去
    detail.currentModel = currentPageModel;
    detail.index = indexPath.row;
    
    [self.navigationController pushViewController:detail
        animated:YES];
    
}


#pragma mark - 创建DJFresh
-(void)refresh:(DJRefresh *)refresh didEngageRefreshDirection:(DJRefreshDirection)direction{

    if(direction == 0){
        
        _pageFlag = 1;//设置为第一页
        
        //重新请求今天的页数
        [self loadBodyDataWithUrl:selectionUrl parameters:nil];
         [self.refresh finishRefreshingDirection:DJRefreshDirectionTop animation:YES];
        
    }else if(direction == DJRefreshDirectionTop){
        
        //先保存上一次请求的下一页
        NSString *nextpage = _nextPage;
        
         _pageFlag ++;

        //获取当前页的日期和下一页的url
        [self FirstLoadDataWithUrl:_nextPage parameters:nil];
        
        //根据nextPage获取下一页的内容
        [self loadBodyDataWithUrl:nextpage parameters:nil];
    }

}


@end
