//
//  WSHomeViewController.m
//  Wheelstreet
//
//  Created by Jaswanth Jeenu on 01/06/16.
//  Copyright © 2016 Bashar Technologies Pvt Ltd. All rights reserved.
//

#import "WSHomeScreenViewController.h"
#import "AFURLResponseSerialization.h"
#import "AFHTTPSessionManager.h"
#import "AFURLRequestSerialization.h"

@interface WSHomeScreenViewController(){
    UIView *viewUseCurrentLocation;
    UIImageView *imgLocation;
    UIButton *but;
    NSString *userLatitude;
    NSString *userLongitude;
    NSString *pickupDateTime;
    NSString *dropDateTime;
    BOOL isPickupTime;
    NSDate *startDate;
    NSDate *endDate;
    NSString *pickupTime;
    NSString *dropTime;
    NSNumber *filtersCount;
    NSString *pickupLocation;
    int count;
}

@end

@implementation WSHomeScreenViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    [self configureAutoCompleteTextField];
    
    self.txtPlaceSearch.delegate = self;
    [self.navigationController presentTransparentNavigationBar];
    
    //    self.viewSetLocation.opaque = YES;
    
    
    self.viewSetLocation.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.viewSetLocation.layer.borderWidth = 1.5f;
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController ){
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    NSNotificationCenter *defCenter = [NSNotificationCenter defaultCenter];
    [defCenter addObserver:self selector:@selector(barBtnBackClicked:) name:@"revealHomeScreen" object:nil];
    
    
    if ([CLLocationManager locationServicesEnabled]){
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager = [[CLLocationManager alloc] init];
        self.geocoder = [[CLGeocoder alloc] init];
    }
    
    
    self.dateTimePicker.hidden = YES;
    [self.dateTimePicker setBackgroundColor:[UIColor whiteColor]];
    [self.dateTimePicker addTarget:self action:@selector(dateTimePickerChanged:) forControlEvents:UIControlEventValueChanged];
    self.dateTimePicker.minimumDate = [NSDate date];
    
    self.btnPickupTime.hidden = YES;
    self.btnDropTime.hidden = YES;
    self.btnDropTime.enabled = NO;
    self.btnSearchBikes.hidden = YES;
    self.lblInvalidDuration.hidden = YES;
    self.imgNavigationBarImage.hidden = YES;
    [self.view insertSubview:self.imgNavigationBarImage atIndex:0];
    
    self.btnPickupTime.layer.shadowColor = [UIColor blackColor].CGColor;
    self.btnPickupTime.layer.shadowOpacity = 0.15;
    self.btnPickupTime.layer.shadowRadius = 1;
    self.btnPickupTime.layer.shadowOffset = CGSizeMake(2.0f, 2.0f);
    
    [self.viewSetLocation.layer setBorderColor:(__bridge CGColorRef _Nullable)([UIColor colorWithRed:187.0/255.0f green:187.0/255.0f blue:187.0/255.0f alpha:1.0f])];
    
    //    [self.btnPickupTime setBackgroundImage:[UIImage imageNamed:@"S"] forState:UIControlStateNormal];
    [self.btnDropTime setBackgroundImage:[UIImage imageNamed:@"U.png"] forState:UIControlStateNormal];
    
    
    //    UIImage *backgroundImage = [UIImage imageNamed:@"BG@1x"];
    //    UIImageView *backgroundImageView=[[UIImageView alloc]initWithFrame:self.view.frame];
    //    backgroundImageView.image=backgroundImage;
    //    [self.view insertSubview:backgroundImageView atIndex:0];
    
    count = 0;
}

-(void)viewWillAppear:(BOOL)animated{
    // This is to make the navigation bar transparent even when we come back to home screen from the bike display view controller.
    [self.navigationController presentTransparentNavigationBar];    // We need to write it in viewWillAppear coz we are not putting a segue from bike display VC to here but popping that VC.
    // So, viewDidLoad is not called. It would have been called if there had been a segue to it.
}


-(void)viewDidAppear:(BOOL)animated {
    //Optional Properties
    _txtPlaceSearch.autoCompleteRegularFontName =  @"HelveticaNeue-Bold";
    _txtPlaceSearch.autoCompleteBoldFontName = @"HelveticaNeue";
    _txtPlaceSearch.autoCompleteTableCornerRadius = 0.0;
    _txtPlaceSearch.autoCompleteRowHeight = 44;
    _txtPlaceSearch.autoCompleteTableCellTextColor = [UIColor colorWithWhite:0.131 alpha:1.000];
    _txtPlaceSearch.autoCompleteFontSize = 14;
    _txtPlaceSearch.autoCompleteTableBorderWidth = 1.0;
    _txtPlaceSearch.showTextFieldDropShadowWhenAutoCompleteTableIsOpen = YES;
    _txtPlaceSearch.autoCompleteShouldHideOnSelection = YES;
    _txtPlaceSearch.autoCompleteShouldHideClosingKeyboard = YES;
    _txtPlaceSearch.autoCompleteShouldSelectOnExactMatchAutomatically = YES;
    _txtPlaceSearch.autoCompleteTableFrame = CGRectMake(self.view.frame.origin.x,
                                                        _txtPlaceSearch.frame.size.height+60.0f,
                                                        self.view.frame.size.width, 180.0);
}

