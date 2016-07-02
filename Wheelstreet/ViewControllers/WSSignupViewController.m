//
//  WSSignupViewController.m
//  Wheelstreet
//
//  Created by Jaswanth Jeenu on 02/06/16.
//  Copyright © 2016 Bashar Technologies Pvt Ltd. All rights reserved.
//

#import "WSSignupViewController.h"

@interface WSSignupViewController (){
    BOOL isFacebookSignup;
    
    NSString *email;
    NSString *name;
    NSString *facebookID;
    NSString *facebookAboutMe;
    NSString *facebookProfile;
    NSString *userId;
    
}

@end


@implementation WSSignupViewController

-(void)viewDidLoad {
    self.isFacebookLogin = false;
}

- (IBAction)btnLoginClicked:(id)sender {
    
    //   NSLog(@"WSSignupViewController::loginButtonClicked");
    [self.loginSignupdelegate pageChanged:0];
    
}

- (IBAction)btnSignUpClicked:(id)sender {
    
    //    NSLog(@"WSSignupViewController::signupButtonClicked");
    [self.loginSignupdelegate pageChanged:1];
    
}

- (IBAction)btnExistingUserClicked:(id)sender {
    [self.loginSignupdelegate pageChanged:0];
}

- (IBAction)btnSignUpForWSClicked:(id)sender {
    
    if ([self.txtName.text isEqualToString:@""]
        || [self.txtContactNumber.text isEqualToString:@""]
        || [self.txtEmailAddress.text isEqualToString:@""]
        || [self.txtPassword.text isEqualToString:@""]
        || [self.txtConfirmPassword.text isEqualToString:@""]){
        //        [self showTsMessageWithTitle:@"Error" andMessage:@"All fields are mandatory."];
        [self showFeedbackWithTitle: NSLocalizedString(@"FAILURE_HANDLER_TITLE", nil) andMessage: NSLocalizedString(@"ALL_THE_FIELDS_ARE_MANDATORY", nil) andIsError:YES];
        
    } else if (![self.txtPassword.text isEqualToString:self.txtConfirmPassword.text]){
        //        [self showTsMessageWithTitle:@"Error" andMessage:@"Passwords didn't match, please check your passwords."];
        [self showFeedbackWithTitle: NSLocalizedString(@"FAILURE_HANDLER_TITLE", nil) andMessage: NSLocalizedString(@"PASSWORDS_DIDN'T_MATCH", nil) andIsError:YES];
    }
    
    else{
        self.user = [[WSUser alloc]init];
        self.user.name = [self.txtName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        self.user.mobile = [self.txtContactNumber.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        self.user.email = [self.txtEmailAddress.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        self.user.password = [self.txtPassword.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        self.user.confirmPassword = [self.txtConfirmPassword.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if (self.isFacebookLogin == true){
            self.user.fbID = [NSString stringWithString:facebookID];
            self.user.fbProfile = [NSString stringWithString:facebookProfile];
            self.user.fbAboutMe = [NSString stringWithString:facebookAboutMe];
        }
        else{
            self.user.fbID = 0;
        }
        
        //          int strlength = (int)[self.name length];
        
        if ([self.user.name containsString:@" "]){
            NSRange range = [self.user.name rangeOfString:@" "];
            self.user.firstName = [NSString stringWithString:[self.user.name substringToIndex:range.location]];
            //          self.user.lastName = [NSString stringWithString:[self.user.name substringWithRange:NSMakeRange(range.location+1, strlength-(range.location+1))]];
            self.user.lastName = [NSString stringWithString:[self.user.name substringFromIndex:range.location+1]];
        }
        else{
            self.user.firstName = [NSString stringWithString:self.user.name];
            self.user.lastName = @"";
        }
        
        NSLog(@"User Dictionary: %@",[self.user getUserDictionary: self.isFacebookLogin]);
        
        /*
         NSString *jsonParams = [NSString stringWithFormat:@"{\"first_name\": \"%@\", \"last_name\": \"%@\", \"email\": \"%@\", \"mobile\": \"%@\", \"password\": \"%@\", \"confirm_password\": \"%@\"}", self.firstName, self.lastName, self.emailAddress, self.contactNumber, self.password, self.confirmPassword];
         NSLog(@"Params: %@", [NSString stringWithFormat:@"%@", jsonParams]);
         */
        
        [self showProgressHudWithMessage: NSLocalizedString(@"SIGNING_UP", nil)];
        ApiManager *apiManager = [[ApiManager alloc] init];
        
        NSString *signupURL = [NSString stringWithFormat:@"%@%@", [WSUtils getApiBaseURL], URL_SIGNUP];
        //NSLog(@"signupURL: %@", signupURL);
        
        [apiManager makeNetworkCallOfType:REQUEST_METHOD_POST withUrl:signupURL andParameters:[self.user getUserDictionary: self.isFacebookLogin] withCompletionHandler:^(id  _Nullable responseObject) {
            [self hideProgressHUD];
            //NSLog(@"Success response: %@", responseObject);
            if([[responseObject objectForKey:JSON_KEY_SUCCESS] boolValue] == YES) {
                //NSLog(@"Signup successful");
                //NSLog(@"User Id is %@", [[responseObject objectForKey:@"user"] objectForKey:JSON_KEY_ID]);
                userId = [NSString stringWithString:[[responseObject objectForKey:@"user"] objectForKey:JSON_KEY_ID]];
                
                self.user.accessToken = [[responseObject objectForKey:@"user"] objectForKey:JSON_KEY_ACCESS_TOKEN];
                self.user.refreshToken = [[responseObject objectForKey:@"user"] objectForKey:JSON_KEY_REFRESH_TOKEN];
                
                [self.user saveUserDetailsInDefaults];
                
                [self performSegueWithIdentifier:@"showMobileNumberVerificationScreenSegue" sender:nil];
            } else {
                [self showFeedbackWithTitle: NSLocalizedString(@"FAILURE_HANDLER_TITLE", nil) andMessage: [responseObject objectForKey: JSON_KEY_MESSAGE] andIsError:YES];
                //NSLog(@"Signup failed");
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
        if(result){
            
            email = [result objectForKey:@"email"];
            name = [result objectForKey:@"name"];
            facebookID = [result objectForKey:@"id"];
            facebookAboutMe = @"";
            facebookProfile = [NSString stringWithFormat:@"https://www.facebook.com/%@",[result objectForKey:@"id"]];
            
            [self.txtName setText:name];
            [self.txtEmailAddress setText:email];
            self.isFacebookLogin = true;
        }
    }];
    [connection start];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    WSOTPVerificationViewController *wsOTPVerificationViewController = [segue destinationViewController];
    wsOTPVerificationViewController.userID = userId;
    wsOTPVerificationViewController.isMobileNumberVerification = YES;
}


@end














