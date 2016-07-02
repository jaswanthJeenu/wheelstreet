//
//  AvailableBikesViewController.m
//  Wheelstreet
//
//  Created by Jaswanth Jeenu on 20/06/16.
//  Copyright © 2016 Bashar Technologies Pvt Ltd. All rights reserved.
//

#import "WSFiltersViewController.h"

@interface WSFiltersViewController (){
    int index;
    NSMutableArray *btnStates;
}

@end

@implementation WSFiltersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self.txtCheck.layer setBorderColor:[[[UIColor grayColor] colorWithAlphaComponent:0.5] CGColor]];
//    [self.txtCheck.layer setBorderWidth:2.0];
//    
//    self.txtCheck.layer.cornerRadius = self.txtCheck.frame.size.height/2.0;
//    self.txtCheck.clipsToBounds = YES;
//    
//    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(16.0f, 8.0f, 16.0f, 16.0f)];
//    [imgView setImage:[UIImage imageNamed:@"search.png"]];
//    [self.txtCheck addSubview:imgView];
    
//    [self.txtCheck textRectForBounds:CGRectMake(40.0f, 8.0f, self.txtCheck.frame.size.width - 48.0f, self.txtCheck.frame.size.height - 16.0f)];
    
//    [self.txtCheck setLeftViewMode:UITextFieldViewModeAlways];
//    self.txtCheck.leftView= [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CHECKBOX SELECTED.png"]];
    
    
//    UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CHECKBOX SELECTED.png"]];
//    icon.frame = CGRectMake(50, 50, 10, 10);
//    icon.backgroundColor = [UIColor redColor];
//    [self.view addSubview:icon];
//

    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"status_bar_bg"] forBarMetrics:UIBarMetricsDefault];
    
    
    
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.bounces = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:CORE_DATA_ENTITY_FILTERS];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:JSON_KEY_BRAND_NAME ascending:YES]];
    self.filtersArray = [appDelegate.managedObjectContext executeFetchRequest:request error:nil];
    
    self.viewApply.layer.shadowColor = [UIColor blackColor].CGColor;
    self.viewApply.layer.shadowOffset = CGSizeMake(0, -3);
    self.viewApply.layer.shadowOpacity = 0.1f;
    self.viewApply.layer.shadowRadius = 2.0;
    
    [self.btnLowToHigh setBackgroundImage:[UIImage imageNamed:@"radio off"] forState:UIControlStateNormal];
    [self.btnLowToHigh setBackgroundImage:[UIImage imageNamed:@"radio on"] forState:UIControlStateSelected];
    [self.btnHighToLow setBackgroundImage:[UIImage imageNamed:@"radio off"] forState:UIControlStateNormal];
    [self.btnHighToLow setBackgroundImage:[UIImage imageNamed:@"radio on"] forState:UIControlStateSelected];
    
    
    [self.txtSearchBikes.layer setBorderColor:[[UIColor colorWithRed:206/255.0f green:206/255.0f blue:206/255.0f alpha:1.0f] CGColor]];
    [self.txtSearchBikes.layer setBorderWidth:1.0f];
    
    self.txtSearchBikes.layer.shadowColor = [UIColor blackColor].CGColor;
    self.txtSearchBikes.layer.shadowOffset = CGSizeMake(0, -3);
    self.txtSearchBikes.layer.shadowOpacity = 0.1f;
    self.txtSearchBikes.layer.shadowRadius = 2.0;
    
    NSFetchRequest *brandsFilterRequest = [NSFetchRequest fetchRequestWithEntityName:CORE_DATA_ENTITY_BRANDS_FILTER];
    NSFetchRequest *priceFilterRequest = [NSFetchRequest fetchRequestWithEntityName:CORE_DATA_ENTITY_PRICE_FILTER];
    self.brandsFilterArray = [[NSMutableArray alloc] init];
    self.priceFilterArray = [[NSMutableArray alloc] init];
    self.brandsFilterArray = [[appDelegate.managedObjectContext executeFetchRequest:brandsFilterRequest error:nil] mutableCopy];
    self.priceFilterArray = [[appDelegate.managedObjectContext executeFetchRequest:priceFilterRequest error:nil] mutableCopy];
    
    btnStates = [[NSMutableArray alloc] init];
    int i;
    btnStates[0] = [NSNumber numberWithBool:YES];
    for (i=1; i<[self.filtersArray count] + 1; i++){
        btnStates[i] = [NSNumber numberWithBool:NO];
    }

    
    if (([self.brandsFilterArray count] == nil)     // Here we can't use if (self.filtersArray == nil){ coz if you print and see it in debugger it won't be nil. It has the address of a nil array
        && ([self.priceFilterArray count] == nil)){
        
        [self.btnLowToHigh setSelected:NO];
        [self.btnHighToLow setSelected:NO];
        
    }
    
    else{
        
        if ([self.priceFilterArray count] != nil){
        
            PriceFilter *priceFilter = self.priceFilterArray[0];
        
            if ([priceFilter.low_to_high isEqual:[NSNumber numberWithBool:YES]]){
            
                [self.btnLowToHigh setSelected:YES];
                [self.btnHighToLow setSelected:NO];
            
            }
            else{
            
                [self.btnHighToLow setSelected:YES];
                [self.btnLowToHigh setSelected:NO];
            
            }
        
        }
        
        if ([self.brandsFilterArray count] != nil){
            
            int i,j;
            
            btnStates[0] = [NSNumber numberWithBool:NO];
            
            for (i = 0; i < [self.brandsFilterArray count]; i++){
                
                BrandsFilter *brandsFilter = [self.brandsFilterArray objectAtIndex:i];
                j = 0;
                while (j < [self.filtersArray count]){
                    if ([[[self.filtersArray objectAtIndex:j] brand_id] isEqualToString:brandsFilter.brand_id]){
                        
                        btnStates[j + 1] = [NSNumber numberWithBool:YES];
                        break;
                        
                    }
                    j++;
                }
                
            }
            
        }
    
        
    }
}




    
    
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.filtersArray.count + 1;
}


