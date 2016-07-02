//
//  WSCartLocationTableViewCell.h
//  Wheelstreet
//
//  Created by Jaswanth Jeenu on 30/06/16.
//  Copyright © 2016 Bashar Technologies Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WSCartLocationTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblLocationName;
@property (weak, nonatomic) IBOutlet UILabel *lblLocationDistance;
@property (weak, nonatomic) IBOutlet UILabel *lblQuantityDisplay;
@property (weak, nonatomic) IBOutlet UIButton *btnDecreaseCount;

@end
