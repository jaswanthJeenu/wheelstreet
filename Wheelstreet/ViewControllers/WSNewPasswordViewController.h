//
//  WSNewPasswordViewController.h
//  Wheelstreet
//
//  Created by Jaswanth Jeenu on 01/06/16.
//  Copyright © 2016 Bashar Technologies Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WSNewPasswordViewController : WSBaseViewController

@property (weak, nonatomic) IBOutlet UITextField *txtNewPassword;
@property (weak, nonatomic) IBOutlet UITextField *txtConfirmPassword;

- (IBAction)btnSubmitClicked:(id)sender;
- (IBAction)barBtnBackClicked:(id)sender;

@property NSString* userId;


@end
