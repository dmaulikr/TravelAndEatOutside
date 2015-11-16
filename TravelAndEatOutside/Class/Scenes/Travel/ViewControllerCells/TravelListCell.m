//
//  TravelListCell.m
//  TravelAndEatOutside
//
//  Created by 雨爱阳 on 15/10/23.
//  Copyright © 2015年 雨爱阳. All rights reserved.
//

#import "TravelListCell.h"


@implementation TravelListCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setModel:(TravelActivityModel *)model {
    
    [self.imgView setImageWithURL:[NSURL URLWithString:model.bigImageUrl]];
    self.comboLabel.text = model.labelText;
    self.cityLabel.text = model.cityName;
    self.titleLabel.text = model.productName;
    self.digestLabel.text = model.productTitleContent;
    self.curPriceLabel.text = [@"￥" stringByAppendingString:[NSString stringWithFormat:@"%ld", model.price]];
    self.originalPriceLabel.text = [NSString stringWithFormat:@"%ld",model.originalPrice];
    
    
    self.saleLabel.text = [@"已售" stringByAppendingString:[NSString stringWithFormat:@"%ld", model.saledCount]];
    if (model.stateText) {
        self.reserveLabel.text = model.stateText;
    }
    
    
}


@end
