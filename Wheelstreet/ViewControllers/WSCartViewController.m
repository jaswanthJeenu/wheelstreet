//
//  WSCartViewController.m
//  Wheelstreet
//
//  Created by Jaswanth Jeenu on 30/06/16.
//  Copyright © 2016 Bashar Technologies Pvt Ltd. All rights reserved.
//

#import "WSCartViewController.h"

@interface WSCartViewController (){
    
    NSMutableArray *bikesArray;
    NSMutableArray *countArray;
    int i, j, m, n, k, count;
    
}

@end

@implementation WSCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableBike.delegate = self;
    self.tableBike.dataSource = self;
    
    self.tableBike.showsVerticalScrollIndicator = NO;
    self.tableBike.bounces = NO;
    [self.tableBike setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]]; 
    
    bikesArray = [[NSMutableArray alloc] init];
    countArray = [[NSMutableArray alloc] init];
    self.bookingsArray = [[NSMutableArray alloc] init];
    
    NSFetchRequest *bookingsRequest = [NSFetchRequest fetchRequestWithEntityName:CORE_DATA_ENTITY_BOOKINGS];
    bookingsRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:CORE_DATA_ENTITY_BOOKINGS_ATTRIBUTE_BIKE_ID ascending:YES]];
    self.bookingsArray = [[appDelegate.managedObjectContext executeFetchRequest:bookingsRequest error:nil] mutableCopy];
    
    for (i =0; i < [self.bookingsArray count]; i++){
        
        if ([[[self.bookingsArray objectAtIndex:i] quantity] isEqual:[NSNumber numberWithInteger:0]]){
            
            [appDelegate.managedObjectContext deleteObject:[self.bookingsArray objectAtIndex:i]];
            
            for (j = i; j < [self.bookingsArray count] - 1; j++){
                
                self.bookingsArray[i] = [self.bookingsArray objectAtIndex:i + 1];
                
            }
            
            [self.bookingsArray removeObject:[self.bookingsArray objectAtIndex:[self.bookingsArray count] - 1]];
            
            
        }
        
        
        
        
        
        
        
    }
    
    
    i = 0;m = 0;j = 0, k = 0;
    while (i < [self.bookingsArray count] - 1){
        
        if ([[[self.bookingsArray objectAtIndex:i] bike_id] isEqual:[[self.bookingsArray objectAtIndex:i + 1] bike_id]]){
            
            count++;
            
        }
        
        else{
            
            [bikesArray insertObject:[self.bookingsArray objectAtIndex:i] atIndex:j];
            count++;
            [countArray insertObject:[NSNumber numberWithInteger:count] atIndex:j];
            count = 0;
            j++;
            
        }
        
        i++;
        
     }
    
    if (i == 0){
        
        [bikesArray insertObject:[self.bookingsArray objectAtIndex:0] atIndex:0];
        [countArray insertObject:[NSNumber numberWithInteger:1] atIndex:0];
        j++;
        
    }
    
    else if (![[[self.bookingsArray objectAtIndex:i] bike_id] isEqual:[[self.bookingsArray objectAtIndex:i -1] bike_id]]){
        
        [bikesArray insertObject:[self.bookingsArray objectAtIndex:i] atIndex:j];
        [countArray insertObject:[NSNumber numberWithInteger:1] atIndex:j];
        j++;
        
    }
    
    else{
        
        [bikesArray insertObject:[self.bookingsArray objectAtIndex:i ] atIndex:j];
        count++;
        [countArray insertObject:[NSNumber numberWithInteger:count] atIndex:j];
        j++;
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


-(WSCartBikeTableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WSCartBikeTableViewCell* cell = [[WSCartBikeTableViewCell alloc] init];
    cell = [self.tableBike dequeueReusableCellWithIdentifier:@"bikeBooked"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    self.tableBike.separatorColor = [UIColor clearColor];
    
//    UIView *greySeperation = [[UIView alloc] initWithFrame:CGRectMake(8.0f, 51.0f, self.tableBike.frame.size.width - 16.0f, 0.5f)];
//    [greySeperation setBackgroundColor:[UIColor colorWithRed:214/255.0f green:214/255.0f blue:214/255.0f alpha:1.0f]];
//    [cell.contentView addSubview:greySeperation];

    Bikes *bikeBooked = [bikesArray objectAtIndex:indexPath.row];
    NSString *bikeImageSmallString = bikeBooked.bike_image_small;
    NSURL *bikeImageSmallURL = [NSURL URLWithString:bikeImageSmallString];
    cell.imgBikeSmall.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:bikeImageSmallURL]];
    
    [cell.lblBikeName setText:[NSString stringWithFormat:@"%@ %@", bikeBooked.brand_name, bikeBooked.model_name]];
//    [cell.lblCashDetails setText:[NSString stringWithFormat:@"Rs. %@ rent. Rs. %@ deposit", [bikeBooked.price stringValue], bikeBooked.security_deposit]];
    
    
    NSMutableArray *locationsArray = [[NSMutableArray alloc] init];
    n = 0;k = 0;
    
    while (m < [self.bookingsArray count] - 1) {
        
        if ([[[self.bookingsArray objectAtIndex:m] bike_id] isEqual:[[self.bookingsArray objectAtIndex:m + 1] bike_id]]){
            
            [locationsArray insertObject:[self.bookingsArray objectAtIndex:m] atIndex:n];
            n++;
            m++;
            
        }
        else{
            
            [locationsArray insertObject:[self.bookingsArray objectAtIndex:m] atIndex:n];
            m++;
            k++;
            break;
    
        }
        
    }
    
    if (m == 0){
        
        [locationsArray insertObject:[self.bookingsArray objectAtIndex:0] atIndex:0];
        m++;
        n++;
        
    }
    
    
    else if ((m == [self.bookingsArray count] - 1)
        && ([[[self.bookingsArray objectAtIndex:m] bike_id] isEqual:[[self.bookingsArray objectAtIndex:m - 1] bike_id]])){
        
        [locationsArray insertObject:[self.bookingsArray objectAtIndex:m] atIndex: n];
        m++;
        n++;
        
    }
    
    else if ((m == [self.bookingsArray count] - 1)
        && (![[[self.bookingsArray objectAtIndex:m] bike_id] isEqual:[[self.bookingsArray objectAtIndex:m - 1] bike_id]])
        && (k == 0)){
        
        [locationsArray insertObject:[self.bookingsArray objectAtIndex:m] atIndex:0];
        m++;
        
    }
    
    cell.locationsArray = locationsArray;
    
    return  cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [bikesArray count];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat height = [[NSNumber numberWithInteger:52] doubleValue] + (48 * [countArray[indexPath.row] doubleValue]) + 8.0f;
    
    return height;
    
}


- (IBAction)btnBackClicked:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)btnBookNowClicked:(id)sender {
    

    
    
}











@end
