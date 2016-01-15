//
//  HotRenkingViewController.m
//  LSHOpenYourEyes
//
//  Created by DeNiRo4H on 16-1-11.
//  Copyright (c) 2016年 LSH. All rights reserved.
//

#import "HotRenkingViewController.h"
#import "TitleView.h"
#import "ScreenMarco.h"
#import "SelectionCell.h"//使用每日精选的cell
#import "UrlFile.h"
#import "ListModel.h"
#import "VideoModel.h"


#define tableViewTag 40
static NSString *cellID = @"cellID";

//头上的三个标题
typedef enum titleType{
    weekly = 0,
    monthly,
    historical,
}TitleType;

@interface HotRenkingViewController ()<TitleViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property(nonatomic, strong)NSMutableArray *dataSources;

@property(nonatomic, strong)UIScrollView *scrollView;

@property(nonatomic, strong)TitleView *titleView;

@end

@implementation HotRenkingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建titleview
    [self createTitleView];
//    //创建滚动视图
    [self createScrollView];
//    //创建tableview
//    [self createTableView];
//    //加载数据(初始加载周排行)
    [self loadDataWithType:weekly];
    
    
}
/**
 *  创建titleView
 */
-(void)createTitleView{
    //不知道这个位置怎么搞得???
    _titleView = [[TitleView alloc]initWithFrame:CGRectMake(0, -64,KscreenWidth, 150)];
    _titleView.titles = @[@"周排行",@"月排行",@"总排行"];
    //建立代理
    _titleView.delegate = self;
    [self.view addSubview:_titleView];
}


/**
 *  创建scrollview
 */
-(void)createScrollView{

    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, KscreenWidth, KscreenHeight-64)];
    //翻页
    self.scrollView.pagingEnabled = YES;
    
    //创建tableview
    [self createTableView];
    
    //设置scrollview的大小
    self.scrollView.contentSize = CGSizeMake(KscreenWidth*3, self.scrollView.frame.size.height);
    
//    self.scrollView.delegate = self;
    
    [self.view addSubview:self.scrollView];

}

/**
 *  创建tableView
 */
-(void)createTableView{
    //初始化话大数组(数组里面放了tableview的小数组)
    self.dataSources = [NSMutableArray array];
    
    for(int i = 0;i< 3 ;i++){
        
        NSMutableArray *array = [[NSMutableArray alloc]init];
        
        //将小数组添加到大数组
        [self.dataSources addObject:array];
        
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(i*self.scrollView.frame.size.width, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height) style:UITableViewStylePlain];
        
        tableView.tag = i + tableViewTag;
        
        tableView.rowHeight = 230;
        
        tableView.delegate = self;
        tableView.dataSource = self;
        
        //注册
        [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SelectionCell class]) bundle:nil] forCellReuseIdentifier:cellID];
        
        [self.scrollView addSubview:tableView];
    
    }

}


#pragma mark - 加载数据
//根据类型(哪个tabview)来加载数据
-(void)loadDataWithType:(TitleType )type{
    
    NSArray *typeStr = @[@"weekly",@"monthly",@"historical"];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"num":@10,@"strategy":typeStr[type]}];
 
    [self.manager requestWithUrl:hotRankingUrl parameters:dic complicate:^(BOOL success, id object) {
    
//        NSLog(@"%@", object);
        
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
//    return 10;
  
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    SelectionCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    ListModel *list = self.dataSources[tableView.tag - tableViewTag][indexPath.row];
    
    VideoModel *model = list.data;
    cell.model = model;
    return cell;

}





#pragma mark titleViewDelegate 协议方法
-(void)titleView:(TitleView *)view selectIndex:(NSInteger)index{
      NSLog(@"选中第%ld个button",index);
}




@end
