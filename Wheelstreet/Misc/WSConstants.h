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
static NSString *DEFAULTS_ACCESS_TOKEN              = @"DEFAULTS_ACCESS_TOKEN";
static NSString *DEFAULTS_REFRESH_TOKEN             = @"DEFAULTS_REFRESH_TOKEN";

static NSString *AUTHORIZATION_HEADER_KEY = @"Authorization";
static NSString *AUTHORIZATION_HEADER_VALUE_PREFIX = @"Bearer";

static NSString *JSON_KEY_FIRST_NAME                = @"first_name";
static NSString *JSON_KEY_LAST_NAME                 = @"last_name";
static NSString *JSON_KEY_MOBILE                    = @"mobile";
static NSString *JSON_KEY_EMAIL                     = @"email";
static NSString *JSON_KEY_FB_ID                     = @"fb_id";
static NSString *JSON_KEY_ACCESS_TOKEN              = @"access_token";
static NSString *JSON_KEY_REFRESH_TOKEN             = @"refresh_token";
static NSString *JSON_KEY_PASSWORD                  = @"password";
static NSString *JSON_KEY_CONFIRM_PASSWORD          = @"confirm_password";
static NSString *JSON_KEY_IS_FACEBOOK_LOGIN         = @"is_facebook_login";
static NSString *JSON_KEY_SUCCESS                   = @"success";
static NSString *JSON_KEY_MESSAGE                   = @"message";
static NSString *JSON_KEY_USER                      = @"user";
static NSString *JSON_KEY_USER_ID                   = @"user_id";   // In some screens, user id is written as user_id and as id in some screens. So always check the parametres and the result.
static NSString *JSON_KEY_ID                        = @"id";
static NSString *JSON_KEY_FB_PROFILE                = @"fb_profile";
static NSString *JSON_KEY_FB_ABOUT_ME               = @"fb_about_me";
static NSString *JSON_KEY_OTP                       = @"otp";
static NSString *JSON_KEY_FACEBOOK_DATA             = @"facebook_data";
static NSString *JSON_KEY_VERSION                   = @"version";
static NSString *JSON_KEY_BUILD                     = @"build";
static NSString *JSON_KEY_IOS                       = @"ios";
static NSString *JSON_KEY_START_DATE                = @"start_date";
static NSString *JSON_KEY_END_DATE                  = @"end_date";
static NSString *JSON_KEY_BIKES                     = @"bikes";
static NSString *JSON_KEY_CITY                      = @"city";
static NSString *JSON_KEY_BIKE_IMAGE                = @"bike_image";
static NSString *JSON_KEY_BIKE_IMAGE_SMALL          = @"bike_image_small";
static NSString *JSON_KEY_BIKES_ID                  = @"bikes_id";
static NSString *JSON_KEY_BRAND_ID                  = @"brand_id";
static NSString *JSON_KEY_BRAND_NAME                = @"brand_name";
static NSString *JSON_KEY_CITIES_ID                 = @"cities_id";
static NSString *JSON_KEY_LOCALITY                  = @"locality";
static NSString *JSON_KEY_PRICE                     = @"price";
static NSString *JSON_KEY_SECURITY_DEPOSIT          = @"security_deposit";
static NSString *JSON_KEY_MODEL_NAME                = @"model_name";
static NSString *JSON_KEY_DEALER_ADDRESS            = @"dealer_address";
static NSString *JSON_KEY_DEALER_BIKE_ID            = @"dealer_bike_id";
static NSString *JSON_KEY_DEALER_LONGITUDE          = @"dealer_longitude";
static NSString *JSON_KEY_DEALER_LATITUDE           = @"dealer_latitude";
static NSString *JSON_KEY_DEALER_NAME               = @"dealer_name";
static NSString *JSON_KEY_DISTANCE                  = @"distance";
static NSString *JSON_KEY_FOS_CONTACT_NUMBER        = @"fos_contact_number";
static NSString *JSON_KEY_FOS_NAME                  = @"fos_name";
static NSString *JSON_KEY_LOCALITY_ID               = @"locality_id";
static NSString *JSON_KEY_LOCATION                  = @"location";
static NSString *JSON_KEY_QUANTITY                  = @"quantity";
static NSString *JSON_KEY_FILTERS                   = @"filters";

static NSString *CORE_DATA_ENTITY_FILTERS           = @"Filters";
static NSString *CORE_DATA_ENTITY_BIKES             = @"Bikes";
static NSString *CORE_DATA_ENTITY_BRANDS_FILTER     = @"BrandsFilter";
static NSString *CORE_DATA_ENTITY_PRICE_FILTER      = @"PriceFilter";
static NSString *CORE_DATA_ENTITY_BOOKINGS          = @"Bookings";

