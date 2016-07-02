//
//  WSBikeLocationsTableViewCell.h
//  Wheelstreet
//
//  Created by Jaswanth Jeenu on 28/06/16.
//  Copyright © 2016 Bashar Technologies Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WSBikeLocationsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblLocationName;
@property (weak, nonatomic) IBOutlet UILabel *lblBikesQuantity;
@property (weak, nonatomic) IBOutlet UILabel *lblLocationDistance;
@property (weak, nonatomic) IBOutlet UIButton *btnDecreaseCount;
@property (weak, nonatomic) IBOutlet UIButton *btnIncreaseCount;
@property (weak, nonatomic) IBOutlet UILabel *lblCountDisplay;
@property (weak, nonatomic) IBOutlet UIImageView *imgBlueDot;

@end
