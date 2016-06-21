//
//  WSOnboardingPageTwoViewController.h
//  Wheelstreet
//
//  Created by Jaswanth Jeenu on 02/06/16.
//  Copyright © 2016 Bashar Technologies Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WSOnboardingPageTwoViewController : WSBaseViewController

@property (weak, nonatomic) IBOutlet UIPageControl *pgCntrlOnboarding;


//- (IBAction)pgCntrlOnboardingClicked:(id)sender;

- (IBAction)btnSkipClicked:(id)sender;
- (IBAction)btnNextClicked:(id)sender;

@end
