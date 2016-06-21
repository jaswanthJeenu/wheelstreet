//
//  WSSignupViewController.h
//  Wheelstreet
//
//  Created by Jaswanth Jeenu on 02/06/16.
//  Copyright © 2016 Bashar Technologies Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSLoginSignupPageChangeDelegate.h"
#import "WSOTPVerificationViewController.h"

@interface WSSignupViewController : WSBaseViewController

@property (strong, nonatomic) id<WSLoginSignupPageChangeDelegate> loginSignupdelegate;

@property (weak, nonatomic) IBOutlet UIButton *btnLogin;
@property (weak, nonatomic) IBOutlet UIButton *btnSignUp;

@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txtContactNumber;
@property (weak, nonatomic) IBOutlet UITextField *txtEmailAddress;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UITextField *txtConfirmPassword;

- (IBAction)btnLoginClicked:(id)sender;
- (IBAction)btnSignUpClicked:(id)sender;
- (IBAction)btnExistingUserClicked:(id)sender;


- (IBAction)btnSignUpForWSClicked:(id)sender;
- (IBAction)btnContWithFbClicked:(id)sender;


@property (strong, nonatomic) WSUser *user;

@property (nonatomic) BOOL isFacebookLogin;

@end
