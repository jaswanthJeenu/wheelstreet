//
//  WSLoginViewController.m
//  Wheelstreet
//
//  Created by Jaswanth Jeenu on 02/06/16.
//  Copyright © 2016 Bashar Technologies Pvt Ltd. All rights reserved.
//

#import "WSLoginViewController.h"

@interface WSLoginViewController ()


@end


@implementation WSLoginViewController

@synthesize loginSignupDelegate;

-(void)viewDidLoad {
    [FBSDKProfile enableUpdatesOnAccessTokenChange:YES];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    
    self.txtPassword.delegate = self;
    
}

- (IBAction)btnLoginClicked:(id)sender {
    
//    NSLog(@"WSLoginViewController::loginButtonClicked");
    [self.loginSignupDelegate pageChanged:0];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if(textField == self.txtPassword) {
        [textField resignFirstResponder];
        [self btnSignInClicked:nil];
    }
    return YES;
}

- (IBAction)btnSignUpClicked:(id)sender {
    
//    NSLog(@"WSLoginViewController::signupButtonClicked");
    [self.loginSignupDelegate pageChanged:1];
    
}

- (IBAction)btnSignInClicked:(id)sender {
    
    
    if ([self.txtMobileNumber.text isEqualToString:@""]){
        [self showFeedbackWithTitle: NSLocalizedString(@"FAILURE_HANDLER_TITLE", nil) andMessage: NSLocalizedString(@"PLEASE_ENTER_YOUR_MOBILE_NUMBER", nil) andIsError:YES];
    }
    
    else if ([self.txtMobileNumber.text isEqualToString:@""]){
        [self showFeedbackWithTitle: NSLocalizedString(@"FAILURE_HANDLER_TITLE", nil) andMessage: NSLocalizedString(@"PLEASE_ENTER_YOUR_PASSWORD", nil) andIsError:YES];
    }
    
    else{
        
        NSString *username = [self.txtMobileNumber.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        NSString *password = [self.txtPassword.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
        NSDictionary *parameters = @{JSON_KEY_MOBILE: username, JSON_KEY_PASSWORD: password};
    
        [self showProgressHudWithMessage: NSLocalizedString(@"SIGNING_IN", nil)];
        ApiManager *apiManager = [[ApiManager alloc] init];
        
        NSString *loginURL = [NSString stringWithFormat:@"%@%@", [WSUtils getApiBaseURL], URL_LOGIN];
        
        [apiManager makeNetworkCallOfType:REQUEST_METHOD_POST withUrl:loginURL andParameters:parameters withCompletionHandler:^(id  _Nullable responseObject) {
            [self hideProgressHUD];
//            NSLog(@"Success response: %@", responseObject);
            if([[responseObject objectForKey:JSON_KEY_SUCCESS] boolValue] == YES) {
                //NSLog(@"Login successful");
//              [defaults setObject:[responseObject objectForKey:@"first_name"] forKey:@"First Name"];
//              [defaults setObject:[responseObject objectForKey:@"last_name"] forKey:@"Last Name"];
//              [defaults setObject:[responseObject objectForKey:@"email"] forKey:@"Email"];
//              [defaults setObject:[responseObject objectForKey:@"mobile"] forKey:@"Mobile Number"];
//              [defaults setObject:[responseObject objectForKey:@"id"] forKey:@"User ID"];
//              [defaults setObject:[responseObject objectForKey:@"fb_id"] forKey:@"Facebook ID"];
//              [defaults setObject:[responseObject objectForKey:@"access_token"] forKey:@"Access Token"];
//              [defaults setObject:[responseObject objectForKey:@"refresh_token"] forKey:@"Refresh Token"];
            
                //NSLog(@"JSON Object firstname: %@", [responseObject objectForKey:JSON_KEY_FIRST_NAME]);
                WSUser* user = [[WSUser alloc]init];
                user.firstName = [[responseObject objectForKey:JSON_KEY_USER] objectForKey:JSON_KEY_FIRST_NAME];
                user.lastName = [[responseObject objectForKey:JSON_KEY_USER] objectForKey:JSON_KEY_LAST_NAME];
                user.email = [[responseObject objectForKey:JSON_KEY_USER] objectForKey:JSON_KEY_EMAIL];
                user.mobile = [[responseObject objectForKey:JSON_KEY_USER] objectForKey:JSON_KEY_MOBILE];
                user.userID = [[responseObject objectForKey:JSON_KEY_USER] objectForKey:JSON_KEY_USER_ID];
                user.fbID = [[responseObject objectForKey:JSON_KEY_USER] objectForKey:JSON_KEY_FB_ID];
                user.fbAboutMe = [[responseObject objectForKey:JSON_KEY_USER] objectForKey:JSON_KEY_FB_ABOUT_ME];
                user.fbProfile = [[responseObject objectForKey:JSON_KEY_USER] objectForKey:JSON_KEY_FB_PROFILE];
                user.accessToken = [[responseObject objectForKey:JSON_KEY_USER] objectForKey:JSON_KEY_ACCESS_TOKEN];
                user.refreshToken = [[responseObject objectForKey:JSON_KEY_USER] objectForKey:JSON_KEY_REFRESH_TOKEN];
                        
                [user saveUserDetailsInDefaults];
            
                //NSLog(@"first name: %@", [defaults stringForKey:DEFAULTS_FIRST_NAME]);
                //NSLog(@"first name: %@", [defaults stringForKey:DEFAULTS_FIRST_NAME]);
                //NSLog(@"last name: %@", [defaults objectForKey:DEFAULTS_LAST_NAME]);
                [self performSegueWithIdentifier:@"showHomeScreenSegue" sender:nil];
            
            } else {
                [self showFeedbackWithTitle: NSLocalizedString(@"LOGIN_FAILED", nil) andMessage:[responseObject objectForKey: JSON_KEY_MESSAGE] andIsError:YES];
                //NSLog(@"Login failed");
            }
        
        } andWithFailureHandler:^(NSError *error) {
            [self hideProgressHUD];
//          UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Sorry!" message:@"Unfortunately, your request failed." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:        nil];
//          [alert show];
        
            [self showFeedbackWithTitle: NSLocalizedString(@"FAILURE_HANDLER_TITLE", nil) andMessage: NSLocalizedString(@"FAILURE_HANDLER_MESSAGE", nil) andIsError:YES];
            //NSLog(@"Failure reason: %@", [error localizedDescription]);
        }];

    }
}


- (IBAction)btnContWithFbClicked:(id)sender {
    
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login logInWithReadPermissions: @[@"public_profile", @"email"] fromViewController:self
                            handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
                                 if (error) {
                                     NSLog(@"Process error");
                                 } else if (result.isCancelled) {
                                     NSLog(@"Cancelled");
                                 } else {
                                     NSLog(@"Logged in");
                                     [self getFacebookProfileInfos];
                                 }
                            }
     ];
    
}

