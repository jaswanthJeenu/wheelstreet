//
//  WSOnboardingPageViewController.h
//  Wheelstreet
//
//  Created by Jaswanth Jeenu on 02/06/16.
//  Copyright © 2016 Bashar Technologies Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSOnboardingPageOneViewController.h"
#import "WSOnboardingPageTwoViewController.h"
#import "WSOnboardingPageThreeViewController.h"


@interface WSOnboardingPageViewController : UIPageViewController<UIPageViewControllerDataSource, UIPageViewControllerDelegate> {
    NSArray *arrVCs;
    WSOnboardingPageOneViewController *contentOneViewController;
    WSOnboardingPageTwoViewController *contentTwoViewController;
    WSOnboardingPageThreeViewController *contentThreeViewController;
    AppDelegate *appDelegate;
    int index;
}




@end
