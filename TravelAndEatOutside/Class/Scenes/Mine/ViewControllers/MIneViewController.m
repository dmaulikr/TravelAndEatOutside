//
//  MIneViewController.m
//  TravelAndEatOutside
//
//  Created by 雨爱阳 on 15/10/21.
//  Copyright (c) 2015年 雨爱阳. All rights reserved.
//

#import "MIneViewController.h"
#import "KSAlertView.h"
#import "ReadDataBaseManager.h"

@interface MIneViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView * tableView;// 声明tableView
@property (nonatomic, strong)NSArray * arrayOfRow;// 存储分区每行显示内容

@end

@implementation MIneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 创建tableView
    [self creatTableView];
    // 将tableView添加到视图
    [self.view addSubview:_tableView];
    
}

// 创建tableView
- (void)creatTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64) style:(UITableViewStylePlain)];
    // 设置tableView代理
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //去掉分割线
    //    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    // 设置分区每行显示内容
    self.arrayOfRow = @[@"清除缓存",@"关于软件",@"您的建议"];
}

// 设置有多少个分区
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// 设置每个分区有多少行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _arrayOfRow.count;
}

// 设置cell显示内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Mine_Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@"Mine_Cell"];
    }
    // 设置cell格式
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    // 设置cell显示内容
    cell.textLabel.text = _arrayOfRow[indexPath.row];
    return cell;
}

// 点击某一行推出下级页面
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
            
        case 0:
            // 创建并推出警示框
        {
            [self clearCache];
            
        }
            break;
        case 1:
            // 推出关于软件界面
            [self.navigationController pushViewController:[[UIStoryboard storyboardWithName:@"Eat" bundle:nil] instantiateViewControllerWithIdentifier:@"MIneAboutApp_id"] animated:YES];
            break;
        case 2:
            // 推出您的建议界面
            [self.navigationController pushViewController:[[UIStoryboard storyboardWithName:@"Eat" bundle:nil] instantiateViewControllerWithIdentifier:@"MineAdvice_id"] animated:YES];
            break;
            
        default:
            break;
    }
}

//清除缓存
-(void)clearCache {
    float size = [[ReadDataBaseManager  shareDataManager] folderSize];
    NSString * cache = [NSString stringWithFormat:@"缓存 %.2f M", size];
    
    __weak typeof(self) weakSelf = self;
    
    UIAlertController * alertController =[UIAlertController alertControllerWithTitle:@"是否清除缓存?" message:cache preferredStyle:UIAlertControllerStyleAlert
                                          ];
    UIAlertAction * ensureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        // 清除缓存
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"清除成功!" message:nil delegate:weakSelf cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [alertView show];
        [[ReadDataBaseManager  shareDataManager] clearCache];
        [weakSelf performSelector:@selector(dismissAlertView:) withObject:alertView afterDelay:1];
    }];
    
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    }];
    
    
    [alertController addAction:ensureAction];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

// 创建提示框
- (void)dismissAlertView:(UIAlertView *)alertView {
    
    [alertView dismissWithClickedButtonIndex:0 animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
@end
