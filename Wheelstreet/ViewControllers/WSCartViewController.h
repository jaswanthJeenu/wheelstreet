//
//  WSCartViewController.h
//  Wheelstreet
//
//  Created by Jaswanth Jeenu on 30/06/16.
//  Copyright © 2016 Bashar Technologies Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSCartBikeTableViewCell.h"
#import "WSCartLocationTableViewCell.h"

@interface WSCartViewController : WSBaseViewController<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableBike;
@property (strong, nonatomic) NSMutableArray *bookingsArray;

- (IBAction)btnBackClicked:(id)sender;
- (IBAction)btnBookNowClicked:(id)sender;

@end
