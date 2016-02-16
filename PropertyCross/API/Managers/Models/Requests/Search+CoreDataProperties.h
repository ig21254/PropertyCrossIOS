//
//  Search+CoreDataProperties.h
//  PropertyCross
//
//  Created by Master on 16/2/16.
//  Copyright © 2016 La Salle Master. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Search.h"

NS_ASSUME_NONNULL_BEGIN

@interface Search (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *alquiler;
@property (nullable, nonatomic, retain) NSNumber *latitud;
@property (nullable, nonatomic, retain) NSNumber *longitud;
@property (nullable, nonatomic, retain) NSNumber *num_results;
@property (nullable, nonatomic, retain) NSString *query;
@property (nullable, nonatomic, retain) NSNumber *venta;
@property (nullable, nonatomic, retain) NSDate   *timestamp;

@end

NS_ASSUME_NONNULL_END
