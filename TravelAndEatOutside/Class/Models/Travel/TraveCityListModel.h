//
//  TraveCityListModel.h
//  TravelAndEatOutside
//
//  Created by 雨爱阳 on 15/10/31.
//  Copyright © 2015年 雨爱阳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TraveCityListModel : NSObject

@property (nonatomic, copy)NSString * cityName;// 城市名字(市)
@property (nonatomic, copy)NSString * cityCode;// 城市代号
@property (nonatomic, copy)NSString * cityNameAbbr;// 城市名字
@property (nonatomic, copy)NSString * pinYinName;// 城市名拼音

@end
