//
//  DetailSpecailViewController.m
//  LSHOpenYourEyes
//
//  Created by DeNiRo4H on 16-1-19.
//  Copyright (c) 2016年 LSH. All rights reserved.
//

#import "DetailSpecailViewController.h"
#import "TitleView.h"
#import "ScreenMarco.h"
#import "UrlFile.h"
#import "SelectionCell.h"
#import "ListModel.h"
#import "DJRefresh.h"
#import "PageModel.h"
#import "DetailViewController.h"
#import "MyCenterViewController.h"

#define tableViewTag 40

static NSString *cellID = @"cellID";

//头上的三个标题
typedef enum titleType{
    date = 0,
    shareCount,
}TitleType;

@interface DetailSpecailViewController ()<UITableViewDelegate,TitleViewDelegate,UITableViewDataSource,DJRefreshDelegate>
{

    NSString *_nextPage[2];
    NSInteger _flag;
}

@property(nonatomic, strong)NSMutableArray *dataSources;

@property(nonatomic, strong)UIScrollView *scrollView;

@property(nonatomic, strong)TitleView *titleView;
//@property(nonatomic, strong)DJRefresh *refresh;
@property(nonatomic,strong)NSMutableArray * refreshs;//保留下拉控件
@end

@implementation DetailSpecailViewController



-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    //隐藏
    self.tabBarController.tabBar.hidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = NO;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _flag = 0;
    //创建titleview
    [self createTitleView];
    [self createScrollView];

    //第一次请求得到当前数据的下一页的请求地址url
    //坑,要先得到page数组的  两个  page  不然出错
    [self FirstLoadDataWithUrl:specialUrl withType:date];
    [self FirstLoadDataWithUrl:specialUrl withType:shareCount];
    
    [self loadDataWithType:date withURL:specialUrl];
    
}





/**
 *  创建titleView
 */
-(void)createTitleView{
    //不知道这个位置怎么搞得???
    self.titleView = [[TitleView alloc]initWithFrame:CGRectMake(0, -60,KscreenWidth, 150)];
    self.titleView.titles = @[@"按时间排序",@"分享排行榜"];
    //建立代理
    self.titleView.delegate = self;
    [self.view addSubview:self.titleView];
}
/**
 *  创建scrollview
 */
-(void)createScrollView{
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,90, KscreenWidth, KscreenHeight-90)];
    //翻页
    self.scrollView.pagingEnabled = YES;
    
    //创建tableview
    [self createTableView];
    
    //设置scrollview的大小
    self.scrollView.contentSize = CGSizeMake(KscreenWidth*2, self.scrollView.frame.size.height);
    
    self.scrollView.delegate = self;
    
    [self.view addSubview:self.scrollView];
    
}

/**
 *  创建tableView
 */
-(void)createTableView{
    //初始化话大数组(数组里面放了tableview的小数组)
    self.dataSources = [NSMutableArray array];
    //初始化刷新
    self.refreshs = [NSMutableArray array];
    
    for(int i = 0;i<2;i++){
        
        NSMutableArray *array = [[NSMutableArray alloc]init];
        
        //将小数组添加到大数组
        [self.dataSources addObject:array];
        
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(i*self.scrollView.frame.size.width, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height) style:UITableViewStylePlain];
        
        tableView.tag = i + tableViewTag;
        
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        tableView.rowHeight = 230;
        
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.backgroundColor = [UIColor grayColor];
        //注册
        [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SelectionCell class]) bundle:nil] forCellReuseIdentifier:cellID];
        
        [self.scrollView addSubview:tableView];
        
        
        //创建上拉刷新
        DJRefresh * refresh = [[DJRefresh alloc]initWithScrollView:tableView delegate:self];
        refresh.bottomEnabled = YES;//开启上拉刷新
        refresh.delegate = self;//代理
        
        //refresh需要被保留一次
        [self.refreshs addObject:refresh];
        
        
    }
    
}



#pragma mark - 加载数据

