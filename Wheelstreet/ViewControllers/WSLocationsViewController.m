//
//  WSLocationsViewController.m
//  Wheelstreet
//
//  Created by Jaswanth Jeenu on 27/06/16.
//  Copyright © 2016 Bashar Technologies Pvt Ltd. All rights reserved.
//

#import "WSLocationsViewController.h"

@interface WSLocationsViewController (){
    
    NSMutableArray *countArray;
    NSMutableArray *bikesQuantityArray;
    
}

@end

@implementation WSLocationsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableLocations.delegate = self;
    self.tableLocations.dataSource = self;
    
    self.tableLocations.showsVerticalScrollIndicator = NO;    // This is to hide the scroll indicator which appears on the right when scrolling. It is a property of UIScrollView and it works also
                                                              //for UITableView coz UITableView inherits from UIScrollView
    
    self.tableLocations.bounces = NO;
    
    [self.tableLocations setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];   // This is for avoiding the extra lines for empty cells in the table view
    
    self.viewBtnDone.layer.shadowColor = [UIColor blackColor].CGColor;
    self.viewBtnDone.layer.shadowOffset = CGSizeMake(0, -3);
    self.viewBtnDone.layer.shadowOpacity = 0.1f;
    self.viewBtnDone.layer.shadowRadius = 2.0;
    
    countArray = [[NSMutableArray alloc] initWithCapacity:[self.locationsArray count]];
    int i;
    for (i = 0; i < [self.locationsArray count]; i++){
        countArray[i] = [NSNumber numberWithInt:0];
    }
    
    bikesQuantityArray = [[NSMutableArray alloc] init];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.locationsArray count];
}

