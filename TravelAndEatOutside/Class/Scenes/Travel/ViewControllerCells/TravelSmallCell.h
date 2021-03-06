//
//  TravelSmallCell.h
//  TravelAndEatOutside
//
//  Created by 雨爱阳 on 15/10/26.
//  Copyright © 2015年 雨爱阳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TravelRootCellModel.h"

@interface TravelSmallCell : UITableViewCell

@property (nonatomic, strong)TravelRootCellModel * model;

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel; // 标题
@property (weak, nonatomic) IBOutlet UILabel *digestLabel; // 摘要
@property (weak, nonatomic) IBOutlet UILabel *currentPrice; // 现价
@property (weak, nonatomic) IBOutlet UILabel *originalPrice; // 原价
@property (weak, nonatomic) IBOutlet UILabel *saleLabel; // 已售

@end
