//
//  UserData.m
//  PropertyCross
//
//  Created by Master on 17/2/16.
//  Copyright © 2016 La Salle Master. All rights reserved.
//

#import "UserData.h"
#import "CoreDataManager.h"

@implementation UserData

+ (void) storeSearchWithPropertyResponse:(User *) user andNotification:(BOOL) notification
{
    CoreDataManager * coreDataManager = [CoreDataManager sharedInstance];
    NSManagedObjectContext * context = [coreDataManager managedObjectContext];
    NSError * error;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"UserData" inManagedObjectContext:context];
    
    [fetchRequest setEntity:entity];
    
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    UserData * userData;
    if ([fetchedObjects count] == 0) {
        userData = [NSEntityDescription insertNewObjectForEntityForName:@"UserData" inManagedObjectContext:context];
    }
    else {
        userData = fetchedObjects[0];
    }
    
    userData.firstname = user.nombre;
    userData.lastname = user.apellidos;
    userData.email = user.email;
    userData.notifications = [NSNumber numberWithBool:notification];
    
    
    [coreDataManager saveContext];
}

+ (void) storeUsername:(NSString *) username andPassword:(NSString *) password
{
    CoreDataManager * coreDataManager = [CoreDataManager sharedInstance];
    NSManagedObjectContext * context = [coreDataManager managedObjectContext];
    
    UserData * userData = [NSEntityDescription insertNewObjectForEntityForName:@"UserData" inManagedObjectContext:context];
    
    userData.username = username;
    userData.password = password;
    
    [coreDataManager saveContext];
}


+ (void) storeUsername:(NSString *) username
               andName:(NSString *) name
           andLastName:(NSString *) lastname
              andEmail:(NSString *) email
{
    CoreDataManager * coreDataManager = [CoreDataManager sharedInstance];
    NSManagedObjectContext * context = [coreDataManager managedObjectContext];
    
    UserData * userData = [NSEntityDescription insertNewObjectForEntityForName:@"UserData" inManagedObjectContext:context];
    
    userData.username = username;
    userData.password = @"";
    userData.firstname = name;
    userData.lastname = lastname;
    userData.email = email;
    
    [coreDataManager saveContext];
}




+ (UserData *) getUserInfo
{
    CoreDataManager * coreDataManager = [CoreDataManager sharedInstance];
    NSManagedObjectContext * context = [coreDataManager managedObjectContext];
    NSError * error;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"UserData" inManagedObjectContext:context];
    
    [fetchRequest setEntity:entity];
    
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    if ([fetchedObjects count] != 0)
        return fetchedObjects[0];
    else
        return nil;
}

@end