#pragma mark - Google Place Suggestion Methods

- (void) configureAutoCompleteTextField {
    _txtPlaceSearch.placeSearchDelegate                 = self;
    _txtPlaceSearch.strApiKey                           = GOOGLE_API_KEY;
    _txtPlaceSearch.superViewOfList                     = self.view;  // View, on which Autocompletion list should be appeared.
    _txtPlaceSearch.autoCompleteShouldHideOnSelection   = YES;
    _txtPlaceSearch.maximumNumberOfAutoCompleteRows     = 5;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    
    self.lblRideOutInStyle.hidden = YES;
    self.sidebarButton.tag = 1;
    [self.sidebarButton setImage:[UIImage imageNamed:@"Back.png"]];
    self.btnLocateMe.hidden = YES;
    self.imgLocate.hidden = YES;
    self.imageView.hidden = YES;
    self.lblInvalidDuration.hidden = YES;
    self.dateTimePicker.hidden = YES;
    self.btnSearchBikes.hidden = YES;
    [self.view setBackgroundColor:[UIColor colorWithRed:232.0/255.0f green:232.0/255.0f blue:232.0/255.0f alpha:1.0f]];
    
    
    if (count == 0){
        [UIView animateWithDuration:0.5f animations:^{
            self.constraintLocationWrapperTopMargin.constant -= 196;
            self.constraintLocationWrapperLeftEdge.constant += 20;
            self.constraintLocationWrapperToImageLocate.constant -= 80;
            self.constraintAttributeWrapperHeight.constant -= 6;
            self.constraintLocationWrapperToTopViewSetLocation.constant -= 2;
            [self.view layoutIfNeeded];
            //            NSLog(@"Button y: %f", self.btnLocateMe.frame.origin.y);
            //            NSLog(@"Button y: %f", self.btnLocateMe.frame.origin.x);
            
        }
                         completion:^(BOOL finished){
                             //                [self.view insertSubview:self.imgNavigationBarImage atIndex:2];
                             self.imgNavigationBarImage.hidden = NO;
                             
                             viewUseCurrentLocation = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, _txtPlaceSearch.frame.size.height + 21.0f, self.view.frame.size.width, 42)];
                             [viewUseCurrentLocation setBackgroundColor:[UIColor whiteColor]];
                             
                             imgLocation =[[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x + 10.0f,  _txtPlaceSearch.frame.size.height + 33.0f, 14, 18)];
                             imgLocation.image = [UIImage imageNamed:@"Locate.png"];
                             imgLocation.backgroundColor = [UIColor whiteColor];
                             [self.view addSubview: imgLocation];
                             
                             but=[UIButton buttonWithType:UIButtonTypeRoundedRect];
                             but.frame= CGRectMake(self.view.frame.origin.x + 30.0f, _txtPlaceSearch.frame.size.height+21.0f, self.viewSetLocation.frame.size.width - 30.0f, 42);
                             [but setTitle:@"Use Current Location" forState:UIControlStateNormal];
                             [but setTintColor:[UIColor colorWithRed:192.0/255.0f green:192.0/255.0f blue:192.0/255.0f alpha:1.0f]];
                             [but setBackgroundColor: [UIColor whiteColor]];
                             but.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                             [but addTarget:self action:@selector(btnLocateMeClicked:) forControlEvents:UIControlEventTouchUpInside];
                             [self.view insertSubview:but belowSubview:imgLocation];
                             [self.view insertSubview:viewUseCurrentLocation belowSubview:but];
                             
                             
                             count = 1;
                             //                UIButton *but=[[UIButton alloc] initWithFrame:CGRectMake(194, 0, 66, 36)];
                             //                [but setTitle:@"Locate me" forState:UIControlStateNormal];
                             //                [but setBackgroundColor:[UIColor blueColor]];
                             //                [but addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
                             //                [self.viewSetLocation addSubview:but];
                             
                         }
         ];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    self.btnPickupTime.hidden = NO;
    self.btnDropTime.hidden = NO;
    self.dateTimePicker.hidden = NO;
    viewUseCurrentLocation.hidden = YES;
    imgLocation.hidden = YES;
    but.hidden = YES;
    isPickupTime = YES;
    
    return YES;
}

#pragma mark - Place search Textfield Delegates

