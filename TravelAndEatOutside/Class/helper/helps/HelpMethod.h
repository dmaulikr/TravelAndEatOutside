//
//  HelpMethod.h
//  TravelAndEatOutside
//
//  Created by 雨爱阳 on 15/10/22.
//  Copyright © 2015年 雨爱阳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HelpMethod : NSObject

#pragma mark----创建单例
+ (instancetype)sharedManager;

// 将第一个页面的值传到第二个页面使用
@property (nonatomic, copy)NSString * cityName_prepar;

@end
