//
//  Property.m
//  PropertyCross
//
//  Created by Master on 2/2/16.
//  Copyright © 2016 La Salle Master. All rights reserved.
//

#import "Property.h"
#import "CoreDataManager.h"

@implementation Property

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"alquiler": @"alquiler",
                                                       @"anteriorConsulta": @"anteriorConsulta",
                                                       @"ciudad": @"ciudad",
                                                       @"comentarios": @"comentarios",
                                                       @"cp": @"cp",
                                                       @"descripcion": @"descripcion",
                                                       @"direccion": @"direccion",
                                                       @"emailPropietario": @"emailPropietario",
                                                       @"telefonoPropietario": @"telefonoPropietario",
                                                       @"titulo": @"titulo",
                                                       @"latitud": @"latitud",
                                                       @"longitud": @"longitud",
                                                       @"metros": @"metros",
                                                       @"precio": @"precio",
                                                       @"favorito": @"favorito"
                                                       }];
}


+ (void) storeProperty:(Property * ) property
{
    CoreDataManager * coreDataManager = [CoreDataManager sharedInstance];
    NSManagedObjectContext * context = [coreDataManager managedObjectContext];
    
    NSManagedObject * entity = [NSEntityDescription insertNewObjectForEntityForName:@"Property" inManagedObjectContext:context];
    
    [property initEntity:entity];
    NSDate * timestamp = [NSDate date];
    [entity setValue:timestamp forKey:@"timestamp"];
    property.timestamp = timestamp;
    
    [coreDataManager saveContext];
}


+ (void) deleteFavorite:(Property *) property
{
    CoreDataManager * coreDataManager = [CoreDataManager sharedInstance];
    NSManagedObjectContext * context = [coreDataManager managedObjectContext];
    NSError * error = nil;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Property" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"timestamp == %@", property.timestamp]];
    
    NSArray * results = [context executeFetchRequest:fetchRequest error:&error];
    if ([results count] > 0) {
        [context deleteObject:results[0]];
        
        [coreDataManager saveContext];
    }
    
}


+ (NSMutableArray<Property *> *) getFavorites
{
    CoreDataManager * coreDataManager = [CoreDataManager sharedInstance];
    NSManagedObjectContext * context = [coreDataManager managedObjectContext];
    NSError * error;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Property" inManagedObjectContext:context];
    
    [fetchRequest setEntity:entity];
    //[fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"favorito == 1"]];
    
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    NSMutableArray<Property*> *properties = [[NSMutableArray alloc] init];
    for (NSEntityDescription * e in fetchedObjects) {
        Property * p = [[Property alloc] init];
        p.alquiler = [e valueForKey:@"alquiler"];
        p.ciudad = [e valueForKey:@"ciudad"];
        p.descripcion = [e valueForKey:@"descripcion"];
        p.latitud = [[e valueForKey:@"latitud"] doubleValue];
        p.longitud = [[e valueForKey:@"longitud"] doubleValue];
        p.metros = [[e valueForKey:@"metros"] doubleValue];
        p.precio = [[e valueForKey:@"precio"] doubleValue];
        p.titulo = [e valueForKey:@"titulo"];
        p.favorito = [NSNumber numberWithBool:YES];
        p.timestamp = [e valueForKey:@"timestamp"];
        
        [properties addObject:p];
    }
    
    return properties;
}




- (void) initEntity:(NSManagedObject *) entity
{
    [entity setValue:[NSNumber numberWithBool:self.alquiler] forKey:@"alquiler"];
    [entity setValue:self.ciudad forKey:@"ciudad"];
    [entity setValue:self.descripcion forKey:@"descripcion"];
    [entity setValue:[NSNumber numberWithDouble:self.latitud] forKey:@"latitud"];
    [entity setValue:[NSNumber numberWithDouble:self.longitud] forKey:@"longitud"];
    [entity setValue:[NSNumber numberWithDouble:self.metros] forKey:@"metros"];
    [entity setValue:[NSNumber numberWithDouble:self.precio] forKey:@"precio"];
    [entity setValue:self.titulo forKey:@"titulo"];
}


@end
