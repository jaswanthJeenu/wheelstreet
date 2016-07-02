//
//  PriceFilter+CoreDataProperties.h
//  Wheelstreet
//
//  Created by Jaswanth Jeenu on 29/06/16.
//  Copyright © 2016 Bashar Technologies Pvt Ltd. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "PriceFilter.h"

NS_ASSUME_NONNULL_BEGIN

@interface PriceFilter (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *low_to_high;
@property (nullable, nonatomic, retain) NSNumber *high_to_low;

@end

NS_ASSUME_NONNULL_END
