//
//  WSUser.m
//  Wheelstreet
//
//  Created by Jaswanth Jeenu on 06/06/16.
//  Copyright © 2016 Bashar Technologies Pvt Ltd. All rights reserved.
//

#import "WSUser.h"

@implementation WSUser

@synthesize name, firstName, lastName, email, mobile, password, confirmPassword, userID, fbID, fbAboutMe, fbProfile, accessToken, refreshToken;

-(void) saveUserDetailsInDefaults {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.firstName forKey:DEFAULTS_FIRST_NAME];
//    [defaults setValue:self.firstName forKey:DEFAULTS_FIRST_NAME];
    [defaults setObject:self.lastName forKey:DEFAULTS_LAST_NAME];
    [defaults setObject:self.email forKey:DEFAULTS_EMAIL];
    [defaults setObject:self.mobile forKey:DEFAULTS_MOBILE];
    [defaults setObject:self.userID forKey:DEFAULTS_USER_ID];
    [defaults setObject:self.fbID forKey:DEFAULTS_FB_ID];
    [defaults setObject:@"" forKey:DEFAULTS_FB_ABOUT_ME];
    [defaults setObject:[NSString stringWithFormat:@"https://www.facebook.com/%@", self.fbID] forKey:DEFAULTS_FB_PROFILE];
    [defaults setObject:self.accessToken forKey:DEFAULTS_ACCESS_TOKEN];
    [defaults setObject:self.refreshToken forKey:DEFAULTS_REFRESH_TOKEN];
    [defaults synchronize];

}

-(NSDictionary *) getUserDictionary: (BOOL) isFbLogin {
    
    NSDictionary *facebookData = nil;
    if(isFbLogin) {
        facebookData = @{
                         JSON_KEY_FB_ID: self.fbID,
                         JSON_KEY_FB_ABOUT_ME: @"",
                         JSON_KEY_FB_PROFILE: [NSString stringWithFormat:@"https://www.facebook.com/%@", self.fbID]
                         };
    }
    
    return @{
                JSON_KEY_FIRST_NAME: self.firstName,
                JSON_KEY_LAST_NAME: self.lastName,
                JSON_KEY_EMAIL: self.email,
                JSON_KEY_MOBILE: self.mobile,
                JSON_KEY_PASSWORD: self.password,
                JSON_KEY_CONFIRM_PASSWORD: self.confirmPassword,
                JSON_KEY_IS_FACEBOOK_LOGIN: (isFbLogin) ? @"true" : @"false",
                JSON_KEY_FACEBOOK_DATA: (isFbLogin) ? facebookData : @"nil"
             };
    
}

@end
