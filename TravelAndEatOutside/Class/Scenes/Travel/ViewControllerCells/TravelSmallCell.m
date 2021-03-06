//
//  TravelSmallCell.m
//  TravelAndEatOutside
//
//  Created by 雨爱阳 on 15/10/26.
//  Copyright © 2015年 雨爱阳. All rights reserved.
//

#import "TravelSmallCell.h"
#import "UIImage+AFNetworking.h"

@implementation TravelSmallCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(TravelRootCellModel *)model
{
    [self.imgView setImageWithURL:[NSURL URLWithString:[@"http://cdn.yaochufa.com/" stringByAppendingString:model.mImageUrl]]];
    self.titleLabel.text = model.productName;
    self.digestLabel.text = [[[@"[" stringByAppendingString:model.cityName] stringByAppendingString:@"]"] stringByAppendingString:model.productTitleContent];
    self.currentPrice.text = [@"￥" stringByAppendingString:[NSString stringWithFormat:@"%ld", model.price]];
    self.originalPrice.text = [NSString stringWithFormat:@"%ld", model.originalPrice];
    self.saleLabel.text = [@"已售" stringByAppendingString:[NSString stringWithFormat:@"%ld", model.saledCount]];
}

@end
