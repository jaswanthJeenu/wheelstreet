//
//  BrandsFilter+CoreDataProperties.h
//  Wheelstreet
//
//  Created by Jaswanth Jeenu on 29/06/16.
//  Copyright © 2016 Bashar Technologies Pvt Ltd. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "BrandsFilter.h"

NS_ASSUME_NONNULL_BEGIN

@interface BrandsFilter (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *brand_id;
@property (nullable, nonatomic, retain) NSString *brand_name;

@end

NS_ASSUME_NONNULL_END
