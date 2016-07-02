//
//  WSDisplayBikesViewController.m
//  Wheelstreet
//
//  Created by Jaswanth Jeenu on 24/06/16.
//  Copyright © 2016 Bashar Technologies Pvt Ltd. All rights reserved.
//

#import "WSDisplayBikesViewController.h"

@interface WSDisplayBikesViewController (){
    
    Bikes *bikeChosen;
    NSMutableArray *locationsArray;
    BOOL isPriceLowToHigh;
    
}

@end

@implementation WSDisplayBikesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.navigationController presentTransparentNavigationBar];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"status_bar_bg"] forBarMetrics:UIBarMetricsDefault];
    
// Use the commented out method below when you have to change the title of a navigation bar with only 1 bar button item
//=====================================================================================================================
    
//    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
//    titleLabel.backgroundColor = [UIColor clearColor];
//    titleLabel.textColor = [UIColor whiteColor];
//    titleLabel.font = [UIFont boldSystemFontOfSize:20];
//    titleLabel.text = @"Your Titledvhdiuiuf;kvhjcbvijkhcviufshvjcbjvkbcj bcx uoch bjc bcub ucxb xc";
//    [titleLabel sizeToFit];
    
//    UILabel *subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 22, 0, 0)];
//    subTitleLabel.backgroundColor = [UIColor clearColor];
//    subTitleLabel.textColor = [UIColor whiteColor];
//    subTitleLabel.font = [UIFont systemFontOfSize:12];
//    subTitleLabel.text = @"Your subtitlevcjv bcuivh iuchv uihfivj bc ncjkbmcnkjcbviuhdsfjvnckn jkcbnvu uocvhoucvbn";
//    [subTitleLabel sizeToFit];
//    
//    UIView *twoLineTitleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 60.0f, 30)];
//    [twoLineTitleView addSubview:titleLabel];
//    [twoLineTitleView addSubview:subTitleLabel];
//    
//    float widthDiff = subTitleLabel.frame.size.width - titleLabel.frame.size.width;
//    
//    if (widthDiff > 0) {
//        CGRect frame = titleLabel.frame;
//        frame.origin.x = widthDiff / 2;
//        titleLabel.frame = CGRectIntegral(frame);
//    }else{
//        CGRect frame = subTitleLabel.frame;
//        frame.origin.x = fabsf(widthDiff) / 2;
//        subTitleLabel.frame = CGRectIntegral(frame);
//    }
//    
//    self.navigationItem.titleView = twoLineTitleView;
    
//=====================================================================================================================

    
    CGRect frame = self.navigationController.navigationBar.frame;
    
    UIView *twoLineTitleView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetWidth(frame), 0, CGRectGetWidth(frame), CGRectGetHeight(frame))];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 8, CGRectGetWidth(frame), 14)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    titleLabel.textAlignment = UITextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = appDelegate.PICKUP_LOCATION;
    [titleLabel setFont:[UIFont systemFontOfSize:12.0f]];
    [twoLineTitleView addSubview:titleLabel];
    
    UILabel *subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 23, CGRectGetWidth(frame), 14)];
    subTitleLabel.backgroundColor = [UIColor clearColor];
    subTitleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    subTitleLabel.textAlignment = UITextAlignmentLeft;
    subTitleLabel.textColor = [UIColor colorWithRed:154/255.0f green:154/255.0f blue:154/255.0f alpha:1.0f];
    subTitleLabel.text = [NSString stringWithFormat:@"%@ to %@", appDelegate.PICKUP_TIME, appDelegate.DROP_TIME];
    [subTitleLabel setFont:[UIFont systemFontOfSize:10.0f]];
    [twoLineTitleView addSubview:subTitleLabel];
    
    self.navigationItem.titleView = twoLineTitleView;
    self.tableDisplay.delegate =self;
    self.tableDisplay.dataSource =self;
    self.tableDisplay.separatorColor = [UIColor clearColor];
    
    
        
