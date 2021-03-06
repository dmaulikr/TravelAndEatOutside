//
//  CollectViewController.m
//  我的小说
//
//  Created by 雨爱阳 on 15/7/1.
//  Copyright (c) 2015年 雨爱阳. All rights reserved.
//

#import "CollectViewController.h"
#import "ReadDataBaseManager.h"
#import "BoutiqueModel.h"
#import "CollectModel.h"
#import "CollectionViewCell.h"
#import "menuView.h"
#import "ContentViewController.h"
#import "HomePageViewController.h"
#import "CatalogModel.h"

#define kNotificationNameGetdatabaseSource @"getDatabaseSource"

@interface CollectViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,menuDelegate>

    


@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)NSMutableArray *datasource;


@end

@implementation CollectViewController

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
}

-(NSMutableArray *)datasource
{
    if (!_datasource) {
        self.datasource = [NSMutableArray array];
    }
    
    return _datasource;
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    
   self.navigationItem.title = @"我的书架";
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    
    flowLayout.minimumLineSpacing = 30;
    flowLayout.minimumInteritemSpacing =20;
    flowLayout.itemSize = CGSizeMake(self.view.bounds.size.width / 3 - 30, 160);
    flowLayout.sectionInset = UIEdgeInsetsMake(15, 15, 15, 15);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"backImage"]];
    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getDatabaseSource:) name:kNotificationNameGetdatabaseSource object:nil];
    
    ReadDataBaseManager *manager = [ReadDataBaseManager shareDataManager];
    [manager creatDatabase];
    [manager creatMenuTableInfo];
    [manager creatCollectTable];
   NSMutableArray *array = [manager selectInfo];
    self.datasource = array;
}

-(void)getDatabaseSource:(NSNotification *)notification
{
   
    NSDictionary *dic = notification.userInfo;
    self.datasource = dic[@"array"];
    [self.collectionView reloadData];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return self.datasource.count;
}
//Cell显示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    CollectModel *model = self.datasource[indexPath.row];
    cell.img_urlImageView.tag = model.bookId;
    
    [cell configCell:model];
    UILongPressGestureRecognizer *LongPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(handlePinch:)];
    cell.tag = self.bookId;
    cell.img_urlImageView.userInteractionEnabled = YES;
    [cell.img_urlImageView addGestureRecognizer:LongPress];
   
    
    return cell;
    
}
//手势执行的方法
-(void)handlePinch:(UIPinchGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateEnded) {
        return;
    }else
    {
        
        
        menuView *aView = [[menuView alloc]initWithFrame:self.view.frame];
        aView.alpha = 1;
        aView.bookId = sender.view.tag;
        aView.delegate = self;
        self.bookId = aView.bookId;
        [self.view addSubview:aView];
    }
   
    
    
}

//点击cell执行的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

  CollectModel *model = self.datasource[indexPath.row];
    
    
    HomePageViewController * homePageVC = [[UIStoryboard storyboardWithName:@"Read" bundle:nil]instantiateViewControllerWithIdentifier:@"Read_view"];
    
    homePageVC.bookId = model.bookId;
    
    [self.navigationController pushViewController:homePageVC animated:YES];
  
}

-(void)handleDetailButton:(UIButton *)sender
{
    HomePageViewController *homePageVC = [[HomePageViewController alloc]init];
    homePageVC.bookId = self.bookId;
    
    [self.navigationController pushViewController:homePageVC animated:NO];
    
}


@end
