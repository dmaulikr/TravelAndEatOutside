//
//  ActivityForthCell.h
//  TravelAndEatOutside
//
//  Created by lanou3g on 15/10/28.
//  Copyright © 2015年 雨爱阳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TravelActDetailModel.h"

@interface ActivityForthCell : UITableViewCell

@property (nonatomic, strong)TravelActDetailModel * model;

@property (weak, nonatomic) IBOutlet UILabel *activityLabel;


@end
