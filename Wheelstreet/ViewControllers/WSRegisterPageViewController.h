//
//  WSRegisterPageViewController.h
//  Wheelstreet
//
//  Created by Jaswanth Jeenu on 02/06/16.
//  Copyright © 2016 Bashar Technologies Pvt Ltd. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "WSLoginSignupPageChangeDelegate.h"

@interface WSRegisterPageViewController : UIPageViewController<UIPageViewControllerDataSource, UIPageViewControllerDelegate, WSLoginSignupPageChangeDelegate> {
    UIViewController *contentViewController;
    int pageViewControlIndex;
}

@end

