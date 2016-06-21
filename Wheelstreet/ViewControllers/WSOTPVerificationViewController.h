//
//  WSOTPVerificationViewController.h
//  Wheelstreet
//
//  Created by Jaswanth Jeenu on 01/06/16.
//  Copyright © 2016 Bashar Technologies Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSNewPasswordViewController.h"

@interface WSOTPVerificationViewController : WSBaseViewController

@property (weak, nonatomic) IBOutlet UITextField *txtOTPCode;

- (IBAction)btnDoneClicked:(id)sender;
- (IBAction)barBtnBackClicked:(id)sender;

@property (strong, nonatomic) NSString* userID;
@property (nonatomic) BOOL isMobileNumberVerification;

@end