-(void)getFacebookProfileInfos {
    
    NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
    [parameters setValue:@"id,name,email" forKey:@"fields"];
    
    FBSDKGraphRequest *requestMe = [[FBSDKGraphRequest alloc]initWithGraphPath:@"me" parameters:parameters];
    FBSDKGraphRequestConnection *connection = [[FBSDKGraphRequestConnection alloc] init];
    
    [connection addRequest:requestMe completionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
        //NSLog(@"Result: %@", result);
        if(result)
        {
//            if ([result objectForKey:@"email"]) {
//                
//                NSLog(@"Email: %@",[result objectForKey:@"email"]);
//                
//                
//            }
//            if ([result objectForKey:@"name"]) {
//                
//                NSLog(@"Name : %@",[result objectForKey:@"name"]);
//                
//            }
//            if ([result objectForKey:@"id"]) {
//                
//                NSLog(@"User id : %@",[result objectForKey:@"id"]);
//                
//            }
            
            NSString *email = [result objectForKey:@"email"];
            NSString *facebook_ID = [result objectForKey:@"id"];
            
            NSDictionary *parameters = @{JSON_KEY_EMAIL: email, JSON_KEY_FB_ID: facebook_ID};
            
            [self showProgressHudWithMessage: NSLocalizedString(@"SIGNING_IN", nil)];
            ApiManager *apiManager = [[ApiManager alloc] init];
            
            NSString *facebookLoginURL = [NSString stringWithFormat:@"%@%@", [WSUtils getApiBaseURL], URL_FACEBOOK_LOGIN];
            
            [apiManager makeNetworkCallOfType:REQUEST_METHOD_POST withUrl:facebookLoginURL andParameters:parameters withCompletionHandler:^(id  _Nullable responseObject) {
                [self hideProgressHUD];
                //NSLog(@"Success response: %@", responseObject);
                if([[responseObject objectForKey:JSON_KEY_SUCCESS] boolValue] == YES) {
                    //NSLog(@"Login successful");
                    
                    // TODO: Create a method in WSUser which takes the response as parameter, iniitalizes the user properties and returns a user instance.
                    // The idea is to avoid code duplication.
                    // Code duplicated in this ViewController
                    WSUser* user = [[WSUser alloc]init];
                    user.firstName = [[responseObject objectForKey:JSON_KEY_USER] objectForKey:JSON_KEY_FIRST_NAME];
                    user.lastName = [[responseObject objectForKey:JSON_KEY_USER] objectForKey:JSON_KEY_LAST_NAME];
                    user.email = [[responseObject objectForKey:JSON_KEY_USER] objectForKey:JSON_KEY_EMAIL];
                    user.mobile = [[responseObject objectForKey:JSON_KEY_USER] objectForKey:JSON_KEY_MOBILE];
                    user.userID = [[responseObject objectForKey:JSON_KEY_USER] objectForKey:JSON_KEY_USER_ID];
                    user.fbID = [[responseObject objectForKey:JSON_KEY_USER] objectForKey:JSON_KEY_FB_ID];
                    user.fbAboutMe = [[responseObject objectForKey:JSON_KEY_USER] objectForKey:JSON_KEY_FB_ABOUT_ME];
                    user.fbProfile = [[responseObject objectForKey:JSON_KEY_USER] objectForKey:JSON_KEY_FB_PROFILE];
                    user.accessToken = [[responseObject objectForKey:JSON_KEY_USER] objectForKey:JSON_KEY_ACCESS_TOKEN];
                    user.refreshToken = [[responseObject objectForKey:JSON_KEY_USER] objectForKey:JSON_KEY_REFRESH_TOKEN];
                    
                    //user.jsonString = responseObject;
                    
                    [user saveUserDetailsInDefaults];
                    
                    [self performSegueWithIdentifier:@"showHomeScreenSegue" sender:nil];
                    
                } else {
                    [self showFeedbackWithTitle: NSLocalizedString(@"LOGIN_FAILED", nil) andMessage: [responseObject objectForKey: JSON_KEY_MESSAGE] andIsError:YES];
                    NSLog(@"Signin failed");
                }
                
            } andWithFailureHandler:^(NSError *error) {
                [self hideProgressHUD];
                //        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Sorry!" message:@"Unfortunately, your request failed." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                //        [alert show];
                
                [self showFeedbackWithTitle: NSLocalizedString(@"FAILURE_HANDLER_TITLE", nil) andMessage: NSLocalizedString(@"FAILURE_HANDLER_MESSAGE", nil) andIsError:YES];
                NSLog(@"Failure reason: %@", [error localizedDescription]);
            }];
            

        }
        
    }];
    
    [connection start];
}

@end





