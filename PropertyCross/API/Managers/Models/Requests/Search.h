//
//  Search.h
//  PropertyCross
//
//  Created by Master on 16/2/16.
//  Copyright © 2016 La Salle Master. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PropertySearchResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface Search : NSManagedObject

// Insert code here to declare functionality of your managed object subclass
+ (void) storeSearchWithPropertyResponse:(PropertySearchResponse *) response;

+ (NSArray<Search *> *) getRecentSearches;

@end

NS_ASSUME_NONNULL_END

#import "Search+CoreDataProperties.h"