-(void)placeSearch:(MVPlaceSearchTextField*)textField ResponseForSelectedPlace:(GMSPlace*)responseDict{
    [self.view endEditing:YES];
    self.btnPickupTime.hidden = NO;
    self.btnDropTime.hidden = NO;
    self.dateTimePicker.hidden = NO;
    self.btnPickupTime.backgroundColor = [UIColor whiteColor];
    self.btnPickupTime.tintColor = [UIColor blackColor];
    [self.btnDropTime setBackgroundColor:[UIColor colorWithRed:238/255.0f green:238/255.0f blue:238/255.0f alpha:1.0f]];
    [self.btnDropTime setTintColor:[UIColor colorWithRed:187.0/255.0f green:187.0/255.0f blue:187.0/255.0f alpha:1.0f]];
    viewUseCurrentLocation.hidden = YES;
    imgLocation.hidden = YES;
    but.hidden = YES;
    isPickupTime = YES;
    
    NSLog(@"SELECTED ADDRESS :%@",responseDict);
}

-(void)placeSearchWillShowResult:(MVPlaceSearchTextField*)textField{
    
}
-(void)placeSearchWillHideResult:(MVPlaceSearchTextField*)textField{
    
}
-(void)placeSearch:(MVPlaceSearchTextField*)textField ResultCell:(UITableViewCell*)cell withPlaceObject:(PlaceObject*)placeObject atIndex:(NSInteger)index{
    //    if(index%2==0){
    //        cell.contentView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    //    }else{
    //        cell.contentView.backgroundColor = [UIColor whiteColor];
    //    }
}




- (IBAction)barBtnBackClicked:(id)sender {
    
    if (self.sidebarButton.tag == 1){
        
        self.imageView.hidden = NO;
        self.dateTimePicker.hidden = YES;
        self.btnDropTime.hidden = YES;
        self.btnPickupTime.hidden = YES;
        self.btnSearchBikes.hidden = YES;
        self.lblInvalidDuration.hidden = YES;
        self.sidebarButton.tag = 0;
        [self.sidebarButton setImage:[UIImage imageNamed:@"Sidemenu.png"]];
        isPickupTime = YES;
        [self.btnPickupTime setBackgroundColor:[UIColor whiteColor]];
        [self.btnPickupTime setTintColor:[UIColor blackColor]];
        [self.btnDropTime setBackgroundColor:[UIColor colorWithRed:238/255.0f green:238/255.0f blue:238/255.0f alpha:1.0f]];
        [self.btnDropTime setTintColor:[UIColor colorWithRed:187.0/255.0f green:187.0/255.0f blue:187.0/255.0f alpha:1.0f]];
        [self.btnPickupTime setTitle:@"PICKUP TIME" forState:UIControlStateNormal];
        [self.btnDropTime setTitle:@"DROP TIME" forState:UIControlStateNormal];
        self.dateTimePicker.minimumDate = [NSDate date];
        self.imgNavigationBarImage.hidden = YES;
        self.btnDropTime.enabled = NO;
        viewUseCurrentLocation.hidden = YES;
        but.hidden = YES;
        imgLocation.hidden = YES;
        
        [UIView animateWithDuration:0.5f animations:^{
            self.constraintLocationWrapperTopMargin.constant += 196;
            self.constraintLocationWrapperLeftEdge.constant -= 20;
            self.constraintLocationWrapperToImageLocate.constant += 80;
            self.constraintAttributeWrapperHeight.constant += 6;
            self.constraintLocationWrapperToTopViewSetLocation.constant += 2;
            [self.view layoutIfNeeded];
        }
                         completion:^(BOOL finished) {
                             self.btnLocateMe.hidden = NO;
                             self.imgLocate.hidden = NO;
                             self.lblRideOutInStyle.hidden = NO;
                         }];
        
        count = 0;
        [self.txtPlaceSearch resignFirstResponder];
        [self.txtPlaceSearch setText:nil];
        
        
    }
    
    
}

- (IBAction)btnLocateMeClicked:(id)sender {
    
    [self showProgressHudWithMessage: NSLocalizedString(@"FETCHING_YOUR_LOCATION", nil)];
    
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startMonitoringSignificantLocationChanges];
    [self.locationManager startUpdatingLocation];
    
}


