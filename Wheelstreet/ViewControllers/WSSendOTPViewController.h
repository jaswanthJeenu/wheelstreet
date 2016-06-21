//
//  WSSendOTPViewController.h
//  Wheelstreet
//
//  Created by Jaswanth Jeenu on 01/06/16.
//  Copyright © 2016 Bashar Technologies Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSOTPVerificationViewController.h"

@interface WSSendOTPViewController : WSBaseViewController

@property (weak, nonatomic) IBOutlet UITextField *txtMobileNumber;

- (IBAction)btnSendOTPClicked:(id)sender;
- (IBAction)btnBackClicked:(id)sender;

@end
