//
//  WSOnboardingPageTwoViewController.m
//  Wheelstreet
//
//  Created by Jaswanth Jeenu on 02/06/16.
//  Copyright © 2016 Bashar Technologies Pvt Ltd. All rights reserved.
//

#import "WSOnboardingPageTwoViewController.h"

@interface WSOnboardingPageTwoViewController ()

@end

@implementation WSOnboardingPageTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pgCntrlOnboarding.currentPage = 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}


//- (IBAction)pgCntrlOnboardingClicked:(id)sender {
//    [self performSegueWithIdentifier:@"showOnboardingPageThreeSegue" sender:nil];
//}

- (IBAction)btnSkipClicked:(id)sender {
}

- (IBAction)btnNextClicked:(id)sender {
//    [self performSegueWithIdentifier:@"showOnboardingPageThreeSegue" sender:nil];
    appDelegate.swipeTutorialPageIndex = 3;
}
@end
