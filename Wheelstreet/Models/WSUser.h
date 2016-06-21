//
//  WSUser.h
//  Wheelstreet
//
//  Created by Jaswanth Jeenu on 06/06/16.
//  Copyright © 2016 Bashar Technologies Pvt Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WSUser : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSString *mobile;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) NSString *confirmPassword;
@property (strong, nonatomic) NSString *userID;
@property (strong, nonatomic) NSString *fbAboutMe;
@property (strong, nonatomic) NSString *fbID;
@property (strong, nonatomic) NSString *fbProfile;
@property (strong, nonatomic) NSString *accessToken;
@property (strong, nonatomic) NSString *refreshToken;

-(void) saveUserDetailsInDefaults;
-(NSDictionary *) getUserDictionary: (BOOL) isFbLogin;

@end
