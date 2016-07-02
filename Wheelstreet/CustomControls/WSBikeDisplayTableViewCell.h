//
//  WSBikeDisplayTableViewCell.h
//  Wheelstreet
//
//  Created by Jaswanth Jeenu on 27/06/16.
//  Copyright © 2016 Bashar Technologies Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WSBikeDisplayTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgBike;
@property (weak, nonatomic) IBOutlet UILabel *lblBrandName;
@property (weak, nonatomic) IBOutlet UILabel *lblModelName;
@property (weak, nonatomic) IBOutlet UILabel *lblRent;
@property (weak, nonatomic) IBOutlet UILabel *lblRentAmount;
@property (weak, nonatomic) IBOutlet UILabel *lblDeposit;
@property (weak, nonatomic) IBOutlet UILabel *lblDepositAmount;
//- (IBAction)btnCheckLocationsClicked:(UIButton*) sender;
@property (weak, nonatomic) IBOutlet UIView *viewBikeDetails;
@property (weak, nonatomic) IBOutlet UIView *viewRent;
@property (weak, nonatomic) IBOutlet UIView *viewDeposit;
@property (weak, nonatomic) IBOutlet UIView *viewBikeImage;
@property (weak, nonatomic) IBOutlet UIButton *btnCheckLocations;
@property (strong, nonatomic) NSMutableArray *availableLocations;


@end
