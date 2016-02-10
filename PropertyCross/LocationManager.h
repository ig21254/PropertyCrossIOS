//
//  LocationManager.h
//  practica_mdpa
//
//  Created by Lluis Montero on 08/02/16.
//  Copyright © 2016 LaSalle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface LocationManager : NSObject

#pragma mark - Instance methods

- (void)getLocationWithCompetionHandler:(void (^)(CLLocation *location))completionHandler;

#pragma mark - Class methods

+ (LocationManager *)sharedInstance;

@end
