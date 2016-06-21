//
//  WSInfoViewController.h
//  Wheelstreet
//
//  Created by Jaswanth Jeenu on 15/06/16.
//  Copyright © 2016 Bashar Technologies Pvt Ltd. All rights reserved.
//

#import "WSBaseViewController.h"

@interface WSInfoViewController : WSBaseViewController

@property (strong, nonatomic) NSNumber *index;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end