#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    [self hideProgressHUD];
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle: NSLocalizedString(@"ERROR", nil) message: NSLocalizedString(@"FAILED_TO_GET_YOUR_LOCATION",nil)
                               delegate:nil
                               cancelButtonTitle: NSLocalizedString(@"OK", nil)
                               otherButtonTitles:nil];
    [errorAlert show];
    [self.locationManager stopUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    CLLocation *location = [locations lastObject];
    userLatitude = [NSString stringWithFormat:@"%f", location.coordinate.latitude];
    userLongitude = [NSString stringWithFormat:@"%f", location.coordinate.longitude];
    [self hideProgressHUD];
    [self.locationManager stopUpdatingLocation];
    
    // Reverse Geocoding
    NSLog(@"Resolving the Address");
    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        NSLog(@"Found placemarks: %@, error: %@", placemarks, error);
        if (error == nil && [placemarks count] > 0) {
            self.placemark = [placemarks lastObject];
            
            [self.lblRideOutInStyle setHidden:YES];
            self.sidebarButton.tag = 1;
            [self.sidebarButton setImage:[UIImage imageNamed:@"Back.png"]];
            self.btnLocateMe.hidden = YES;
            self.imgLocate.hidden = YES;
            
            if (count == 0){
                [UIView animateWithDuration:0.5f animations:^{
                    self.constraintLocationWrapperTopMargin.constant -= 196;
                    self.constraintLocationWrapperLeftEdge.constant += 20;
                    self.constraintLocationWrapperToImageLocate.constant -= 80;
                    self.constraintAttributeWrapperHeight.constant -= 6;
                    self.constraintLocationWrapperToTopViewSetLocation.constant -=2;
                    self.txtPlaceSearch.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
                    [self.view layoutIfNeeded];
                }
                                 completion:^(BOOL finished){
                                     count = 1;
                                 }
                 ];
            }
            
            self.txtPlaceSearch.text = [NSString stringWithFormat:@"%@ %@, %@ %@, %@, %@",
                                        self.placemark.subThoroughfare, self.placemark.thoroughfare,
                                        self.placemark.postalCode, self.placemark.locality,
                                        self.placemark.administrativeArea,
                                        self.placemark.country];
            
            self.btnPickupTime.hidden = NO;
            self.btnDropTime.hidden = NO;
            self.dateTimePicker.hidden = NO;
            self.btnPickupTime.backgroundColor = [UIColor whiteColor];
            self.btnPickupTime.tintColor = [UIColor blackColor];
            [self.btnDropTime setBackgroundColor:[UIColor colorWithRed:238/255.0f green:238/255.0f blue:238/255.0f alpha:1.0f]];
            [self.btnDropTime setTintColor:[UIColor colorWithRed:187.0/255.0f green:187.0/255.0f blue:187.0/255.0f alpha:1.0f]];
            viewUseCurrentLocation.hidden = YES;
            imgLocation.hidden = YES;
            but.hidden = YES;
            
            isPickupTime = YES;
            
        } else {
            NSLog(@"%@", error.debugDescription);
        }
    } ];
}


#pragma mark - Date and Time Picker Methods

- (void)dateTimePickerChanged:(UIDatePicker *)datePicker
{
    //    if (!self.btnDropTime.enabled){
    //        self.btnDropTime.enabled = YES;
    //    }
    //
    //    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    //    [dateFormatter setDateFormat:@"dd MMMM  h:mm a"];
    //
    ////    [dateFormatter setDateFormat:@"dd-MM HH:mm"];
    //    if (isPickupTime){
    //        pickupDateTime = [dateFormatter stringFromDate:datePicker.date];
    //        startDate = datePicker.date;
    //    }
    //    else{
    //        dropDateTime = [dateFormatter stringFromDate:datePicker.date];
    //        endDate = datePicker.date;
    //    }
    //    self.selectedDateAndTime.text = strDate;
}





- (IBAction)btnPickupTimeClicked:(id)sender {
    
    isPickupTime = YES;
    self.lblInvalidDuration.hidden = YES;
    [self.btnPickupTime setBackgroundColor:[UIColor whiteColor]];
    [self.btnPickupTime setTitle:@"Pickup Time" forState:UIControlStateNormal];
    [self.btnPickupTime setTintColor:[UIColor blackColor]];
    [self.btnDropTime setBackgroundColor:[UIColor colorWithRed:238/255.0f green:238/255.0f blue:238/255.0f alpha:1.0f]];
    [self.btnDropTime setTintColor:[UIColor colorWithRed:187.0/255.0f green:187.0/255.0f blue:187.0/255.0f alpha:1.0f]];
    //    self.btnPickupTime.layer.shadowColor = [UIColor blackColor].CGColor;
    //    self.btnPickupTime.layer.shadowOpacity = 0.5;
    //    self.btnPickupTime.layer.shadowRadius = 1;
    
    self.btnPickupTime.layer.shadowOffset = CGSizeMake(2.0f, 2.0f);
    self.btnDropTime.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    //    [self.btnPickupTime setBackgroundImage:[UIImage imageNamed:@"S.png"] forState:UIControlStateNormal];
    [self.btnDropTime setBackgroundImage:[UIImage imageNamed:@"U.png"] forState:UIControlStateNormal];
    [self.btnPickupTime setBackgroundImage:nil forState:UIControlStateNormal];
    //
    self.dateTimePicker.minimumDate = [NSDate date];
    
    if (self.btnDropTime.enabled){
        if (dropDateTime){
            [self.btnDropTime setTitle:dropDateTime forState:UIControlStateNormal];
        }
        else [self.btnDropTime setTitle:pickupDateTime forState:UIControlStateNormal];
    }
    
    
}

