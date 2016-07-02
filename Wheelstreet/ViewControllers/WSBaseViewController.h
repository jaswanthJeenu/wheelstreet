//
//  WSBaseViewController.h
//  Wheelstreet
//
//  Created by Jaswanth Jeenu on 01/06/16.
//  Copyright © 2016 Bashar Technologies Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "ApiManager.h"



@interface WSBaseViewController : UIViewController{
    AppDelegate *appDelegate;
    NSUserDefaults *defaults;
    MBProgressHUD *progressHUD;
    //    int swipeTutorialPageIndex;
}

-(void) showProgressHudWithMessage:(NSString *) message;
-(void) hideProgressHUD;
-(void) showFeedbackWithTitle:(NSString *) title andMessage:(NSString *) message andIsError:(BOOL) isError;
@end
