//
//  WSCartTableViewCell.h
//  Wheelstreet
//
//  Created by Jaswanth Jeenu on 30/06/16.
//  Copyright © 2016 Bashar Technologies Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSCartLocationTableViewCell.h"

@interface WSCartBikeTableViewCell : UITableViewCell<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imgBikeSmall;
@property (weak, nonatomic) IBOutlet UILabel *lblBikeName;
@property (weak, nonatomic) IBOutlet UILabel *lblCashDetails;

@property (weak, nonatomic) IBOutlet UITableView *tableLocation;
@property (strong, nonatomic) NSMutableArray *locationsArray;

@end
