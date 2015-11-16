//
//  menuView.m
//  我的小说
//
//  Created by 雨爱阳 on 15/7/4.
//  Copyright (c) 2015年 雨爱阳. All rights reserved.
//

#import "menuView.h"
#import "ReadDataBaseManager.h"
#import "HomePageViewController.h"

#define kNotificationNameGetdatabaseSource @"getDatabaseSource"

@implementation menuView




-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self.aView addSubview:self.book_nameLabel];
//        [self.aView addSubview:self.detailButton];
        [self.aView addSubview:self.deleteButton];
//        [self.aView addSubview:self.destroyButton];
        [self addSubview:self.aView];
        
        
    }
    
    return self;
}

-(UIView *)aView
{
    if (!_aView) {
        self.aView = [[UIView alloc]initWithFrame:CGRectMake(self.frame.size.width / 4, self.frame.size.height / 3, self.frame.size.width / 2, self.frame.size.height / 3)];
        _aView.backgroundColor = [UIColor darkGrayColor];
        _aView.layer.cornerRadius = 10;
    }
    
    return _aView;
}

-(UILabel *)book_nameLabel
{
    if (!_book_nameLabel) {
        self.book_nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.aView.frame.size.width, self.aView.frame.size.height / 4)];
        _book_nameLabel.backgroundColor = [UIColor colorWithRed:100 / 255.0  green:200 / 255.0 blue:250 / 255.0 alpha:1];
        _book_nameLabel.layer.cornerRadius = 5;
        
    }
    return _book_nameLabel;
}

-(UIButton *)detailButton
{
    if (!_detailButton) {
        self.detailButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _detailButton.frame = CGRectMake(0, self.aView.frame.size.height / 4, self.aView.frame.size.width, self.aView.frame.size.height / 4 - 1);
        [_detailButton setTitle:@"图书详情" forState:UIControlStateNormal];
        _detailButton.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:140 / 255.0 blue:30 / 255.0 alpha:1];
        [_detailButton addTarget:self action:@selector(handleDetailButtons:) forControlEvents:UIControlEventTouchDown];
        _detailButton.layer.cornerRadius = 5;
    }
    return _detailButton;
    
}

-(void)handleDetailButtons:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(handleDetailButton:)]) {
        [self.delegate handleDetailButton:sender];
        [self removeFromSuperview];
    }
   
    
     
}

-(UIButton *)deleteButton
{
    if (!_deleteButton) {
        self.deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteButton.frame = CGRectMake(0, self.aView.frame.size.height / 2, self.aView.frame.size.width, self.aView.frame.size.height / 4 - 0.5);
        [_deleteButton setTitle:@"移出书柜" forState:UIControlStateNormal];
        [_deleteButton addTarget:self action:@selector(handleDeleteButton:) forControlEvents:UIControlEventTouchUpInside];
        _deleteButton.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:140 / 255.0 blue:30 / 255.0 alpha:1];
        _deleteButton.layer.cornerRadius = 5;
    }
    return _deleteButton;
}

-(void)handleDeleteButton:(UIButton *)sender
{
    
   
   ReadDataBaseManager *manager = [ReadDataBaseManager shareDataManager];
  [manager deleteCollecInfoWith:self.bookId];
    NSArray *array = [manager selectInfo];
    [manager closeDatabase];
    [[NSNotificationCenter defaultCenter]postNotificationName:kNotificationNameGetdatabaseSource object:self userInfo:@{@"array" : array}];
    
    
    
    
    [self removeFromSuperview];
}

- (UIButton *)destroyButton
{
    
    if (!_destroyButton) {
        self.destroyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_destroyButton setTitle:@"删除图书" forState:UIControlStateNormal];
        [_destroyButton addTarget:self action:@selector(handleDestoryButton:) forControlEvents:UIControlEventTouchDown];
        _destroyButton.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:140 / 255.0 blue:30 / 255.0 alpha:1];
        _destroyButton.frame = CGRectMake(0, self.aView.frame.size.height * 3 / 4, self.aView.frame.size.width, self.aView.frame.size.height / 4 - 1);
        _destroyButton.layer.cornerRadius = 5;
    }
    return _destroyButton;
}

-(void)handleDestoryButton:(UIButton *)sender
{
    ReadDataBaseManager *manager = [ReadDataBaseManager shareDataManager];
    [manager creatDatabase];
    [manager deleteCollecInfoWith:self.bookId];
    [manager deleteContentInfoWith:self.bookId];
   
    
    NSArray *array = [manager selectInfo];
    [manager closeDatabase];
    [[NSNotificationCenter defaultCenter]postNotificationName:kNotificationNameGetdatabaseSource object:self userInfo:@{@"array" : array}];
    
    [self removeFromSuperview];
    
}


@end
