//
//  WSOnboardingPageOneViewController.m
//  Wheelstreet
//
//  Created by Jaswanth Jeenu on 02/06/16.
//  Copyright © 2016 Bashar Technologies Pvt Ltd. All rights reserved.
//

#import "WSOnboardingPageOneViewController.h"

@interface WSOnboardingPageOneViewController ()

@end

@implementation WSOnboardingPageOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pgCntrlOnboarding.currentPage = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

//- (IBAction)pgCntrlOnboardingClicked:(id)sender {
//    NSLog(@"Page index: %ld", (long)((UIPageControl *) sender).currentPage);
//    //[self performSegueWithIdentifier:@"showOnboardingPageTwoSegue" sender:nil];
//
//}

- (IBAction)btnSkipClicked:(id)sender {
}

- (IBAction)btnNextClicked:(id)sender {
    //    [self performSegueWithIdentifier:@"showOnboardingPageTwoSegue" sender:nil];
    appDelegate.swipeTutorialPageIndex = 2;
}
@end