- (IBAction)btnDropTimeClicked:(id)sender {
    
    isPickupTime = NO;
    self.lblInvalidDuration.hidden = YES;
    [self.btnDropTime setBackgroundColor:[UIColor whiteColor]];
    [self.btnDropTime setTitle:@"Drop Time" forState:UIControlStateNormal];
    [self.btnDropTime setTintColor:[UIColor blackColor]];
    [self.btnPickupTime setTitle:pickupDateTime forState:UIControlStateNormal];
    [self.btnPickupTime setBackgroundColor:[UIColor colorWithRed:238.0/255.0f green:238.0/255.0f blue:238.0/255.0f alpha:1.0f]];
    [self.btnPickupTime setTintColor:[UIColor colorWithRed:187.0/255.0f green:187.0/255.0f blue:187.0/255.0f alpha:1.0f]];
    
    self.btnDropTime.layer.shadowColor = [UIColor blackColor].CGColor;
    self.btnDropTime.layer.shadowOpacity = 0.5;
    self.btnDropTime.layer.shadowRadius = 1;
    self.btnDropTime.layer.shadowOffset = CGSizeMake(2.0f, 2.0f);
    //    self.btnPickupTime.layer.shadowColor = [UIColor blackColor].CGColor;
    //    self.btnPickupTime.layer.shadowOpacity = 0.5;
    //    self.btnPickupTime.layer.shadowRadius = 1;
    self.btnPickupTime.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    //    [self.btnDropTime setBackgroundImage:[UIImage imageNamed:@"S.png"] forState:UIControlStateNormal];
    [self.btnPickupTime setBackgroundImage:[UIImage imageNamed:@"U.png"] forState:UIControlStateNormal];
    [self.btnDropTime setBackgroundImage:nil forState:UIControlStateNormal];
    
    self.btnSearchBikes.hidden = NO;
    //    self.dateTimePicker.minimumDate = startDate;
    [self.btnPickupTime setTitle:pickupDateTime forState:UIControlStateNormal];
    
}

#pragma mark - UIWebViewDelegate methods

- (void)webViewDidStartLoad:(UIWebView *)webView;{
    [self showProgressHudWithMessage:NSLocalizedString(@"LOADING", nil)];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self hideProgressHUD];
}





