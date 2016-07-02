//
//  WSBikeLocationsTableViewCell.m
//  Wheelstreet
//
//  Created by Jaswanth Jeenu on 28/06/16.
//  Copyright © 2016 Bashar Technologies Pvt Ltd. All rights reserved.
//

#import "WSBikeLocationsTableViewCell.h"

@implementation WSBikeLocationsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.lblCountDisplay.layer.shadowColor = [UIColor blackColor].CGColor;
    self.lblCountDisplay.layer.shadowOffset = CGSizeMake(0, 3);
    self.lblCountDisplay.layer.shadowOpacity = 0.1f;
    self.lblCountDisplay.layer.shadowRadius = 2.0;

    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
