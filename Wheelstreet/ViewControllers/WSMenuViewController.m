//
//  WSNewMenuViewController.m
//  Wheelstreet
//
//  Created by Jaswanth Jeenu on 01/06/16.
//  Copyright © 2016 Bashar Technologies Pvt Ltd. All rights reserved.
//

#import "WSMenuViewController.h"

@interface WSMenuViewController (){
    NSArray *menu;
    int row;
}

@end

@implementation WSMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    menu = [[NSArray alloc]initWithObjects:@"How it works",@"FAQ",@"Terms and conditions",@"About us",@"Sign out", nil];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return menu.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuse id"];
    NSString *title = [menu objectAtIndex:indexPath.row];
    cell.textLabel.text = title;
    
    // All the below are different methods tried for erasing the seperator lines in table which didn't work'
    
    
    
    //    cell.layer.borderWidth = 0.0f;
    //=========
    
    //    cell.layer.borderColor = [[UIColor whiteColor] CGColor];
    //=========
    
    //    [self.tableView setBackgroundView:nil];
    //    [self.tableView setBackgroundColor:[UIColor clearColor]];
    //=========
    
    //    cell.contentView.backgroundColor = [UIColor clearColor];
    //========
    
    return cell;
    
}

//- (void)tableView:(UITableView *)tableView  willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [cell setBackgroundColor:[UIColor clearColor]];
//}
//


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    row = (int)indexPath.row;
    switch (row) {
        case 0:{
            
            break;
        }
        case 1:{
            
            [self performSegueWithIdentifier:@"showInfoScreenSegue" sender:nil];
            break;
        }
        case 2:{
            
            [self performSegueWithIdentifier:@"showInfoScreenSegue" sender:nil];
            break;
        }
        case 3:{
            [self performSegueWithIdentifier:@"showInfoScreenSegue" sender:nil];
            break;
        }
        case 4:{
            
            NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
            [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
            
            [self showProgressHudWithMessage: NSLocalizedString(@"LOGGING_OUT", nil)];
            [self performSegueWithIdentifier:@"showLoginScreenAfterLogoutSegue" sender:nil];
            break;
            
        }
            
        default:
            break;
    }
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"showInfoScreenSegue"]){
        WSInfoViewController *wsInfoVC = [segue destinationViewController];
        wsInfoVC.index = [NSNumber numberWithInteger:row];
    }
    
    if ([segue.identifier isEqualToString:@"showLoginScreenAfterLogoutSegue"]){
        [self hideProgressHUD];
    }
}









@end
