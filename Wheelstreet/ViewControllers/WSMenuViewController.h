//
//  WSMenuViewController.h
//  SlidingMenu
//
//  Created by Jaswanth Jeenu on 01/06/16.
//  Copyright © 2016 Jaswanth Jeenu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
#import "WSInfoViewController.h"

@interface WSMenuViewController : WSBaseViewController<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
