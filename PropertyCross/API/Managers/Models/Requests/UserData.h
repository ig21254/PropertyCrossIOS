//
//  UserData.h
//  PropertyCross
//
//  Created by Master on 17/2/16.
//  Copyright © 2016 La Salle Master. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserData : NSManagedObject

// Insert code here to declare functionality of your managed object subclass
+ (void) storeSearchWithPropertyResponse:(User *) user andNotification:(BOOL) notification;
+ (void) storeUsername:(NSString *) username andPassword:(NSString *) password;
+ (UserData *) getUserInfo;

@end

NS_ASSUME_NONNULL_END

#import "UserData+CoreDataProperties.h"
