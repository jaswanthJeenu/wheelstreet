//
//  WSRegisterPageViewController.m
//  Wheelstreet
//
//  Created by Jaswanth Jeenu on 02/06/16.
//  Copyright © 2016 Bashar Technologies Pvt Ltd. All rights reserved.
//

#import "WSRegisterPageViewController.h"
#import "WSLoginViewController.h"
#import "WSSignupViewController.h"

@interface WSRegisterPageViewController ()

@end

@implementation WSRegisterPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.delegate = self;
    //self.dataSource = self;
    //self.hidesBottomBarWhenPushed = YES;
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    self.navigationItem.hidesBackButton = YES;
    
    pageViewControlIndex = 0;
    contentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    ((WSLoginViewController *)contentViewController).loginSignupDelegate = self;
    [self setViewControllers:@[contentViewController] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
}

-(void)pageChanged:(int)pageIndex {
    //    NSLog(@"ViewController::pageChanged");
    
    // Same screen clicked
    if(pageIndex == pageViewControlIndex)
        return;
    
    pageViewControlIndex = pageIndex;
    if(pageIndex == 0) {
        contentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        ((WSLoginViewController *)contentViewController).loginSignupDelegate = self;
        [self setViewControllers:@[contentViewController] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
    } else if(pageIndex == 1) {
        contentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SignupViewController"];
        ((WSSignupViewController *)contentViewController).loginSignupdelegate = self;
        [self setViewControllers:@[contentViewController] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    }
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    //    NSLog(@"viewControllerBeforeViewController");
    if(pageViewControlIndex == 0)
        return nil;
    
    contentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    ((WSLoginViewController *)contentViewController).loginSignupDelegate = self;
    return contentViewController;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    //    NSLog(@"viewControllerAfterViewController");
    if(pageViewControlIndex == 1)
        return nil;
    
    contentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SignupViewController"];
    ((WSSignupViewController *)contentViewController).loginSignupdelegate = self;
    return contentViewController;
}

-(NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController{
    return 2;
}

-(NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    return 0;
}

-(void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers {
    //    NSLog(@"[pendingViewControllers[0] class]: %@", [pendingViewControllers[0] class]);
    
    if([pendingViewControllers[0] class] == [WSLoginViewController class]) {
        pageViewControlIndex = 0;
    } else if([pendingViewControllers[0] class] == [WSSignupViewController class]) {
        pageViewControlIndex = 1;
    }
}


@end
