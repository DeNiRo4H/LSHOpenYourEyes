//
//  SpecialViewController.m
//  LSHOpenYourEyes
//
//  Created by DeNiRo4H on 16-1-11.
//  Copyright (c) 2016年 LSH. All rights reserved.
//

#import "SpecialViewController.h"
#import "SpecialCell.h"
#import "ScreenMarco.h"
#import "DetailSpecailViewController.h"


static NSString *cellID = @"cellID";
@interface SpecialViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    NSArray *_nameArray;
    NSArray * _imageArray;
}


@property(nonatomic, strong)UICollectionView *collection;

@end

@implementation SpecialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self createCollectionView];
}

-(void)createCollectionView{
    
    _nameArray = @[@"创意",@"运动",@"旅行",@"剧情",@"动画",@"广告",@"音乐",@"开胃",@"预告",@"综合",@"记录",@"时尚"];
    
   
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    
    //cell的大小  一行放几个cell 根据他的大小
    flowLayout.itemSize = CGSizeMake(KscreenWidth/2-2, KscreenWidth/2-2);
    //上左下右
//    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    flowLayout.minimumInteritemSpacing = 3;//最小列间距 默认是10
    flowLayout.minimumLineSpacing = 3 ;//最小行间距
    
    //创建collection
    _collection = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    //设置代理
    _collection.delegate = self;
    _collection.dataSource = self;

    _collection.backgroundColor = [UIColor grayColor];
    
    //注册
    [_collection registerNib:[UINib nibWithNibName:NSStringFromClass([SpecialCell class]) bundle:nil] forCellWithReuseIdentifier:cellID];
    
    [self.view addSubview:_collection];
   
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return 12;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    SpecialCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];

    NSString *path = [[NSBundle mainBundle]pathForResource:_nameArray[indexPath.row] ofType:@"jpeg"];
    UIImage *image  =[UIImage imageWithContentsOfFile:path];
    
    //cell被选中的风格
    
    cell.backImage.image = image;
    
    cell.name.text = _nameArray[indexPath.row];
    cell.backgroundColor = [UIColor grayColor];
    
    return cell;
}
//选中某个cell的时候
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    DetailSpecailViewController *detailSpecail = [[DetailSpecailViewController alloc]init];
    
    detailSpecail.categoryName = _nameArray[indexPath.row];
    //推送到专题中的详情页面
    [self.navigationController pushViewController:detailSpecail animated:YES];

}



@end
