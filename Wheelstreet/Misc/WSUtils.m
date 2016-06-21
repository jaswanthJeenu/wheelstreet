//
//  WSUtils.m
//  Wheelstreet
//
//  Created by Jaswanth Jeenu on 01/06/16.
//  Copyright © 2016 Bashar Technologies Pvt Ltd. All rights reserved.
//

#import "WSUtils.h"

@implementation WSUtils

+(UIColor *) getBarColor {
    return [UIColor colorWithRed:52.0f green:52.0f blue:52.0f alpha:1.0f];
}

+(NSString *) getApiBaseURL{
    NSString *prefix = @"";
    
    if(CURRENT_ENVIRONMENT == DEV) {
        prefix = @"dev";
    }
    if(CURRENT_ENVIRONMENT == STAGING) {
        prefix = @"staging";
    }
    if(CURRENT_ENVIRONMENT == PRODUCTION) {
        prefix = @"";
    }
    
    NSMutableString *temp = [NSMutableString stringWithFormat:@"https://api.%@.wheelstreet.in/v1/",prefix];
    return temp;
}


@end
