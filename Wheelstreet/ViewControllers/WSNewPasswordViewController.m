//
//  WSNewPasswordViewController.m
//  Wheelstreet
//
//  Created by Jaswanth Jeenu on 01/06/16.
//  Copyright © 2016 Bashar Technologies Pvt Ltd. All rights reserved.
//

#import "WSNewPasswordViewController.h"

@interface WSNewPasswordViewController ()

@end

@implementation WSNewPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (IBAction)btnSubmitClicked:(id)sender {
    
    NSString *newPassword = [[NSString alloc]init];
    NSString *confirmPassword = [[NSString alloc]init];
    
    newPassword = [self.txtNewPassword.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    confirmPassword = [self.txtConfirmPassword.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if (([self.txtNewPassword.text isEqualToString:@""])
        || ([self.txtConfirmPassword.text isEqualToString:@""])){
        [self showFeedbackWithTitle: NSLocalizedString(@"FAILURE_HANDLER_TITLE", nil) andMessage: NSLocalizedString(@"PLEASE_FILL_BOTH_THE_FILEDS", nil) andIsError:YES];
    }
    else if ((![newPassword isEqualToString:self.txtNewPassword.text])
             || (![confirmPassword isEqualToString:self.txtConfirmPassword.text])){
        [self showFeedbackWithTitle: NSLocalizedString(@"FAILURE_HANDLER_TITLE", nil) andMessage: NSLocalizedString(@"PASSWORD_CANNOT_START_OR_END_WITH_A_WHITESPACE", nil) andIsError:YES];
    }
    else if (![self.txtNewPassword.text isEqualToString:self.txtConfirmPassword.text]){
        [self showFeedbackWithTitle: NSLocalizedString(@"FAILURE_HANDLER_TITLE", nil) andMessage: NSLocalizedString(@"PASSWORDS_DIDN'T_MATCH", nil) andIsError:YES];
    }
    else{
         NSDictionary *parameters = @{JSON_KEY_PASSWORD: newPassword, JSON_KEY_CONFIRM_PASSWORD: confirmPassword, JSON_KEY_USER_ID:self.userId};
        [self showProgressHudWithMessage: NSLocalizedString(@"UPDATING_YOUR_PASSWORD", nil)];
        ApiManager *apiManager = [[ApiManager alloc] init];
        
        NSString *changePasswordURL = [NSString stringWithFormat:@"%@%@", [WSUtils getApiBaseURL], URL_CHANGE_PASSWORD];
        
        [apiManager makeNetworkCallOfType:@"POST" withUrl:changePasswordURL andParameters:parameters withCompletionHandler:^(id  _Nullable responseObject) {
            [self hideProgressHUD];
            //NSLog(@"Success response: %@", responseObject);
            if([[responseObject objectForKey:JSON_KEY_SUCCESS] boolValue] == YES) {
//                NSLog(@"Password successfully changed");
//                [defaults setObject:newPassword forKey:@"new_password"];
                [self.navigationController popToRootViewControllerAnimated:YES];
                
            } else {
                [self showFeedbackWithTitle: NSLocalizedString(@"FAILURE_HANDLER_TITLE", nil) andMessage: [responseObject objectForKey: JSON_KEY_MESSAGE] andIsError:YES];
//                NSLog(@"Failed to change password");
            }
            
        } andWithFailureHandler:^(NSError *error) {
            [self hideProgressHUD];
            //        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Sorry!" message:@"Unfortunately, your request failed." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            //        [alert show];
            
            [self showFeedbackWithTitle: NSLocalizedString(@"FAILURE_HANDLER_TITLE", nil) andMessage: NSLocalizedString(@"FAILURE_HANDLER_MESSAGE", nil) andIsError:YES];
            //NSLog(@"Failure reason: %@", [error localizedDescription]);
        }];
        

        
    }

}

- (IBAction)barBtnBackClicked:(id)sender {
}



@end
