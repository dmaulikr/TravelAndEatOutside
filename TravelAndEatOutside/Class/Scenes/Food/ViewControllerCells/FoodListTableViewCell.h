//
//  FoodListTableViewCell.h
//  TravelAndEatOutside
//
//  Created by 雨爱阳 on 15/10/23.
//  Copyright © 2015年 雨爱阳. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FoodListModel;

@interface FoodListTableViewCell : UITableViewCell

// 创建model类
@property (nonatomic, strong)FoodListModel * foodModel;

@end