-(void)FirstLoadDataWithUrl:(NSString *)urlString withType:(TitleType)type{
    
    
    //请求得到一些有关页面的属性
    /**
     *  本次请求分为两次 第一次:请求数据外层的一些属性  第二次:请求数据里层的属性
     *
     *  @param success 请求成功
     *  @param object  二进制数据
     *
     *  @return
     */
    NSArray *typeStr = @[@"date",@"shareCount"];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:
                                @{@"start":@0,@"num":@10,@"categoryName":self.categoryName,@"strategy":typeStr[type]}];
    if (_flag == 1) {
        dic = nil;
    }
    
    [self.manager requestWithUrl:urlString parameters:dic complicate:^(BOOL success, id object) {
        
        //jsonModel 解析得到
        PageModel *model = [[PageModel alloc]initWithDictionary:object error:nil];
        
        //得到下一页
        _nextPage[type] = model.nextPageUrl;
        
    } modelClass:[PageModel class]];
    
}




#pragma mark - 加载数据
//根据类型(哪个tabview)来加载数据
-(void)loadDataWithType:(TitleType )type withURL:(NSString *)urlString{
    
    
    
    NSArray *typeStr = @[@"date",@"shareCount"];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:
   @{@"start":@0,@"num":@10,@"categoryName":self.categoryName,@"strategy":typeStr[type]}];
    
    if(_flag == 1){
        dic = nil;
    }
    
    [self.manager requestWithUrl:urlString parameters:dic complicate:^(BOOL success, id object) {
        //根据下拉空间刷新动画
        DJRefresh *refresh = [self.refreshs objectAtIndex:type];
        [refresh finishRefreshing];//结束刷新
        
        [self.dataSources[type] addObjectsFromArray:object];
        
        //创新tableview
        [[self tableViewWithType:type] reloadData];
        
    } modelClass:[ListModel class]];
}

-(UITableView  *)tableViewWithType:(TitleType)type{
    
    return (UITableView *)[self.scrollView viewWithTag:type+tableViewTag];
}


#pragma mark - tableViewDelegate 协议方法
//返回没每组多少行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.dataSources[tableView.tag - tableViewTag] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SelectionCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    ListModel *list = self.dataSources[tableView.tag - tableViewTag][indexPath.row];
    
    //被选中后的风格
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor grayColor];
    VideoModel *model = list.data;
    cell.model = model;
    
//    cell.image.image = nil;
//    NSString *publishTime = [NSString stringWithFormat:@"%ld",currentPageModel.publishTime];
//    [self.manager requestWithUrl:selectionUrl parameters:@{@"date":publishTime} complicate:^(BOOL success, id object) {
//        if (cell.model == model) {
//            if (success) {
//                [cell.image setImageWithURL:[NSURL URLWithString:model.cover.feed]];
//            }
//        }
//        
//    } modelClass:[CurrentPageModel class]];
    
    
    
    return cell;
    
}


#pragma mark - scrollviewdelegate协议方法
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if (self.scrollView == scrollView) {
        
        NSInteger index = self.scrollView.contentOffset.x / self.scrollView.frame.size.width;
        
        [self.titleView clickButton:self.titleView.buttons[index]];
    }
    
}

#pragma mark titleViewDelegate 协议方法
-(void)titleView:(TitleView *)view selectIndex:(NSInteger)index{
//    NSLog(@"选中第%ld个button",index);
    
    self.scrollView.contentOffset = CGPointMake(index * WIDTH, 0);
    
       _flag = 0;
    [self loadDataWithType:(TitleType)index withURL:specialUrl];
   
}

#pragma mark - 刷新结束
-(void)refresh:(DJRefresh *)refresh didEngageRefreshDirection:(DJRefreshDirection)direction{
    
      TitleType type = (TitleType)(refresh.scrollView.tag - tableViewTag);
    
    if(direction == DJRefreshDirectionBottom){
        NSLog(@"%d", type);
        _flag = 1;
        
        [self loadDataWithType:type withURL:_nextPage[type]];
        
        //请求下一页的数据
        [self FirstLoadDataWithUrl:_nextPage[type] withType:type];
        
        
        
    }

}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DetailViewController *detail = [[DetailViewController alloc]init];
    
    detail.dataSource = self.dataSources[tableView.tag - tableViewTag];
    detail.index = indexPath.row;
    
    [self.navigationController pushViewController:detail animated:YES];

}


@end
