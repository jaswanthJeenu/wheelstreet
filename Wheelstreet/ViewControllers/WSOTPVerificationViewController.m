//
//  WSOTPVerificationViewController.m
//  Wheelstreet
//
//  Created by Jaswanth Jeenu on 01/06/16.
//  Copyright © 2016 Bashar Technologies Pvt Ltd. All rights reserved.
//

#import "WSOTPVerificationViewController.h"

@interface WSOTPVerificationViewController ()


@end

@implementation WSOTPVerificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)btnDoneClicked:(id)sender {
    
    if ([self.txtOTPCode.text isEqualToString:@""]){
        [self showFeedbackWithTitle: NSLocalizedString(@"FAILURE_HANDLER_TITLE", nil) andMessage: NSLocalizedString(@"PLEASE_ENTER_YOUR_OTP_CODE", nil) andIsError:YES];
    }
    else{
        
        NSString *enteredOTP = [self.txtOTPCode.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        //      NSString *userID = [defaultsobjectForKey:@"user_id"];
        
        NSDictionary *parameters = @{JSON_KEY_OTP: enteredOTP, JSON_KEY_USER_ID: self.userID};
        
        [self showProgressHudWithMessage: NSLocalizedString(@"VERIFYING_OTP", nil)];
        ApiManager *apiManager = [[ApiManager alloc] init];
        
        NSString *verifyOTP_URL = [NSString stringWithFormat:@"%@%@", [WSUtils getApiBaseURL], URL_VERIFY_OTP];
        
        [apiManager makeNetworkCallOfType:REQUEST_METHOD_POST withUrl:verifyOTP_URL andParameters:parameters withCompletionHandler:^(id  _Nullable responseObject) {
            [self hideProgressHUD];
            //NSLog(@"Success response: %@", responseObject);
            if([[responseObject objectForKey:JSON_KEY_SUCCESS] boolValue] == YES) {
                //NSLog(@"OTP is verified");
                if (self.isMobileNumberVerification == NO){
                    [self performSegueWithIdentifier:@"showNewPasswordScreenSegue" sender:nil];
                }
                else{
                    [self performSegueWithIdentifier:@"showLoginScreenAfterSignupSegue" sender:nil];
                }
                
            } else {
                [self showFeedbackWithTitle: NSLocalizedString(@"FAILURE_HANDLER_TITLE", nil) andMessage: [responseObject objectForKey: JSON_KEY_MESSAGE] andIsError:YES];
                //NSLog(@"OTP failed to verify");
            }
            
        } andWithFailureHandler:^(NSError *error) {
            [self hideProgressHUD];
            //        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Sorry!" message:@"Unfortunately, your request failed." delegate:self cancelButtonTitle:@"OK"     otherButtonTitles: nil];
            //        [alert show];
            
            [self showFeedbackWithTitle: NSLocalizedString(@"FAILURE_HANDLER_TITLE", nil) andMessage: NSLocalizedString(@"FAILURE_HANDLER_MESSAGE", nil) andIsError:YES];
            //NSLog(@"Failure reason: %@", [error localizedDescription]);
        }];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if (self.isMobileNumberVerification == NO){
        WSNewPasswordViewController *wsNewPasswordViewController = [segue destinationViewController];
        wsNewPasswordViewController.userId = self.userID;
    }
}


- (IBAction)barBtnBackClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
