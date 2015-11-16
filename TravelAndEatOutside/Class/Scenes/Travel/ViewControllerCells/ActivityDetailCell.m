//
//  ActivityDetailCell.m
//  TravelAndEatOutside
//
//  Created by 雨爱阳 on 15/10/28.
//  Copyright © 2015年 雨爱阳. All rights reserved.
//

#import "ActivityDetailCell.h"

@implementation ActivityDetailCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setModel:(TravelActDetailModel *)model
{
    
    self.titleLabel.text = model.appMainTitle;
    self.digestLabel.text = model.appSubTitle;
}

@end
