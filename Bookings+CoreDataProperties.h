//
//  Bookings+CoreDataProperties.h
//  Wheelstreet
//
//  Created by Jaswanth Jeenu on 30/06/16.
//  Copyright © 2016 Bashar Technologies Pvt Ltd. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Bookings.h"

NS_ASSUME_NONNULL_BEGIN

@interface Bookings (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *user_id;
@property (nullable, nonatomic, retain) NSString *start_date;
@property (nullable, nonatomic, retain) NSString *end_date;
@property (nullable, nonatomic, retain) NSString *dealer_bike_id;
@property (nullable, nonatomic, retain) NSNumber *quantity;
@property (nullable, nonatomic, retain) NSNumber *bike_id;
@property (nullable, nonatomic, retain) NSString *rent;
@property (nullable, nonatomic, retain) NSString *deposit;
@property (nullable, nonatomic, retain) NSString *bike_image_small;
@property (nullable, nonatomic, retain) NSString *location_name;
@property (nullable, nonatomic, retain) NSString *brand_name;
@property (nullable, nonatomic, retain) NSString *model_name;
@property (nullable, nonatomic, retain) NSNumber *location_distance;
@property (nullable, nonatomic, retain) NSNumber *bikes_quantity_available;
@property (nullable, nonatomic, retain) NSString *locality_id;

@end

NS_ASSUME_NONNULL_END
