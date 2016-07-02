//
//  Bikes+CoreDataProperties.h
//  Wheelstreet
//
//  Created by Jaswanth Jeenu on 30/06/16.
//  Copyright © 2016 Bashar Technologies Pvt Ltd. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Bikes.h"

NS_ASSUME_NONNULL_BEGIN

@interface Bikes (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *bike_image;
@property (nullable, nonatomic, retain) NSString *bike_image_small;
@property (nullable, nonatomic, retain) NSNumber *bikes_id;
@property (nullable, nonatomic, retain) NSString *brand_id;
@property (nullable, nonatomic, retain) NSString *brand_name;
@property (nullable, nonatomic, retain) NSString *cities_id;
@property (nullable, nonatomic, retain) NSString *city;
@property (nullable, nonatomic, retain) id locality;
@property (nullable, nonatomic, retain) NSString *model_name;
@property (nullable, nonatomic, retain) NSNumber *price;
@property (nullable, nonatomic, retain) NSString *security_deposit;
@property (nullable, nonatomic, retain) NSNumber *nearest_location_distance;

@end

NS_ASSUME_NONNULL_END