//    NSNotificationCenter *notify = [NSNotificationCenter defaultCenter];
//    NSNumber *tag;
//    [notify addObserver:self selector:@selector(seeLocations:) name:@"revealHomeScreen" object:tag];
//

    locationsArray = [[NSMutableArray alloc] init];
    
    self.viewBtnCart.layer.shadowColor = [UIColor blackColor].CGColor;
    self.viewBtnCart.layer.shadowOffset = CGSizeMake(0, -3);
    self.viewBtnCart.layer.shadowOpacity = 0.1f;
    self.viewBtnCart.layer.shadowRadius = 2.0;
    
    [self.txtSearchBikes.layer setBorderColor:[[UIColor colorWithRed:232/255.0f green:232/255.0f blue:232/255.0f alpha:1.0f] CGColor]];
    [self.txtSearchBikes.layer setBorderWidth:0.0f];
    
    self.txtSearchBikes.layer.shadowColor = [UIColor blackColor].CGColor;
    self.txtSearchBikes.layer.shadowOffset = CGSizeMake(0, -3);
    self.txtSearchBikes.layer.shadowOpacity = 0.1f;
    self.txtSearchBikes.layer.shadowRadius = 2.0;
    
    self.tableDisplay.bounces = NO;  // This is to prevent scrolling after the last cell or before top cell(Eg: Refreshing in FB messenger
    self.tableDisplay.showsVerticalScrollIndicator = NO;  // This is to hide the scroll indicator which appears on the right when scrolling. It is a property of UIScrollView and it works also
                                                          //for UITableView coz UITableView inherits from UIScrollView
    [self.tableDisplay setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];   // This is for avoiding the extra lines for empty cells in the table view

    
    NSFetchRequest *brandsFilterRequest = [NSFetchRequest fetchRequestWithEntityName:CORE_DATA_ENTITY_BRANDS_FILTER];
    NSFetchRequest *priceFilterRequest = [NSFetchRequest fetchRequestWithEntityName:CORE_DATA_ENTITY_PRICE_FILTER];
    self.brandsFilterArray = [[NSMutableArray alloc] init];
    self.priceFilterArray = [[NSMutableArray alloc] init];
    self.brandsFilterArray = [[appDelegate.managedObjectContext executeFetchRequest:brandsFilterRequest error:nil] mutableCopy];
    self.priceFilterArray = [[appDelegate.managedObjectContext executeFetchRequest:priceFilterRequest error:nil] mutableCopy];
    
    if (([self.brandsFilterArray count] == nil)     // Here we can't use if (self.filtersArray == nil){ coz if you print and see it in debugger it won't be nil. It has the address of a nil array
        && ([self.priceFilterArray count] == nil)){
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:CORE_DATA_ENTITY_BIKES];
        request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:CORE_DATA_ENTITY_BIKES_ATTRIBUTE_NEAREST_LOCATION_DISTANCE ascending:YES]];
        self.bikesArray = [[appDelegate.managedObjectContext executeFetchRequest:request error:nil] mutableCopy];
    }

    else {
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:CORE_DATA_ENTITY_BIKES];
        
        if ([self.priceFilterArray count] != nil){
        
        PriceFilter *priceFilter = self.priceFilterArray[0];
        
//        NSLog(@"%@", priceFilter.low_to_high);
//        NSLog(@"%i", [priceFilter.low_to_high isEqual:[NSNumber numberWithBool:YES]]);
            if ([priceFilter.low_to_high isEqual:[NSNumber numberWithBool:YES]]){
    
                isPriceLowToHigh = YES;
                
            }
            else{
    
                isPriceLowToHigh = NO;
                
            }
        }
            
        if ([self.brandsFilterArray count] != nil){
            
            NSMutableArray *predicateArray = [[NSMutableArray alloc] init];
            int i;
            for (i = 0; i < [self.brandsFilterArray count]; i++){
                    
                NSPredicate *brandIdPredicate = [NSPredicate predicateWithFormat:@"brand_id = %@",[[self.brandsFilterArray objectAtIndex:i] brand_id]];
                [predicateArray insertObject:brandIdPredicate atIndex:i];
                
            }
            NSPredicate *compoundPredicate = [NSCompoundPredicate orPredicateWithSubpredicates:predicateArray];
            
            request.predicate = compoundPredicate;

        }
        
        if (isPriceLowToHigh == YES){
            request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:CORE_DATA_ENTITY_BIKES_ATTRIBUTE_PRICE ascending:YES]];
        }
        else{
            request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:CORE_DATA_ENTITY_BIKES_ATTRIBUTE_PRICE ascending:NO]];
        }
        
        self.bikesArray = [[appDelegate.managedObjectContext executeFetchRequest:request error:nil] mutableCopy];    //mutableCopy is used to convert a NSArray to NSMutableArray
        
    }
 
    
}


