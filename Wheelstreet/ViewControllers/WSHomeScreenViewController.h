//
//  WSHomeScreenViewController.h
//  Home Screen, Date and Time Picker
//
//  Created by Jaswanth Jeenu on 14/06/16.
//  Copyright © 2016 Home Screen, Date and Time Picker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UINavigationController+TransparentNavigationController.h"
#import "SWRevealViewController.h"
//#import "DSLCalendarView.h"
#import "Filters.h"
#import "Filters+CoreDataProperties.h"
#import "WSDisplayBikesViewController.h"

@interface WSHomeScreenViewController : WSBaseViewController<PlaceSearchTextFieldDelegate, UITextFieldDelegate, CLLocationManagerDelegate, UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UIView *viewSetLocation;
@property (weak, nonatomic) IBOutlet MVPlaceSearchTextField *txtPlaceSearch;
@property (weak, nonatomic) IBOutlet UILabel *lblRideOutInStyle;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintLocationWrapperTopMargin;
- (IBAction)barBtnBackClicked:(id)sender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintLocationWrapperLeftEdge;
- (IBAction)btnLocateMeClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnLocateMe;
@property (weak, nonatomic) IBOutlet UIImageView *imgLocate;

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLGeocoder *geocoder;
@property (strong, nonatomic) CLPlacemark *placemark;
@property (weak, nonatomic) IBOutlet UIButton *btnPickupTime;
@property (weak, nonatomic) IBOutlet UIButton *btnDropTime;
- (IBAction)btnPickupTimeClicked:(id)sender;
- (IBAction)btnDropTimeClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnSearchBikes;
- (IBAction)btnSearchBikesClicked:(id)sender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintLocationWrapperToImageLocate;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIDatePicker *dateTimePicker;
@property (weak, nonatomic) IBOutlet UILabel *lblInvalidDuration;
@property (weak, nonatomic) IBOutlet UIImageView *imgNavigationBarImage;
- (IBAction)timeChanged:(UIDatePicker *)sender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintAttributeWrapperHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintLocationWrapperToTopViewSetLocation;

@end
