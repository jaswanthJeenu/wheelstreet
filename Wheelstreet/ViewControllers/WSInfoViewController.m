//
//  WSInfoViewController.m
//  Wheelstreet
//
//  Created by Jaswanth Jeenu on 15/06/16.
//  Copyright © 2016 Bashar Technologies Pvt Ltd. All rights reserved.
//

#import "WSInfoViewController.h"

@interface WSInfoViewController ()

@end

@implementation WSInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    switch ([self.index integerValue]) {
        case 0:{
            
            break;
        }
        case 1:{
            
            [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.wheelstreet.in/mobilefaq"]]];
            break;
        }
        case 2:{
            
            [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.wheelstreet.in/mobileterms"]]];
            break;
        }
        case 3:{
            
            [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.wheelstreet.in/about"]]];
            break;
        }
            //        case 4:{
            //
            //            NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
            //            [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
            //            [self performSegueWithIdentifier:@"showLoginScreenAfterLogoutSegue" sender:nil];
            //            break;
            //        }
            
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
