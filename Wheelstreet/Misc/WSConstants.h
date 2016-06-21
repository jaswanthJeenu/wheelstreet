//
//  WSConstants.h
//  Wheelstreet
//
//  Created by Jaswanth Jeenu on 03/06/16.
//  Copyright © 2016 Bashar Technologies Pvt Ltd. All rights reserved.
//

#ifndef Constants_h
#define Constants_h
#import <UIKit/UIKit.h>
#import "WSUtils.h"

typedef enum : int {
    DEV,
    STAGING,
    PRODUCTION
} TYPE_ENVIRONMENT;

static int TXT_FIELD_INSET = 10;

static NSString *DEFAULTS_FIRST_NAME                = @"DEFAULTS_FIRST_NAME";
static NSString *DEFAULTS_LAST_NAME                 = @"DEFAULTS_LAST_NAME";
static NSString *DEFAULTS_MOBILE                    = @"DEFAULTS_MOBILE";
static NSString *DEFAULTS_EMAIL                     = @"DEFAULTS_EMAIL";
static NSString *DEFAULTS_USER_ID                   = @"DEFAULTS_USER_ID";
static NSString *DEFAULTS_FB_ID                     = @"DEFAULTS_FB_ID";
static NSString *DEFAULTS_FB_ABOUT_ME               = @"DEFAULTS_FB_ABOUT_ME";
static NSString *DEFAULTS_FB_PROFILE                = @"DEFAULTS_FB_PROFILE";
static NSString *DEFAULTS_ACCESS_TOKEN = @"DEFAULTS_ACCESS_TOKEN";
static NSString *DEFAULTS_REFRESH_TOKEN = @"DEFAULTS_REFRESH_TOKEN";

static NSString *AUTHORIZATION_HEADER_KEY = @"Authorization";
static NSString *AUTHORIZATION_HEADER_VALUE_PREFIX = @"Bearer";

static NSString *JSON_KEY_FIRST_NAME = @"first_name";
static NSString *JSON_KEY_LAST_NAME = @"last_name";
static NSString *JSON_KEY_MOBILE = @"mobile";
static NSString *JSON_KEY_EMAIL = @"email";
static NSString *JSON_KEY_FB_ID = @"fb_id";
static NSString *JSON_KEY_ACCESS_TOKEN = @"access_token";
static NSString *JSON_KEY_REFRESH_TOKEN = @"refresh_token";
static NSString *JSON_KEY_PASSWORD = @"password";
static NSString *JSON_KEY_CONFIRM_PASSWORD = @"confirm_password";
static NSString *JSON_KEY_IS_FACEBOOK_LOGIN = @"is_facebook_login";
static NSString *JSON_KEY_SUCCESS = @"success";
static NSString *JSON_KEY_MESSAGE = @"message";
static NSString *JSON_KEY_USER = @"user";
static NSString *JSON_KEY_USER_ID = @"user_id";   // In some screens, user id is written as user_id and as id in some screens. So always check the parametres and the result.
static NSString *JSON_KEY_ID = @"id";
static NSString *JSON_KEY_FB_PROFILE = @"fb_profile";
static NSString *JSON_KEY_FB_ABOUT_ME = @"fb_about_me";
static NSString *JSON_KEY_OTP = @"otp";
static NSString *JSON_KEY_FACEBOOK_DATA = @"facebook_data";
static NSString *JSON_KEY_VERSION = @"version";
static NSString *JSON_KEY_BUILD = @"build";
static NSString *JSON_KEY_IOS = @"ios";
static NSString *JSON_KEY_START_DATE = @"start_date";
static NSString *JSON_KEY_END_DATE = @"end_date";
static NSString *JSON_KEY_LOCATION = @"location";

static NSString *URL_LOGIN = @"login";
static NSString *URL_SIGNUP = @"user";
static NSString *URL_FORGOT_PASSWORD = @"forgot_password";
static NSString *URL_VERIFY_OTP = @"verify_otp";
static NSString *URL_CHANGE_PASSWORD = @"change_password";
static NSString *URL_FACEBOOK_LOGIN = @"fb_login";
static NSString *URL_APP_VERSION = @"app_version";
static NSString *URL_SEARCH_BIKES = @"getbikeavailablelocation";

static NSString *REQUEST_METHOD_POST = @"POST";
static NSString *REQUEST_METHOD_GET = @"GET";

//#define URL_LOGIN                       @"login"


#endif /* Constants_h */
