//
//  Favorite.m
//  PropertyCross
//
//  Created by Master on 20/2/16.
//  Copyright © 2016 La Salle Master. All rights reserved.
//

#import "Favorite.h"
#import "CoreDataManager.h"

@implementation Favorite

+ (void) storeFavorite:(Property *) property
{
    CoreDataManager * coreDataManager = [CoreDataManager sharedInstance];
    NSManagedObjectContext * context = [coreDataManager managedObjectContext];
    
    Favorite * favorite = [NSEntityDescription insertNewObjectForEntityForName:@"Favorite" inManagedObjectContext:context];

    [favorite initWithProperty:property];
    
    [coreDataManager saveContext];
}


+ (void) deleteFavorite:(Favorite *) favorite
{
    CoreDataManager * coreDataManager = [CoreDataManager sharedInstance];
    NSManagedObjectContext * context = [coreDataManager managedObjectContext];
    
    [context deleteObject:favorite];
    
    [coreDataManager saveContext];
}


+ (NSArray<Favorite *> *) getFavorites
{
    CoreDataManager * coreDataManager = [CoreDataManager sharedInstance];
    NSManagedObjectContext * context = [coreDataManager managedObjectContext];
    NSError * error;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Favorite" inManagedObjectContext:context];
    
    [fetchRequest setEntity:entity];
    
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    return fetchedObjects;
}


- (void) initWithProperty:(Property *) property
{
    self.alquiler = [NSNumber numberWithBool:property.alquiler];
    self.ciudad = property.ciudad;
    self.descripcion = property.descripcion;
    self.latitud = [NSNumber numberWithDouble:property.latitud];
    self.longitud = [NSNumber numberWithDouble:property.longitud];
    self.metros = [NSNumber numberWithDouble:property.metros];
    self.precio = [NSNumber numberWithDouble:property.precio];
    self.titulo = property.titulo;
}

@end
