//
//  WSDisplayBikesViewController.h
//  Wheelstreet
//
//  Created by Jaswanth Jeenu on 24/06/16.
//  Copyright © 2016 Bashar Technologies Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSBikeDisplayTableViewCell.h"
#import "WSLocationsViewController.h"
#import "WSRoundedRectTextField.h"

@interface WSDisplayBikesViewController : WSBaseViewController<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableDisplay;
@property (strong, nonatomic) NSMutableArray* bikesArray;
@property (strong, nonatomic) NSMutableArray* brandsFilterArray;
@property (strong, nonatomic) NSMutableArray* priceFilterArray;
@property (strong, nonatomic) NSString *pickupLocation;
@property (strong, nonatomic) NSString *pickupTime;
@property (strong, nonatomic) NSString *dropTime;
@property (weak, nonatomic) IBOutlet WSRoundedRectTextField *txtSearchBikes;
@property (weak, nonatomic) IBOutlet UIView *viewBtnCart;

- (IBAction)btnBackClicked:(id)sender;

@end
