//
//  TravelSmallDetailViewController.m
//  TravelAndEatOutside
//
//  Created by 雨爱阳 on 15/10/23.
//  Copyright © 2015年 雨爱阳. All rights reserved.
//

#import "TravelSmallDetailViewController.h"
#import "TravelSmallCell.h"
#import "TravelRootCellModel.h"
#import "SmallDetailTableViewController.h"
#import "TravelCityListViewController.h"

@interface TravelSmallDetailViewController ()<UITableViewDelegate, UITableViewDataSource, TravelCityListViewControllerDelegate>

@property (nonatomic, strong)NSMutableArray * modelArray; // 存放 model

@property (weak, nonatomic) IBOutlet UITableView *smallTableView;

@end

@implementation TravelSmallDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.smallTableView.delegate =self;
    self.smallTableView.dataSource =self;
    
    // 注册 cell
    [self registerCell];
    
    [self requestData:kSmallList(@"n", self.propertyId, self.cityCode, self.tagId)];
    
    
}

#pragma mark----实现<TravelCityListViewControllerDelegate>方法
-(void)sendValueCity:(NSString *)cityText cityCode:(NSString *)cityCode
{
    self.cityCode = cityCode;
}

//注册 cell
- (void)registerCell
{
    [self.smallTableView registerNib:[UINib nibWithNibName:@"TravelSmallCell" bundle:nil] forCellReuseIdentifier:@"smallCell_id"];
}

// 请求数据
- (void)requestData:(NSString *)url
{
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            __weak TravelSmallDetailViewController * weakSelf = self;
            // 一个操作对象  和 JSON 内容  responseObject 就是 JSON 串
            [manager GET:url                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                //   返回为最外层的 数据类型
                NSDictionary * dict = responseObject[@"data"];
                
                for (NSDictionary * xdic in dict[@"items"]) {
                    TravelRootCellModel * model = [TravelRootCellModel new];
                    [model setValuesForKeysWithDictionary:xdic];
                    [weakSelf.modelArray addObject:model];
                }
                [self.smallTableView reloadData];
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"Error: %@", error);
            }];
            [self.smallTableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.modelArray.count;
}


// 设置 cell 内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TravelSmallCell * cell = [tableView dequeueReusableCellWithIdentifier:@"smallCell_id"];
    TravelRootCellModel * model = self.modelArray[indexPath.row];
    cell.model = model;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    self.smallTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    return YES;
}


// 点击清空刷新
- (IBAction)recommendButton:(UIButton *)sender {
    [self.modelArray removeAllObjects];
    [self requestData:kSmallList(@"n", self.propertyId, self.cityCode, self.tagId)];
}
- (IBAction)newButton:(id)sender {
    [self.modelArray removeAllObjects];

    [self requestData:kSmallList(@"i", self.propertyId, self.cityCode, self.tagId)];
}

- (IBAction)distanceButton:(UIButton *)sender {
    [self.modelArray removeAllObjects];

    [self requestData:kSmallList(@"d", self.propertyId, self.cityCode, self.tagId)];
}
- (IBAction)saleButton:(UIButton *)sender {
    [self.modelArray removeAllObjects];

    [self requestData:kSmallList(@"s", self.propertyId, self.cityCode, self.tagId)];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}


//点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TravelRootCellModel * model = self.modelArray[indexPath.row];
    
    SmallDetailTableViewController * adVC = [SmallDetailTableViewController new];
    adVC.productId = [NSString stringWithFormat:@"%ld", model.productId];
    [self.navigationController pushViewController:adVC animated:YES];
}

-(NSMutableArray *)modelArray {
    
    if (!_modelArray) {
        _modelArray = [NSMutableArray array];
    }
    return _modelArray;
}

@end