//-(void)viewWillAppear:(BOOL)animated{
//    
//    NSFetchRequest *brandsFilterRequest = [NSFetchRequest fetchRequestWithEntityName:@"BrandsFilter"];
//    NSFetchRequest *priceFilterRequest = [NSFetchRequest fetchRequestWithEntityName:@"PriceFilter"];
//    self.brandsFilterArray = [[NSMutableArray alloc] init];
//    self.priceFilterArray = [[NSMutableArray alloc] init];
//    self.brandsFilterArray = [[appDelegate.managedObjectContext executeFetchRequest:brandsFilterRequest error:nil] mutableCopy];
//    self.priceFilterArray = [[appDelegate.managedObjectContext executeFetchRequest:priceFilterRequest error:nil] mutableCopy];
//    
//    if (([self.brandsFilterArray count] == nil)     // Here we can't use if (self.filtersArray == nil){ coz if you print and see it in debugger it won't be nil. It has the address of a nil array
//        && ([self.priceFilterArray count] == nil)){
//        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Bikes"];
//        //        request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"brand_name" ascending:YES]];
//        self.bikesArray = [[appDelegate.managedObjectContext executeFetchRequest:request error:nil] mutableCopy];
//    }
//    
//    else if (([self.brandsFilterArray count] == nil)
//             && ([self.priceFilterArray count] != nil)){
//        
//        NSFetchRequest *priceFilterRequest = [NSFetchRequest fetchRequestWithEntityName:@"PriceFilter"];
//        NSArray *priceFilterArray = [appDelegate.managedObjectContext executeFetchRequest:priceFilterRequest error:nil];
//        PriceFilter *priceFilter = priceFilterArray[0];
//        if (priceFilter.low_to_high == [NSNumber numberWithBool:YES]){
//            
//            NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Bikes"];
//            request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"price" ascending:YES]];
//            self.bikesArray = [[appDelegate.managedObjectContext executeFetchRequest:request error:nil] mutableCopy];
//            
//        }
//        else{
//            
//            NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Bikes"];
//            request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"price" ascending:NO]];
//            self.bikesArray = [[appDelegate.managedObjectContext executeFetchRequest:request error:nil] mutableCopy];
//            
//        }
//        
//    }
//    
//
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.bikesArray count];
}


- (WSBikeDisplayTableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    WSBikeDisplayTableViewCell *cell = [[WSBikeDisplayTableViewCell alloc] init];
    cell = [self.tableDisplay dequeueReusableCellWithIdentifier:@"bike"];
    
    
    
    Bikes *bike = [self.bikesArray objectAtIndex:(int)indexPath.row];
    NSString *bikeImageString = bike.bike_image;
    NSURL *bikeImageURL = [NSURL URLWithString:bikeImageString];
    cell.imgBike.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:bikeImageURL]];
    [cell.btnCheckLocations addTarget:self action:@selector(btnSeeLocationsClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.lblBrandName setText:bike.brand_name];
    [cell.lblModelName setText:bike.model_name];
    [cell.lblRentAmount setText:[NSString stringWithFormat:@"Rs %@/hr", bike.price]];
    [cell.lblDepositAmount setText:[NSString stringWithFormat:@"Rs %@/bike", bike.security_deposit]];
    [cell.btnCheckLocations setTag:indexPath.row];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
    
}






-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{   // This method doesn't get called when the segue is action segue.
    
    if ([segue.identifier isEqualToString:@"showLocationsSegue"]){
        
        WSLocationsViewController *wslvc = [segue destinationViewController];
        wslvc.bikeChosen = bikeChosen;
        wslvc.locationsArray = locationsArray;
        
    }
    
}


//-(void)seeLocations:(NSNotificationCenter*) notification{
//    
//    if (notificatio isEqualToString:@"seeLocations"])
//    {
//        NSDictionary* userInfo = (NSDictionary*)notification.object;
//        NSNumber* total = (NSNumber*)userInfo[@"total"];
//        NSLog (@"Successfully received test notification! %i", total.intValue);
//    }
//}
//
//


-(void)btnSeeLocationsClicked:(UIButton*) sender{
    
    bikeChosen = [self.bikesArray objectAtIndex:sender.tag];
    locationsArray = bikeChosen.locality;
    [self performSegueWithIdentifier:@"showLocationsSegue" sender:nil];
    [[[self.tableDisplay cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]] btnCheckLocations] setBackgroundImage:[UIImage imageNamed:@"Checkbox unselected"] forState:UIControlStateNormal];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



- (IBAction)btnBackClicked:(id)sender {
    
    NSFetchRequest *bikesRequest = [NSFetchRequest fetchRequestWithEntityName:CORE_DATA_ENTITY_BIKES];
    NSArray *bikes = [appDelegate.managedObjectContext executeFetchRequest:bikesRequest error:nil];
    int i;
    for (i = 0; i < [bikes count]; i++){
        [appDelegate.managedObjectContext deleteObject:[bikes objectAtIndex:i]];
    }
    
    NSFetchRequest *filtersRequest = [NSFetchRequest fetchRequestWithEntityName:CORE_DATA_ENTITY_FILTERS];
    NSArray *filters = [appDelegate.managedObjectContext executeFetchRequest:filtersRequest error:nil];
    for (i = 0; i < [filters count]; i++){
        [appDelegate.managedObjectContext deleteObject:[filters objectAtIndex:i]];
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

    
    [appDelegate.managedObjectContext save:nil];

    
    [self.navigationController popToRootViewControllerAnimated:YES];
}



@end
