//
//  WSSendOTPViewController.m
//  Wheelstreet
//
//  Created by Jaswanth Jeenu on 01/06/16.
//  Copyright © 2016 Bashar Technologies Pvt Ltd. All rights reserved.
//

#import "WSSendOTPViewController.h"

@interface WSSendOTPViewController (){
    NSString* user_id;
}

@end

@implementation WSSendOTPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [[self.txtMobileNumber layer] setBorderColor:[[UIColor colorWithRed:171.0/255.0
//                                                  green:171.0/255.0
//                                                   blue:171.0/255.0
//                                                  alpha:1.0] CGColor]];

}
- (IBAction)btnSendOTPClicked:(id)sender {
    
    if ([self.txtMobileNumber.text isEqualToString:@""]){
        [self showFeedbackWithTitle: NSLocalizedString(@"FAILURE_HANDLER_TITLE", nil) andMessage: NSLocalizedString(@"PLEASE_ENTER_YOUR_MOBILE_NUMBER", nil) andIsError:YES];
    }
    
    else{
        
        NSString *mobileNumber = [self.txtMobileNumber.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        NSDictionary *parameters = @{JSON_KEY_MOBILE: mobileNumber};
        
        [self showProgressHudWithMessage: NSLocalizedString(@"SENDING_OTP", nil)];
        ApiManager *apiManager = [[ApiManager alloc] init];
    
        NSString *sendOTP_URL = [NSString stringWithFormat:@"%@%@", [WSUtils getApiBaseURL], URL_FORGOT_PASSWORD];
    
        [apiManager makeNetworkCallOfType:REQUEST_METHOD_POST withUrl:sendOTP_URL andParameters:parameters withCompletionHandler:^(id  _Nullable responseObject) {
            [self hideProgressHUD];
            //NSLog(@"Success response: %@", responseObject);
            if([[responseObject objectForKey:JSON_KEY_SUCCESS] boolValue] == YES) {
            
                //NSLog(@"OTP is successfully sent");
                user_id = [responseObject objectForKey:JSON_KEY_USER_ID];
                [self performSegueWithIdentifier:@"showVerificationScreenSegue" sender:nil];
            
            } else {
                [self showFeedbackWithTitle: NSLocalizedString(@"FAILURE_HANDLER_TITLE", nil) andMessage: [responseObject objectForKey: JSON_KEY_MESSAGE] andIsError:YES];
                //NSLog(@"Failed to send OTP");
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
    WSOTPVerificationViewController *wsOTPVerificationViewController = [segue destinationViewController];
    wsOTPVerificationViewController.userID = user_id;
    wsOTPVerificationViewController.isMobileNumberVerification = NO;
}

- (IBAction)btnBackClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
