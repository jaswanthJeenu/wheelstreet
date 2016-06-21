//
//  GoogleViewController.m
//  Wheelstreet
//
//  Created by Jaswanth Jeenu on 15/06/16.
//  Copyright © 2016 Bashar Technologies Pvt Ltd. All rights reserved.
//

#import "GoogleViewController.h"

@interface GoogleViewController ()

@end

@implementation GoogleViewController

@synthesize webViewGoogle;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.webViewGoogle loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.wheelstreet.in/mobilefaq"]]];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



- (IBAction)btnBackClicked:(id)sender {
    
}
@end