-(WSBikeLocationsTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WSBikeLocationsTableViewCell *cell = [WSBikeLocationsTableViewCell alloc];
    cell = [self.tableLocations dequeueReusableCellWithIdentifier:@"location"];
    
    
//    [cell.lblLocationName setText:[[self.locationsArray objectAtIndex:indexPath.row] stringForKey:JSON_KEY_LOCATION]];
    
    
//    NSLog(@"%ld", (long)indexPath.row);
    
//    NSNumber *numberOfBikes = [[self.locationsArray objectAtIndex:indexPath.row] objectForKey:JSON_KEY_QUANTITY];  // Notice that these quanitites in the response object are numbers, not strings
//    NSNumber *locationDistance = [[self.locationsArray objectAtIndex:indexPath.row] objectForKey:JSON_KEY_DISTANCE];
    
//    NSString *bikesQuantity = [numberOfBikes stringValue];
//    NSString *distance = [locationDistance stringValue];
//    [cell.lblLocationDistance setText:[NSString stringWithFormat:@"%@ km away", locationDistance]];
    
    bikesQuantityArray[indexPath.row] = [[self.locationsArray objectAtIndex:indexPath.row] objectForKey:JSON_KEY_QUANTITY];
    
    NSString *locationDistance = [[self.locationsArray objectAtIndex:indexPath.row] objectForKey:JSON_KEY_DISTANCE];
    NSString *locationName = [[self.locationsArray objectAtIndex:indexPath.row] objectForKey:JSON_KEY_LOCATION];
    
    [cell.lblLocationName setText:locationName];
    
    
    if ([[bikesQuantityArray objectAtIndex:indexPath.row] integerValue] == 0) {
        [cell.lblBikesQuantity setText:[NSString stringWithFormat:@"No bikes available"]];
    }
    else if ([[bikesQuantityArray objectAtIndex:indexPath.row] integerValue] == 1){
        [cell.lblBikesQuantity setText:[NSString stringWithFormat:@"%@ bike available", [bikesQuantityArray objectAtIndex:indexPath.row]]];
    }
    else{
        [cell.lblBikesQuantity setText:[NSString stringWithFormat:@"%@ bikes available", [bikesQuantityArray objectAtIndex:indexPath.row]]];
    }
    
    
    [cell.lblLocationDistance setText:[NSString stringWithFormat:@"%@ km away", locationDistance]];
    
    [cell.btnDecreaseCount addTarget:self action:@selector(btnDecreaseCountClicked:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btnIncreaseCount addTarget:self action:@selector(btnIncreaseCountClicked:) forControlEvents:UIControlEventTouchUpInside];
    cell.btnIncreaseCount.tag = indexPath.row;
    cell.btnDecreaseCount.tag = indexPath.row;
    
    NSFetchRequest *bookedBikesQuantityRequest = [NSFetchRequest fetchRequestWithEntityName:CORE_DATA_ENTITY_BOOKINGS];
    NSPredicate *dealerBikeIdPredicate = [NSPredicate predicateWithFormat:@"dealer_bike_id = %@", [[self.locationsArray objectAtIndex:indexPath.row]
                                                                                                                                          objectForKey:JSON_KEY_DEALER_BIKE_ID]];
    bookedBikesQuantityRequest.predicate = dealerBikeIdPredicate;
    
    NSMutableArray *bookedBikesQuantityArray = [[NSMutableArray alloc] init];
    bookedBikesQuantityArray = [[appDelegate.managedObjectContext executeFetchRequest:bookedBikesQuantityRequest error:nil] mutableCopy];
    
    if ([bookedBikesQuantityArray count] != nil){
        
        countArray[indexPath.row] = [[bookedBikesQuantityArray objectAtIndex:0] quantity];
        
    }
    
    [cell.lblCountDisplay setText:[NSString stringWithFormat:@"%li", (long)[countArray[indexPath.row] integerValue]]];
    
    if ([countArray[indexPath.row] integerValue] == 0){
        [cell.btnDecreaseCount setEnabled:NO];
    }
    else{
        [cell.btnDecreaseCount setEnabled:YES];
    }
    if ([countArray[indexPath.row] integerValue] == [[bikesQuantityArray objectAtIndex:indexPath.row] integerValue]){
        [cell.btnIncreaseCount setEnabled:NO];
    }
    else{
        [cell.btnIncreaseCount setEnabled:YES];
    }

    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}

-(void)btnDecreaseCountClicked:(UIButton*) sender{
    
    if ([countArray[sender.tag] integerValue] > 0){
        countArray[sender.tag] = [NSNumber numberWithInteger:(([countArray[sender.tag] integerValue]) - 1)];
    }
    
    [self.tableLocations reloadData];
}


-(void)btnIncreaseCountClicked:(UIButton*) sender{
 
    if ([countArray[sender.tag] integerValue] < [[bikesQuantityArray objectAtIndex:sender.tag] integerValue]){
        countArray[sender.tag] = [NSNumber numberWithInteger:[countArray[sender.tag] integerValue] + 1];
    }
    
    [self.tableLocations reloadData];
}


- (IBAction)btnDoneClicked:(id)sender {
    
    int i;
    while (i < [self.locationsArray count]) {
        
        if (countArray[i] != 0) break;
        
    }
    
    if (i == [self.locationsArray count]){
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    else{
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:CORE_DATA_ENTITY_BOOKINGS];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"bike_id = %ld", [self.bikeChosen.bikes_id integerValue]];
        request.predicate = predicate;
        NSArray *previousBookings = [appDelegate.managedObjectContext executeFetchRequest:request error:nil];
        
        if ([previousBookings count] != nil){
            
            for (i = 0; i < [previousBookings count]; i++){
                
                [appDelegate.managedObjectContext deleteObject:[previousBookings objectAtIndex:i]];
                
            }
            
        }
        
        for (i = 0; i < [self.locationsArray count]; i++){

            if (!(BOOL)[countArray[i] isEqual:[NSNumber numberWithInteger:0]]){ // Be careful,we can't write if (countArray[i]!=0) since they are objects. Keep checking in debugger for right format
                
                Bookings *bookings = [NSEntityDescription insertNewObjectForEntityForName:CORE_DATA_ENTITY_BOOKINGS inManagedObjectContext:appDelegate.managedObjectContext];
                
                bookings.quantity = [countArray objectAtIndex:i];
                
                bookings.bike_id = self.bikeChosen.bikes_id;
                bookings.brand_name = self.bikeChosen.brand_name;
                bookings.model_name = self.bikeChosen.model_name;
                bookings.bike_image_small = self.bikeChosen.bike_image_small;
                
                bookings.dealer_bike_id = [[self.locationsArray objectAtIndex:i] objectForKey:JSON_KEY_DEALER_BIKE_ID];
                bookings.location_name = [[self.locationsArray objectAtIndex:i] objectForKey:JSON_KEY_LOCATION];
                bookings.locality_id = [[self.locationsArray objectAtIndex:i] objectForKey:JSON_KEY_LOCALITY_ID];
                bookings.rent = [[self.locationsArray objectAtIndex:i] objectForKey:JSON_KEY_PRICE];
                bookings.deposit = [[self.locationsArray objectAtIndex:i] objectForKey:JSON_KEY_SECURITY_DEPOSIT];
                bookings.bikes_quantity_available = [NSNumber numberWithInteger:[[[self.locationsArray objectAtIndex:i] objectForKey:JSON_KEY_QUANTITY] integerValue]];
                bookings.location_distance = [NSNumber numberWithFloat:[[[self.locationsArray objectAtIndex:i] objectForKey:JSON_KEY_DISTANCE] floatValue]];
                
                
            }
            
        }
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }
}
    

- (IBAction)btnBackClicked:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
