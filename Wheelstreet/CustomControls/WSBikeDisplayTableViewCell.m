//
//  WSBikeDisplayTableViewCell.m
//  Wheelstreet
//
//  Created by Jaswanth Jeenu on 27/06/16.
//  Copyright © 2016 Bashar Technologies Pvt Ltd. All rights reserved.
//

#import "WSBikeDisplayTableViewCell.h"

@implementation WSBikeDisplayTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.viewBikeDetails.layer setBorderColor:[[UIColor colorWithRed:206/255.0f green:206/255.0f blue:206/255.0f alpha:1.0f] CGColor]];
    [self.viewBikeDetails.layer setBorderWidth:0.5f];
    
    [self.viewRent.layer setBorderColor:[[UIColor colorWithRed:206/255.0f green:206/255.0f blue:206/255.0f alpha:1.0f] CGColor]];
    [self.viewRent.layer setBorderWidth:0.5f];
    
    [self.viewDeposit.layer setBorderColor:[[UIColor colorWithRed:206/255.0f green:206/255.0f blue:206/255.0f alpha:1.0f] CGColor]];
    [self.viewDeposit.layer setBorderWidth:0.5f];
    
    [self.viewBikeImage.layer setBorderColor:[[UIColor colorWithRed:206/255.0f green:206/255.0f blue:206/255.0f alpha:1.0f] CGColor]];
    [self.viewBikeImage.layer setBorderWidth:0.5f];
    

    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//- (IBAction)btnCheckLocationsClicked:(UIButton*) sender {

//    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
////    NSDictionary *userInfo = @{@"tag":@(self.tag)};
//    [notificationCenter postNotificationName:@"locationsAvailable" object:[NSNumber numberWithInteger:self.tag]];
//    
//}

@end
