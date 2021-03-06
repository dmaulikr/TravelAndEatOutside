//
//  CityListViewController.m
//  TravelPart
//
//  Created by 雨爱阳 on 15/10/20.
//  Copyright © 2015年 雨爱阳. All rights reserved.
//

#import "TravelCityListViewController.h"
#import "NSString+Characters.h"
#import "FoodListViewController.h"
#import "HelpMethod.h"
#import "TravelRootCollectionViewController.h"
#import "TraveCityListModel.h"



@interface TravelCityListViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *cityTableView;

@property (nonatomic, strong)TraveCityListModel * cityListModel;// 声明城市列表对象
@property (nonatomic, strong)NSMutableArray * cityListArray;// 存放请求下来的城市名称
@property (nonatomic, strong)NSMutableArray * allKeys;// 存储所有的key值

@property (nonatomic, strong)NSMutableDictionary * allDics;// 存储数组的字典
@property (nonatomic, strong)NSMutableArray * indexArray;// 存储手写字母

@end

@implementation TravelCityListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.cityTableView.delegate = self;
    self.cityTableView.dataSource = self;
    
    [self requestData];
    
    // 注册 cell
    [self registerCell];
}

//注册 cell
- (void)registerCell
{
    [self.cityTableView registerClass:[UITableViewCell class]forCellReuseIdentifier:@"cityCell_id"];
    
}

// 点击返回
- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

//请求数据
- (void)requestData
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    // 一个操作对象  和 JSON 内容  responseObject 就是 JSON
    __weak TravelCityListViewController * weakSelf = self;
    [manager GET:kCityList parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // 返回为最外层的 数据类型
        NSArray * array = responseObject[@"data"][@"positionCity"];
        
        for (NSDictionary * dic in array) {
            
            TraveCityListModel * model = [TraveCityListModel new];
            [model setValuesForKeysWithDictionary:dic];
            
            //判断是否为空
            if (![model.pinYinName isEqualToString:@""]) {
                
                [weakSelf.cityListArray addObject:model];
                // 取出城市名的手写字母
                
                NSString * name = [model.pinYinName substringToIndex:1];
                // 将第一个字母存入数组
                
                [weakSelf.indexArray addObject:name];
                
                //创建这个数组是为了对下面的排序用的
                NSMutableArray * kArray = [NSMutableArray array];
                
                // 去重
                for (NSString * str in weakSelf.indexArray) {
                    
                    //因为有小写的，所以要转换为大写
                    NSString * big = [str uppercaseString];
                    
                    if (![kArray containsObject:big]) {
                        [kArray addObject:big];
                        
                        [weakSelf.allDics setObject:[NSMutableArray array] forKey:big];
                    }
                }
            }
            
            //赋值到allkeys
            weakSelf.allKeys = [NSMutableArray arrayWithArray:[weakSelf.allDics allKeys]];
            //对allkeys进行排序
            [weakSelf.allKeys sortUsingSelector:@selector(compare:)];
            
            //对字典里面对应的value进行赋值
            for (TraveCityListModel * model in _cityListArray) {
                
                if (![model.pinYinName isEqualToString:@""]) {
                    
                    NSString * p = [model.pinYinName substringWithRange:NSMakeRange(0, 1)];
                    //因为有小写的，所以要转换为大写
                    NSString * big = [p uppercaseString];
                    
                    NSMutableArray * arr = weakSelf.allDics[big];
                    
                    [arr addObject:model];
                }
            }
        }
            [weakSelf.cityTableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}


#pragma mark ------ 实现代理方法UITableViewDataSource,UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.allDics[self.allKeys[section]] count];
}


// 设置 cell 内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cityCell_id" forIndexPath:indexPath];

    NSArray * array = self.allDics[self.allKeys[indexPath.section]];
 
    TraveCityListModel * model  = array[indexPath.row];
    
    CLog(@"++%ld, --%ld",indexPath.section,indexPath.row);
    
    cell.textLabel.text = model.cityName;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

// 点击某一行推出页面
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray * array = self.allDics[self.allKeys[indexPath.section]];

    TraveCityListModel * model  = array[indexPath.row];
    //    代理传值
    if ([self.delegate respondsToSelector:@selector(sendValueCity:cityCode:)]) {
        [self.delegate sendValueCity:model.cityNameAbbr cityCode:model.cityCode];
    }
    // 单例传值
    [HelpMethod sharedManager].cityName_prepar = model.cityNameAbbr;
    [self.navigationController popViewControllerAnimated:YES];
    
}

//设置行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 35;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.allKeys.count;
}


// 设置区头
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.allKeys[section];
}


// 设置索引
-(NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.allKeys;
}

// 设置区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}


// 懒加载
-(NSMutableArray *)cityListArray {
    if (!_cityListArray) {
        _cityListArray = [NSMutableArray array];
    }
    return _cityListArray;
}

-(NSMutableArray *)allKeys {
    if (!_allKeys) {
        _allKeys = [NSMutableArray array];
    }
    return _allKeys;
}

-(NSMutableDictionary *)allDics {
    if (!_allDics) {
        _allDics = [NSMutableDictionary dictionary];
    }
    return _allDics;
}

-(NSMutableArray *)indexArray {
    if (!_indexArray) {
        _indexArray = [NSMutableArray array];
    }
    return _indexArray;
}

@end

