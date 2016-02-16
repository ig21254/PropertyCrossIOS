//
//  Search.m
//  PropertyCross
//
//  Created by Master on 16/2/16.
//  Copyright © 2016 La Salle Master. All rights reserved.
//

#import "Search.h"
#import "CoreDataManager.h"

@implementation Search

// Insert code here to add functionality to your managed object subclass
+ (void) storeSearchWithPropertyResponse:(PropertySearchResponse *) response
{
    CoreDataManager * coreDataManager = [CoreDataManager sharedInstance];
    
    Search * search = [NSEntityDescription insertNewObjectForEntityForName:@"Search" inManagedObjectContext:[coreDataManager managedObjectContext]];
    search.alquiler = [NSNumber numberWithBool:response.criterio.alquiler];
    search.venta = [NSNumber numberWithBool:response.criterio.venta];
    search.query = response.criterio.query;
    search.latitud = [NSNumber numberWithDouble:response.criterio.latitud];
    search.longitud = [NSNumber numberWithDouble:response.criterio.longitud];
    search.num_results = [NSNumber numberWithInteger:[response.datos count]];
    search.timestamp = [NSDate date];
    
    [coreDataManager saveContext];
}

+ (NSArray<Search *> *) getRecentSearches
{
    CoreDataManager * coreDataManager = [CoreDataManager sharedInstance];
    NSManagedObjectContext * context = [coreDataManager managedObjectContext];
    NSError * error;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Search" inManagedObjectContext:context];
    
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor * sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"timestamp" ascending:false];
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    return fetchedObjects;
}

@end
