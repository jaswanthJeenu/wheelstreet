//
//  WSLoginViewController.h
//  Wheelstreet
//
//  Created by Jaswanth Jeenu on 02/06/16.
//  Copyright © 2016 Bashar Technologies Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSLoginSignupPageChangeDelegate.h"


@interface WSLoginViewController : WSBaseViewController<UITextFieldDelegate>

@property (strong, nonatomic) id<WSLoginSignupPageChangeDelegate> loginSignupDelegate;

@property (weak, nonatomic) IBOutlet UIButton *btnLogin;
@property (weak, nonatomic) IBOutlet UIButton *btnSignUp;

- (IBAction)btnLoginClicked:(id)sender;
- (IBAction)btnSignUpClicked:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *txtMobileNumber;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;

- (IBAction)btnSignInClicked:(id)sender;
- (IBAction)btnContWithFbClicked:(id)sender;

-(void)getFacebookProfileInfos;



@end