- (IBAction)btnSearchBikesClicked:(id)sender {
    
    //    NSLog(@"%@", pickupTime);
    //    NSLog(@"%@", dropTime);
    //    NSLog(@"%@", pickupDateTime);
    //    NSLog(@"%@", dropDateTime);
    
    pickupLocation = [self.txtPlaceSearch.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSRange range = NSMakeRange(11, 2);
    
    if (!endDate){
        [self.lblInvalidDuration setText: NSLocalizedString(@"DROP_TIME_SHOULD_BE_GREATER_THAN_PICKUP_TIME", nil)];
        self.lblInvalidDuration.alpha = 1.0f;
        self.lblInvalidDuration.hidden = NO;
        [UIView animateWithDuration:3.0f delay:0.5f options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.lblInvalidDuration.alpha = 0.0f;
        }completion:nil];
    }
    
    else{
        if (((int)[[pickupTime substringWithRange:range] intValue] < 11)
            || ((int)[[pickupTime substringWithRange:range] intValue] > 19)
            || ((int)[[dropTime substringWithRange:range] intValue] > 19)
            || ((int)[[dropTime substringWithRange:range] intValue] > 19)){
            [self.lblInvalidDuration setText:NSLocalizedString(@"WE_OPERATE_ONLY_FROM 11_A.M_TO_7_P.M", nil)];
            self.lblInvalidDuration.alpha = 1.0f;
            self.lblInvalidDuration.hidden = NO;
            [UIView animateWithDuration:3.0f delay:0.5f options:UIViewAnimationOptionCurveEaseIn animations:^{
                self.lblInvalidDuration.alpha = 0.0f;
            }completion:nil];
            
            //            [NSTimer scheduledTimerWithTimeInterval:4.0
            //                                             target:self
            //                                           selector:@selector(targetMethod:)
            //                                           userInfo:nil
            //                                            repeats:NO];
        }
        
        else if ([startDate compare:endDate] == 1){
            [self.lblInvalidDuration setText: NSLocalizedString(@"DROP_TIME_SHOULD_BE_GREATER_THAN_PICKUP_TIME", nil)];
            self.lblInvalidDuration.alpha = 1.0f;
            self.lblInvalidDuration.hidden = NO;
            [UIView animateWithDuration:3.0f delay:0.5f options:UIViewAnimationOptionCurveEaseIn animations:^{
                self.lblInvalidDuration.alpha = 0.0f;
            }completion:nil];
            
        }
        
        else if ([pickupLocation isEqualToString:@""]){
            [self.lblInvalidDuration setText: NSLocalizedString(@"PLEASE_ENTER_YOUR_LOCATION", nil)];
            self.lblInvalidDuration.alpha = 1.0f;
            self.lblInvalidDuration.hidden = NO;
            [UIView animateWithDuration:3.0f delay:0.5f options:UIViewAnimationOptionCurveEaseIn animations:^{
                self.lblInvalidDuration.alpha = 0.0f;
            }completion:nil];
            
        }
        
        else if (((int)[[dropTime substringWithRange:NSMakeRange(0, 4)] intValue] == (int)[[pickupTime substringWithRange:NSMakeRange(0, 4)] intValue])
                 && ((int)[[dropTime substringWithRange:NSMakeRange(6, 2)] intValue] == (int)[[pickupTime substringWithRange:NSMakeRange(6, 2)] intValue])
                 && ((int)[[dropTime substringWithRange:NSMakeRange(9, 2)] intValue] == (int)[[pickupTime substringWithRange:NSMakeRange(9, 2)] intValue])
                 && ((int)[[dropTime substringWithRange:range] intValue]) - ((int)[[pickupTime substringWithRange:range] intValue]) < 3){
            
            [self.lblInvalidDuration setText: NSLocalizedString(@"THE_MINIMUM_TRIP_DURATION_IS_3_HOURS", nil)];
            self.lblInvalidDuration.alpha = 1.0f;
            self.lblInvalidDuration.hidden = NO;
            [UIView animateWithDuration:3.0f delay:0.5f options:UIViewAnimationOptionCurveEaseIn animations:^{
                self.lblInvalidDuration.alpha = 0.0f;
            }completion:nil];
        }
        
        else if (((int)[[pickupTime substringWithRange:range] intValue] == 19)
                 &&((int) [[pickupTime substringWithRange:NSMakeRange(14, 2)] intValue] == 30)){
            [self.lblInvalidDuration setText:NSLocalizedString(@"WE_OPERATE_ONLY_FROM 11_A.M_TO_7_P.M", nil)];
            self.lblInvalidDuration.alpha = 1.0f;
            self.lblInvalidDuration.hidden = NO;
            [UIView animateWithDuration:3.0f delay:0.5f options:UIViewAnimationOptionCurveEaseIn animations:^{
                self.lblInvalidDuration.alpha = 0.0f;
            }completion:nil];
        }
        
        else if (((int)[[dropTime substringWithRange:range] intValue] == 19)
                 &&((int) [[dropTime substringWithRange:NSMakeRange(14, 2)] intValue] == 30)){
            [self.lblInvalidDuration setText:NSLocalizedString(@"WE_OPERATE_ONLY_FROM 11_A.M_TO_7_P.M", nil)];
            self.lblInvalidDuration.alpha = 1.0f;
            self.lblInvalidDuration.hidden = NO;
            [UIView animateWithDuration:3.0f delay:0.5f options:UIViewAnimationOptionCurveEaseIn animations:^{
                self.lblInvalidDuration.alpha = 0.0f;
            }completion:nil];
        }
        
        else{
            
            //          NSDictionary *parameters = @{JSON_KEY_START_DATE: pickupTime, JSON_KEY_END_DATE: dropTime, JSON_KEY_LOCATION: pickupLocation};
            //
            //          ApiManager *apiManager = [[ApiManager alloc] init];
            //          AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
            //
            //
            //          NSString *searchBikesURL = [NSString stringWithFormat:@"%@%@", [WSUtils getApiBaseURL], URL_SEARCH_BIKES];
            //
            //          [apiManager makeNetworkCallOfType:REQUEST_METHOD_POST withUrl:searchBikesURL andParameters:parameters withCompletionHandler:^(id  _Nullable responseObject) {
            //
            //            NSLog(@"Success response: %@", responseObject);
            //            if([[responseObject objectForKey:JSON_KEY_SUCCESS] boolValue] == YES) {
            //                NSLog(@"Yahoo");
            //            }
            //            else {
            //                self.lblInvalidDuration.text = [responseObject objectForKey: JSON_KEY_MESSAGE];
            //            }
            //
            //        } andWithFailureHandler:^(NSError *error) {
            //
            //            [self showFeedbackWithTitle: NSLocalizedString(@"FAILURE_HANDLER_TITLE", nil) andMessage: NSLocalizedString(@"FAILURE_HANDLER_MESSAGE", nil) andIsError:YES];
            //            NSLog(@"Failure reason: %@", [error localizedDescription]);
            //            NSString* errResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
            //            NSLog(@"%@",errResponse);
            //            NSLog(@"new one\n");
            //            NSDictionary *userinfo1 = [[NSDictionary alloc] initWithDictionary:error.userInfo];
            //
            //            if(userinfo1)
            //            {
            //                NSError *innerError = [userinfo1 valueForKey:@"NSUnderlyingError"];
            //                if(innerError)
            //                {
            //                    NSDictionary *innerUserInfo = [[NSDictionary alloc] initWithDictionary:innerError.userInfo];
            //                    if(innerUserInfo)
            //                    {
            //                        if([innerUserInfo objectForKey:AFNetworkingOperationFailingURLResponseDataErrorKey])
            //                        {
            //                            NSString *strError = [[NSString alloc] initWithData:[innerUserInfo objectForKey:AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
            //                            NSLog(@"Error is : %@",strError);
            //                        }
            //                    }
            //                } else
            //                {
            //                    NSString *errResponse = [[NSString alloc] initWithData:[userinfo1 valueForKey:@"AFNetworkingOperationFailingURLResponseDataErrorKey"] encoding:NSUTF8StringEncoding];
            //
            //                    if(errResponse)
            //                    {
            //                        NSLog(@"%@",errResponse);
            //                    }
            //                }
            //            }
            //
            //            NSLog(@"Response Fail. Error : %@",error.localizedDescription);
            //            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            //
            //        }];
            
            AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            NSString *header = [NSString stringWithFormat:@"%@ %@", AUTHORIZATION_HEADER_VALUE_PREFIX, [defaults stringForKey:DEFAULTS_ACCESS_TOKEN]];
            [manager.requestSerializer setValue:header forHTTPHeaderField:AUTHORIZATION_HEADER_KEY];
            
            NSString *searchBikesURL = [NSString stringWithFormat:@"%@%@", [WSUtils getApiBaseURL], URL_SEARCH_BIKES];
            NSDictionary *parameters = @{JSON_KEY_START_DATE: pickupTime, JSON_KEY_END_DATE: dropTime, JSON_KEY_LOCATION: pickupLocation};
            [manager POST:searchBikesURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"Success response: %@", responseObject);
                if([[responseObject objectForKey:JSON_KEY_SUCCESS] boolValue] == YES) {
                    
                    //                    NSManagedObjectContext *context = appDelegate.managedObjectContext;
                    filtersCount = [NSNumber numberWithInt:(int)[[responseObject objectForKey:JSON_KEY_FILTERS] count]];
                    
                    int i;
                    for (i = 0;i < (int)[[responseObject objectForKey:JSON_KEY_FILTERS] count]; i++){
                        
                        Filters *filters = [NSEntityDescription insertNewObjectForEntityForName:CORE_DATA_ENTITY_FILTERS inManagedObjectContext:appDelegate.managedObjectContext];
                        filters.brand_name = [[[responseObject objectForKey:JSON_KEY_FILTERS] objectAtIndex:i] objectForKey:JSON_KEY_BRAND_NAME];
                        filters.brand_id = [[[responseObject objectForKey:JSON_KEY_FILTERS] objectAtIndex:i] objectForKey:JSON_KEY_BRAND_ID];
                    }
                    
                    for (i=0; i < (int)[[responseObject objectForKey:JSON_KEY_BIKES] count]; i++){
                        
                        Bikes *bikes = [NSEntityDescription insertNewObjectForEntityForName:CORE_DATA_ENTITY_BIKES inManagedObjectContext:appDelegate.managedObjectContext];
                        bikes.city = [[[responseObject objectForKey:JSON_KEY_BIKES] objectAtIndex:i] objectForKey:JSON_KEY_CITY];
                        bikes.bike_image = [[[responseObject objectForKey:JSON_KEY_BIKES] objectAtIndex:i] objectForKey:JSON_KEY_BIKE_IMAGE];
                        bikes.bike_image_small = [[[responseObject objectForKey:JSON_KEY_BIKES] objectAtIndex:i] objectForKey:JSON_KEY_BIKE_IMAGE_SMALL];
                        bikes.brand_id = [[[responseObject objectForKey:JSON_KEY_BIKES] objectAtIndex:i] objectForKey:JSON_KEY_BRAND_ID];
                        bikes.brand_name = [[[responseObject objectForKey:JSON_KEY_BIKES] objectAtIndex:i] objectForKey:JSON_KEY_BRAND_NAME];
                        bikes.cities_id = [[[responseObject objectForKey:JSON_KEY_BIKES] objectAtIndex:i] objectForKey:JSON_KEY_CITIES_ID];
                        
                        
                        bikes.locality = [[[responseObject objectForKey:JSON_KEY_BIKES] objectAtIndex:i] objectForKey:JSON_KEY_LOCALITY];
                        
                        bikes.price = [NSNumber numberWithInteger:[[[[responseObject objectForKey:JSON_KEY_BIKES] objectAtIndex:i] objectForKey:JSON_KEY_PRICE] integerValue]];
                        bikes.bikes_id = [NSNumber numberWithInteger:[[[[responseObject objectForKey:JSON_KEY_BIKES] objectAtIndex:i] objectForKey:JSON_KEY_BIKES_ID] integerValue]];
                        
                        bikes.model_name = [[[responseObject objectForKey:JSON_KEY_BIKES] objectAtIndex:i] objectForKey:JSON_KEY_MODEL_NAME];
                        bikes.security_deposit = [[[responseObject objectForKey:JSON_KEY_BIKES] objectAtIndex:i] objectForKey:JSON_KEY_SECURITY_DEPOSIT];
                        
                        bikes.nearest_location_distance = [NSNumber numberWithFloat:[[[[[[responseObject objectForKey:JSON_KEY_BIKES] objectAtIndex:i] objectForKey:JSON_KEY_LOCALITY]
                                                                                       objectAtIndex:0] objectForKey:JSON_KEY_DISTANCE ] floatValue]];
                        
                    }
                    
                    
                    NSFetchRequest *brandsFilterRequest = [NSFetchRequest fetchRequestWithEntityName:CORE_DATA_ENTITY_BRANDS_FILTER];
                    NSArray *brandsFilter = [appDelegate.managedObjectContext executeFetchRequest:brandsFilterRequest error:nil];
                    for (i = 0; i < [brandsFilter count]; i++){
                        [appDelegate.managedObjectContext deleteObject:[brandsFilter objectAtIndex:i]];
                    }
                    
                    NSFetchRequest *priceFilterRequest = [NSFetchRequest fetchRequestWithEntityName:CORE_DATA_ENTITY_PRICE_FILTER];
                    NSArray *priceFilter = [appDelegate.managedObjectContext executeFetchRequest:priceFilterRequest error:nil];
                    for (i = 0; i < [priceFilter count]; i++){
                        [appDelegate.managedObjectContext deleteObject:[priceFilter objectAtIndex:i]];
                    }
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    //                    NSLog(@"Yahoo";
                    [self performSegueWithIdentifier:@"showBikesSegue" sender:nil];
                }
                else {
                    self.lblInvalidDuration.text = [responseObject objectForKey: JSON_KEY_MESSAGE];
                }
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self showFeedbackWithTitle: NSLocalizedString(@"FAILURE_HANDLER_TITLE", nil) andMessage: NSLocalizedString(@"FAILURE_HANDLER_MESSAGE", nil) andIsError:YES];
                NSLog(@"Failure reason: %@", [error localizedDescription]);
                NSString* errResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
                NSLog(@"%@",errResponse);
                
                NSDictionary *userinfo1 = [[NSDictionary alloc] initWithDictionary:error.userInfo];
                
                if(userinfo1){
                    NSError *innerError = [userinfo1 valueForKey:@"NSUnderlyingError"];
                    if(innerError){
                        NSDictionary *innerUserInfo = [[NSDictionary alloc] initWithDictionary:innerError.userInfo];
                        if(innerUserInfo){
                            if([innerUserInfo objectForKey:AFNetworkingOperationFailingURLResponseDataErrorKey]){
                                NSString *strError = [[NSString alloc] initWithData:[innerUserInfo objectForKey:AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
                                NSLog(@"Error is : %@",strError);
                            }
                        }
                    } else{
                        NSString *errResponse = [[NSString alloc] initWithData:[userinfo1 valueForKey:@"AFNetworkingOperationFailingURLResponseDataErrorKey"] encoding:NSUTF8StringEncoding];
                        
                        if(errResponse){
                            NSLog(@"%@",errResponse);
                        }
                    }
                }
                
                NSLog(@"Response Fail. Error : %@",error.localizedDescription);
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                
            }];
        }
    }
}


