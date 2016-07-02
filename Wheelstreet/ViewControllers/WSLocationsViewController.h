//
//  WSLocationsViewController.h
//  Wheelstreet
//
//  Created by Jaswanth Jeenu on 27/06/16.
//  Copyright © 2016 Bashar Technologies Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSBikeLocationsTableViewCell.h"

@interface WSLocationsViewController : WSBaseViewController<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableLocations;
@property (strong, nonatomic) NSMutableArray *locationsArray;
@property (strong, nonatomic) Bikes *bikeChosen;
@property (weak, nonatomic) IBOutlet UIView *viewBtnDone;

-(void)btnIncreaseCountClicked:(UIButton*) sender;
-(void)btnDecreaseCountClicked:(UIButton*) sender;
- (IBAction)btnDoneClicked:(id)sender;
- (IBAction)btnBackClicked:(id)sender;

@end
