//
//  WSFiltersViewController.h
//  Wheelstreet
//
//  Created by Jaswanth Jeenu on 20/06/16.
//  Copyright © 2016 Bashar Technologies Pvt Ltd. All rights reserved.
//

#import "UINavigationController+TransparentNavigationController.h"
#import "WSRoundedRectTextField.h"
#import "WSFiltersTableViewCell.h"

@interface WSFiltersViewController : WSBaseViewController<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITextField *txtCheck;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *viewApply;
@property (weak, nonatomic) IBOutlet UIButton *btnLowToHigh;
@property (weak, nonatomic) IBOutlet UIButton *btnHighToLow;
- (IBAction)btnLowToHighClicked:(id)sender;
- (IBAction)btnHighToLowClicked:(id)sender;
@property (weak, nonatomic) IBOutlet WSRoundedRectTextField *txtSearchBikes;
@property (strong, nonatomic) NSMutableArray *brandsFilterArray;
@property (strong, nonatomic) NSMutableArray *priceFilterArray;
@property (strong, nonatomic) NSArray *filtersArray;

-(void)cellBtnClicked:(UIButton*) sender;
- (IBAction)btnApplyClicked:(id)sender;
- (IBAction)btnBackClicked:(id)sender;

@end
