//
//  WSBaseViewController.m
//  Wheelstreet
//
//  Created by Jaswanth Jeenu on 01/06/16.
//  Copyright © 2016 Bashar Technologies Pvt Ltd. All rights reserved.
//

#import "WSBaseViewController.h"

@interface WSBaseViewController ()

@end

@implementation WSBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate = [UIApplication sharedApplication].delegate;
    defaults = [NSUserDefaults standardUserDefaults];
}

//-(UIStatusBarStyle)preferredStatusBarStyle
//{
//    return UIStatusBarStyleLightContent;
//}



-(void) showProgressHudWithMessage:(NSString *) message {
    if(progressHUD == nil) {
        progressHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [progressHUD setLabelText:message];
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            // Do something...
        });
    }
}

-(void) hideProgressHUD {
    dispatch_async(dispatch_get_main_queue(), ^{
        if(progressHUD != nil) {
            [progressHUD hideAnimated:YES];
            progressHUD = nil;
        }
    });
}

-(void) showFeedbackWithTitle:(NSString *) title andMessage:(NSString *) message andIsError:(BOOL) isError {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alert show];
}

@end
