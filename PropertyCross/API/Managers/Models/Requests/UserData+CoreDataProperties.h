//
//  UserData+CoreDataProperties.h
//  PropertyCross
//
//  Created by Master on 17/2/16.
//  Copyright © 2016 La Salle Master. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "UserData.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserData (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *username;
@property (nullable, nonatomic, retain) NSString *password;
@property (nullable, nonatomic, retain) NSString *firstname;
@property (nullable, nonatomic, retain) NSString *lastname;
@property (nullable, nonatomic, retain) NSString *email;
@property (nullable, nonatomic, retain) NSNumber *notifications;

@end

NS_ASSUME_NONNULL_END
