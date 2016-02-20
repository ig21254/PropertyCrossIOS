//
//  Favorite+CoreDataProperties.h
//  PropertyCross
//
//  Created by Master on 20/2/16.
//  Copyright © 2016 La Salle Master. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Favorite.h"

NS_ASSUME_NONNULL_BEGIN

@interface Favorite (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *alquiler;
@property (nullable, nonatomic, retain) NSString *titulo;
@property (nullable, nonatomic, retain) NSNumber *latitud;
@property (nullable, nonatomic, retain) NSNumber *longitud;
@property (nullable, nonatomic, retain) NSNumber *metros;
@property (nullable, nonatomic, retain) NSNumber *precio;
@property (nullable, nonatomic, retain) NSString *ciudad;
@property (nullable, nonatomic, retain) NSString *descripcion;

@end

NS_ASSUME_NONNULL_END