- (IBAction)timeChanged:(UIDatePicker *)sender {
    
    if (!self.lblInvalidDuration.hidden){
        self.lblInvalidDuration.hidden = YES;
    }
    if (!self.btnDropTime.enabled){
        self.btnDropTime.enabled = YES;
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setDateFormat:@"dd MMM  h:mm a"];
    
    //    [dateFormatter setDateFormat:@"dd-MM HH:mm"];
    if (isPickupTime){
        pickupDateTime = [dateFormatter stringFromDate:sender.date];
        startDate = sender.date;
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setTimeStyle: NSDateFormatterShortStyle];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        pickupTime = [formatter stringFromDate:sender.date];
    }
    else{
        dropDateTime = [dateFormatter stringFromDate:sender.date];
        endDate = sender.date;
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setTimeStyle: NSDateFormatterShortStyle];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        dropTime = [formatter stringFromDate:sender.date];
    }
    //        self.selectedDateAndTime.text = strDate;
    
    
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"showBikesSegue"]){
        
        WSDisplayBikesViewController *wsdbvc = [segue destinationViewController];
        wsdbvc.pickupLocation = pickupLocation;
        wsdbvc.pickupTime = pickupDateTime;
        wsdbvc.dropTime = dropDateTime;
        
        appDelegate.PICKUP_LOCATION = pickupLocation;
        appDelegate.PICKUP_TIME = pickupDateTime;
        appDelegate.DROP_TIME = dropDateTime;
    }
    
    
}
@end











