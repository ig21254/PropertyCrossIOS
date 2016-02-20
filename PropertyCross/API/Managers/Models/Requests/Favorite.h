//
//  Favorite.h
//  PropertyCross
//
//  Created by Master on 20/2/16.
//  Copyright © 2016 La Salle Master. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Property.h"

NS_ASSUME_NONNULL_BEGIN

@interface Favorite : NSManagedObject

// Insert code here to declare functionality of your managed object subclass
+ (void) storeFavorite:(Property *) property;
+ (void) deleteFavorite:(Favorite *) favorite;
+ (NSArray<Favorite *> *) getFavorites;
- (void) initWithProperty:(Property *) property;


@end

NS_ASSUME_NONNULL_END

#import "Favorite+CoreDataProperties.h"