static NSString *CORE_DATA_ENTITY_BIKES_ATTRIBUTE_BIKE_IMAGE                        = @"bike_image";
static NSString *CORE_DATA_ENTITY_BIKES_ATTRIBUTE_BIKE_IMAGE_SMALL                  = @"bike_image_small";
static NSString *CORE_DATA_ENTITY_BIKES_ATTRIBUTE_BIKES_ID                          = @"bikes_id";
static NSString *CORE_DATA_ENTITY_BIKES_ATTRIBUTE_BRAND_ID                          = @"brand_id";
static NSString *CORE_DATA_ENTITY_BIKES_ATTRIBUTE_BRAND_NAME                        = @"brand_name";
static NSString *CORE_DATA_ENTITY_BIKES_ATTRIBUTE_CITIES_ID                         = @"cities_id";
static NSString *CORE_DATA_ENTITY_BIKES_ATTRIBUTE_CITY                              = @"city";
static NSString *CORE_DATA_ENTITY_BIKES_ATTRIBUTE_LOCALITY                          = @"locality";
static NSString *CORE_DATA_ENTITY_BIKES_ATTRIBUTE_MODEL_NAME                        = @"model_name";
static NSString *CORE_DATA_ENTITY_BIKES_ATTRIBUTE_PRICE                             = @"price";
static NSString *CORE_DATA_ENTITY_BIKES_ATTRIBUTE_SECURITY_DEPOSIT                  = @"security_deposit";
static NSString *CORE_DATA_ENTITY_BIKES_ATTRIBUTE_NEAREST_LOCATION_DISTANCE         = @"nearest_location_distance";

static NSString *CORE_DATA_ENTITY_BOOKINGS_ATTRIBUTE_BIKE_ID                        = @"bike_id";
static NSString *CORE_DATA_ENTITY_BOOKINGS_ATTRIBUTE_BIKE_IMAGE_SMALL               = @"bike_image_small";
static NSString *CORE_DATA_ENTITY_BOOKINGS_ATTRIBUTE_BIKES_QUANTITY_AVAILABLE       = @"bikes_quanitity_available";
static NSString *CORE_DATA_ENTITY_BOOKINGS_ATTRIBUTE_BRAND_NAME                     = @"brand_name";
static NSString *CORE_DATA_ENTITY_BOOKINGS_ATTRIBUTE_DEALER_BIKE_ID                 = @"dealer_bike_id";
static NSString *CORE_DATA_ENTITY_BOOKINGS_ATTRIBUTE_DEPOSIT                        = @"deposit";
static NSString *CORE_DATA_ENTITY_BOOKINGS_ATTRIBUTE_END_DATE                       = @"end_date";
static NSString *CORE_DATA_ENTITY_BOOKINGS_ATTRIBUTE_LOCALITY_ID                    = @"locality_id";
static NSString *CORE_DATA_ENTITY_BOOKINGS_ATTRIBUTE_LOCATION_DISTANCE              = @"location_distance";
static NSString *CORE_DATA_ENTITY_BOOKINGS_ATTRIBUTE_LOCATION_NAME                  = @"location_name";
static NSString *CORE_DATA_ENTITY_BOOKINGS_ATTRIBUTE_MODEL_NAME                     = @"model_name";
static NSString *CORE_DATA_ENTITY_BOOKINGS_ATTRIBUTE_QUANTITY                       = @"quantity";
static NSString *CORE_DATA_ENTITY_BOOKINGS_ATTRIBUTE_RENT                           = @"rent";
static NSString *CORE_DATA_ENTITY_BOOKINGS_ATTRIBUTE_START_DATE                     = @"start_date";
static NSString *CORE_DATA_ENTITY_BOOKINGS_ATTRIBUTE_USER_ID                        = @"user_id";

static NSString *CORE_DATA_ENTITY_FILTERS_ATTRIBUTE_BRAND_ID                        = @"brand_id";
static NSString *CORE_DATA_ENTITY_FILTERS_ATTRIBUTE_BRAND_NAME                      = @"brand_name";

static NSString *CORE_DATA_ENTITY_BRANDS_FILTER_ATTRIBUTE_BRAND_ID                  = @"brand_id";
static NSString *CORE_DATA_ENTITY_PRICE_FILTER_ATTRIBUTE_BRAND_NAME                 = @"brand_name";

static NSString *CORE_DATA_ENTITY_PRICE_FILTER_ATTRIBUTE_LOW_TO_HIGH                = @"low_to_high";
static NSString *CORE_DATA_ENTITY_PRICE_FILTER_ATTRIBUTE_HIGH_TO_LOW                = @"high_to_low";

static NSString *URL_LOGIN                          = @"login";
static NSString *URL_SIGNUP                         = @"user";
static NSString *URL_FORGOT_PASSWORD                = @"forgot_password";
static NSString *URL_VERIFY_OTP                     = @"verify_otp";
static NSString *URL_CHANGE_PASSWORD                = @"change_password";
static NSString *URL_FACEBOOK_LOGIN                 = @"fb_login";
static NSString *URL_APP_VERSION                    = @"app_version";
static NSString *URL_SEARCH_BIKES                   = @"getbikeavailablelocation";

static NSString *REQUEST_METHOD_POST                = @"POST";
static NSString *REQUEST_METHOD_GET                 = @"GET";

//static NSString *PICKUP_LOCATION;
//static NSString *PICKUP_TIME;
//static NSString *DROP_TIME;

//#define URL_LOGIN                       @"login"


#endif /* Constants_h */