- (WSFiltersTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
//    UITableViewCell *cell = nil;
//    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"filter"] ;
//    
////    for (UIView* b in [cell subviews]){
////        [b removeFromSuperview];
////    }
//    
//    UIButton *checkboxBtn1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    checkboxBtn1.frame = CGRectMake(cell.frame.origin.x + 20.0f, cell.frame.origin.y + 14.0f, 16.0f, 16.0f);
////    [checkboxBtn1 setBackgroundImage:[UIImage imageNamed:@"Checkbox unselected"] forState:UIControlStateNormal];
//    [checkboxBtn1 addTarget:self action:@selector(cellBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [checkboxBtn1 setBackgroundImage:[UIImage imageNamed:@"CHECKBOX SELECTED"] forState:UIControlStateSelected];
//    [checkboxBtn1 setBackgroundImage:[UIImage imageNamed:@"Checkbox unselected"] forState:UIControlStateNormal];
//    [checkboxBtn1 setSelected:[[btnStates objectAtIndex:indexPath.row] boolValue]];
////    NSLog(@"bool is %@",(BOOL)[btnStates objectAtIndex:indexPath.row]);
////    NSLog(@"bool is: %u",[[btnStates objectAtIndex:0] boolValue]);         Note here it is not %@ but %u. It is the placeholder for BOOL.
//    checkboxBtn1.tag = indexPath.row;
//    [cell addSubview:checkboxBtn1];
//    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];             // This is to disable color changes when the user selects a particular row
    
//    UILabel *lblBrand = [[UILabel alloc] initWithFrame:CGRectMake(cell.frame.origin.x + 44.0f, cell.frame.origin.y + 8.0f, cell.frame.size.width - 64.0f, cell.frame.size.height - 16.0f)];
//    [cell addSubview:lblBrand];
//    [lblBrand setText:brand];
//    [lblBrand setFont:[UIFont systemFontOfSize:12.0f]];

    
    WSFiltersTableViewCell *cell = [[WSFiltersTableViewCell alloc] init];
    cell = [self.tableView dequeueReusableCellWithIdentifier:@"filter"];
    
    NSString *brand;
    
    if (indexPath.row == 0){
        brand = @"All bikes";
        [cell.btnCheckBox setSelected:[btnStates[indexPath.row] boolValue]];
    }
    else{
        Filters *brandName = [self.filtersArray objectAtIndex:indexPath.row - 1];
        brand = brandName.brand_name;
        [cell.btnCheckBox setSelected:[btnStates[indexPath.row] boolValue]];
    }
    
    [cell.btnCheckBox setSelected:[[btnStates objectAtIndex:indexPath.row] boolValue]];
//    NSLog(@"bool is %@",(BOOL)[btnStates objectAtIndex:indexPath.row]);
//    NSLog(@"bool is: %u",[[btnStates objectAtIndex:0] boolValue]);         Note here it is not %@ but %u. It is the placeholder for BOOL.
    cell.btnCheckBox.tag = indexPath.row;
    [cell.btnCheckBox addTarget:self action:@selector(cellBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btnCheckBox setBackgroundImage:[UIImage imageNamed:@"Checkbox unselected"] forState:UIControlStateNormal];
    [cell.btnCheckBox setBackgroundImage:[UIImage imageNamed:@"CHECKBOX SELECTED"] forState:UIControlStateSelected];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];   // This is for disabling the cell selection. If you set the user interaction enabled property to NO, then even the btn won't work
    
    [cell.lblBrandName setText:brand];
    
    return cell;
    
}



//- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    index = (int)indexPath.row;
//    [self performSegueWithIdentifier:@"showEmployeeDetailsSegue" sender:nil];
//}



-(void)cellBtnClicked:(UIButton*)sender{
    
    if (sender.tag != 0){
        
        btnStates[sender.tag] = [NSNumber numberWithBool:![sender isSelected]];
        int i = 1;
        while(i < [self.filtersArray count]+1){
            if ([btnStates[i-1] isEqual:[NSNumber numberWithBool:YES]]){
                break;
            }
            i++;
        }
        
        if (i == [self.filtersArray count]+1){
            btnStates[0] = [NSNumber numberWithBool:YES];
        }
        
        else{
            btnStates[0] = [NSNumber numberWithBool:NO];
        }
        
    }
    
    else{
        if ([btnStates[0] isEqual:[NSNumber numberWithBool:NO]]){
            btnStates[0] = [NSNumber numberWithBool:YES];
            int i;
            for (i =1; i < [self.filtersArray count]+1; i++){
                btnStates[i] = [NSNumber numberWithBool:NO];
            }
        }
        else{
            btnStates[0] = [NSNumber numberWithBool:NO];
        }
    }
    
    [self.tableView reloadData];
    
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



- (IBAction)btnLowToHighClicked:(id)sender {
    [self.btnLowToHigh setSelected:![self.btnLowToHigh isSelected]];
    if ([self.btnHighToLow isSelected]
        && [self.btnLowToHigh isSelected]){
        [self.btnHighToLow setSelected:NO];
    }
}

- (IBAction)btnHighToLowClicked:(id)sender {
    [self.btnHighToLow setSelected:![self.btnHighToLow isSelected]];
    if ([self.btnHighToLow isSelected]
        && [self.btnLowToHigh isSelected]){
        [self.btnLowToHigh setSelected:NO];
    }
}



- (IBAction)btnApplyClicked:(id)sender {
    
    NSFetchRequest *brandsFilterRequest = [NSFetchRequest fetchRequestWithEntityName:CORE_DATA_ENTITY_BRANDS_FILTER];
    NSArray *brandsFilter = [appDelegate.managedObjectContext executeFetchRequest:brandsFilterRequest error:nil];
    int i;
    for (i = 0; i < [brandsFilter count]; i++){
        [appDelegate.managedObjectContext deleteObject:[brandsFilter objectAtIndex:i]];
    }
    
    NSFetchRequest *priceFilterRequest = [NSFetchRequest fetchRequestWithEntityName:CORE_DATA_ENTITY_PRICE_FILTER];
    NSArray *priceFilter = [appDelegate.managedObjectContext executeFetchRequest:priceFilterRequest error:nil];
    for (i = 0; i < [priceFilter count]; i++){
        [appDelegate.managedObjectContext deleteObject:[priceFilter objectAtIndex:i]];
    }
    
    if ([self.btnHighToLow isSelected]){
        
        PriceFilter *priceFilter = [NSEntityDescription insertNewObjectForEntityForName:CORE_DATA_ENTITY_PRICE_FILTER inManagedObjectContext:appDelegate.managedObjectContext];
        priceFilter.high_to_low = [NSNumber numberWithBool:YES];
        priceFilter.low_to_high = [NSNumber numberWithBool:NO];
        
    }
    
    else if ([self.btnLowToHigh isSelected]){
        
        PriceFilter *priceFilter = [NSEntityDescription insertNewObjectForEntityForName:CORE_DATA_ENTITY_PRICE_FILTER inManagedObjectContext:appDelegate.managedObjectContext];
        priceFilter.low_to_high = [NSNumber numberWithBool:YES];
        priceFilter.high_to_low = [NSNumber numberWithBool:NO];

    }
    
    if (btnStates[0] == [NSNumber numberWithBool:NO]){
        
        while (i < [btnStates count]) {
            if (btnStates[i] == [NSNumber numberWithBool:YES]) break;
            i++;
        }
        if (i != [btnStates count]){
           
            for (i = 1; i < [btnStates count]; i++){
                
                if (btnStates[i] == [NSNumber numberWithBool:YES]){
                    
                    BrandsFilter *brandsFilter = [NSEntityDescription insertNewObjectForEntityForName:CORE_DATA_ENTITY_BRANDS_FILTER inManagedObjectContext:appDelegate.managedObjectContext];
                    brandsFilter.brand_id = [[self.filtersArray objectAtIndex:i - 1] brand_id];
                    brandsFilter.brand_name = [[self.filtersArray objectAtIndex:i - 1] brand_name];
                    
                }
            }
        }
    }
    
    [self performSegueWithIdentifier:@"showBikesWithFiltersSegue" sender:nil];
    
}

- (IBAction)btnBackClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
















@end
