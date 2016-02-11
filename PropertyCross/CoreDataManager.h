//
//  CoreDataManager.h
//  test_coedata
//
//  Created by Lluis Montero on 11/02/16.
//  Copyright © 2016 LaSalle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataManager : NSObject

#pragma mark - Core data properties

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

#pragma mark - Core data methods

- (void)saveContext;

#pragma mark - Class methods

+ (CoreDataManager *)sharedInstance;

@end
