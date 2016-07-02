//
//  WSCartTableViewCell.m
//  Wheelstreet
//
//  Created by Jaswanth Jeenu on 30/06/16.
//  Copyright © 2016 Bashar Technologies Pvt Ltd. All rights reserved.
//

#import "WSCartBikeTableViewCell.h"

@implementation WSCartBikeTableViewCell{
    
    NSMutableArray *bikesCountArray;
    int temp;
    
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    self.tableLocation.delegate = self;
    self.tableLocation.dataSource = self;
    
    self.tableLocation.scrollEnabled = NO;
    self.tableLocation.separatorColor = [UIColor clearColor];
    
    bikesCountArray = [[NSMutableArray alloc] init];
    
    temp = 0;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.locationsArray count];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat height = [[NSNumber numberWithInteger:48] doubleValue];
    return height;
    
}

-(WSCartLocationTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WSCartLocationTableViewCell *cell = [WSCartLocationTableViewCell alloc];
    cell = [self.tableLocation dequeueReusableCellWithIdentifier:@"locationBooked"];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    
    if (temp == 0){
        
        int i;
        for (i = 0; i < [self.locationsArray count]; i++){          // We have to populate the bikesCountArray here but not in viewDidLoad or awakeFromNib coz self.locationsArray which is an
            //outlet is not set when awakeFromNib is called.
            
            [bikesCountArray insertObject:[[self.locationsArray objectAtIndex:i] quantity] atIndex:i];
            temp++;
        }
    }
    
    [cell.lblLocationName setText:[[self.locationsArray objectAtIndex:indexPath.row] location_name]];
    [cell.lblLocationDistance setText:[NSString stringWithFormat:@"%@ km away",[[[self.locationsArray objectAtIndex:indexPath.row] location_distance] stringValue]]];
    
    [cell.lblQuantityDisplay setText:[NSString stringWithFormat:@"%li", (long)[[bikesCountArray objectAtIndex:indexPath.row] integerValue]]];
    
    [cell.btnDecreaseCount addTarget:self action:@selector(btnDecreaseCountClicked:) forControlEvents:UIControlEventTouchUpInside];
    cell.btnDecreaseCount.tag = indexPath.row;
    
    
    if ([bikesCountArray[indexPath.row] integerValue] == 0){
        
        [cell.btnDecreaseCount setEnabled:NO];
        
    }
    
    
    
    //    NSFetchRequest *bookedBikesQuantityRequest = [NSFetchRequest fetchRequestWithEntityName:CORE_DATA_ENTITY_BOOKINGS];
    //    NSPredicate *dealerBikeIdPredicate = [NSPredicate predicateWithFormat:@"dealer_bike_id = %@", [[self.locationsArray objectAtIndex:indexPath.row]
    //                                                                                                   objectForKey:JSON_KEY_DEALER_BIKE_ID]];
    //    bookedBikesQuantityRequest.predicate = dealerBikeIdPredicate;
    //
    //    NSMutableArray *bookedBikesQuantityArray = [[NSMutableArray alloc] init];
    //    bookedBikesQuantityArray = [[appDelegate.managedObjectContext executeFetchRequest:bookedBikesQuantityRequest error:nil] mutableCopy];
    //
    //    if ([bookedBikesQuantityArray count] != nil){
    //
    //        countArray[indexPath.row] = [[bookedBikesQuantityArray objectAtIndex:0] quantity];
    //
    //    }
    //
    //    [cell.lblCountDisplay setText:[NSString stringWithFormat:@"%li", (long)[countArray[indexPath.row] integerValue]]];
    //
    //    if ([countArray[indexPath.row] integerValue] == 0){
    //        [cell.btnDecreaseCount setEnabled:NO];
    //    }
    //    else{
    //        [cell.btnDecreaseCount setEnabled:YES];
    //    }
    //    if ([countArray[indexPath.row] integerValue] == [[bikesQuantityArray objectAtIndex:indexPath.row] integerValue]){
    //        [cell.btnIncreaseCount setEnabled:NO];
    //    }
    //    else{
    //        [cell.btnIncreaseCount setEnabled:YES];
    //    }
    //
    
    
    return cell;
}

-(void)btnDecreaseCountClicked:(UIButton*) sender{
    
    if ([bikesCountArray[sender.tag] integerValue] > 0){
        
        bikesCountArray[sender.tag] = [NSNumber numberWithInteger:(([bikesCountArray[sender.tag] integerValue]) - 1)];
        
        Bookings* bookingEdited = [self.locationsArray objectAtIndex:sender.tag];
        bookingEdited.quantity = bikesCountArray[sender.tag];
        
    }
    
    [self.tableLocation reloadData];
}





@end
