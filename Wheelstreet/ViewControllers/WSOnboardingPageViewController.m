//
//  WSOnboardingPageViewController.m
//  Wheelstreet
//
//  Created by Jaswanth Jeenu on 02/06/16.
//  Copyright © 2016 Bashar Technologies Pvt Ltd. All rights reserved.
//

#import "WSOnboardingPageViewController.h"

@interface WSOnboardingPageViewController ()

@end

@implementation WSOnboardingPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = self;
    self.delegate = self;
    
    self.navigationController.navigationBar.hidden = YES;
    appDelegate = [UIApplication sharedApplication].delegate;
    
    
//  If we click on the next button, then the swipe would be disabled if an action segue is connected to the next page. So I connected it to the page view controller and the page view controller would load the appropriate page based on the value of 'swipeTutorialPageIndex'.
//====================================================================================================================================================
    
    if (appDelegate.swipeTutorialPageIndex == 1){
        
        contentOneViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"contentOneViewController"];
    
        [self setViewControllers:@[contentOneViewController] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
//        index = 1;
        self.navigationController.navigationBar.hidden = YES;
    }
    else if (appDelegate.swipeTutorialPageIndex == 2){
        
        contentTwoViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"contentTwoViewController"];
        
        [self setViewControllers:@[contentTwoViewController] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
        
//        index = 2;
        self.navigationController.navigationBar.hidden = YES;
    }
    else if (appDelegate.swipeTutorialPageIndex == 3){
        
        contentThreeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"contentThreeViewController"];
        
        [self setViewControllers:@[contentThreeViewController] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
        
//        index = 3;
        self.navigationController.navigationBar.hidden = YES;
    }
}

//====================================================================================================================================================

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
//    NSLog(@"viewControllerBeforeViewController %d", swipeTutorialPageindex);
    
    if(appDelegate.swipeTutorialPageIndex == 1) {
        return nil;
    }
    else if (appDelegate.swipeTutorialPageIndex == 2){
        appDelegate.swipeTutorialPageIndex--;
        WSOnboardingPageOneViewController *vcToReturn = [self.storyboard instantiateViewControllerWithIdentifier:@"contentOneViewController"];
        return vcToReturn;
    }
    else if (appDelegate.swipeTutorialPageIndex == 3){
        appDelegate.swipeTutorialPageIndex--;
        WSOnboardingPageTwoViewController *vcToReturn = [self.storyboard instantiateViewControllerWithIdentifier:@"contentTwoViewController"];
        return vcToReturn;
    }

    else return nil;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
//    NSLog(@"viewControllerAfterViewController %d", swipeTutorialPageIndex);
    
    if(appDelegate.swipeTutorialPageIndex == 3) {
        return nil;
    }
    else if (appDelegate.swipeTutorialPageIndex == 2){
        appDelegate.swipeTutorialPageIndex++;
        WSOnboardingPageThreeViewController *vcToReturn = [self.storyboard instantiateViewControllerWithIdentifier:@"contentThreeViewController"];
        return vcToReturn;
    }
    else if (appDelegate.swipeTutorialPageIndex == 1){
        appDelegate.swipeTutorialPageIndex++;
        WSOnboardingPageTwoViewController *vcToReturn = [self.storyboard instantiateViewControllerWithIdentifier:@"contentTwoViewController"];
        return vcToReturn;
    }
    
    else return nil;
}

//-(NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController{
//    return 3;
//}
//
//-(NSInteger)presentationForPageViewController:(UIPageViewController *)pageViewController {
//    NSLog(@"presentationIndexForPageViewController");
//    return 0;
//}


-(void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers {
    if([pendingViewControllers[0] class] == [WSOnboardingPageOneViewController class]) {
        appDelegate.swipeTutorialPageIndex = 1;
    } else if([pendingViewControllers[0] class] == [WSOnboardingPageTwoViewController class]) {
        appDelegate.swipeTutorialPageIndex = 2;
    } else if([pendingViewControllers[0] class] == [WSOnboardingPageThreeViewController class]) {
        appDelegate.swipeTutorialPageIndex = 3;
    }
//    NSLog(@"Page index in will transition: %d", index);
}


@end