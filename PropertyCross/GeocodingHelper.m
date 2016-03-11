//
//  GeocodingHelper.m
//  practica_mdpa
//
//  Created by Lluis Montero on 17/02/16.
//  Copyright © 2016 LaSalle. All rights reserved.
//

#import "GeocodingHelper.h"

#import <CoreLocation/CLGeocoder.h>
#import <CoreLocation/CLPlacemark.h>

@implementation GeocodingHelper

- (void)getAddressForLatitude:(double)latitude andLongitude:(double)longitude WithCompletionHandler:(void (^)(NSArray<CLPlacemark *> * placemarks, NSError * error)) completionHandler
{
    CLGeocoder* reverseGeocoder = [[CLGeocoder alloc] init];
    [reverseGeocoder reverseGeocodeLocation:[[CLLocation alloc] initWithLatitude:latitude
                                                                       longitude:longitude]
                          completionHandler:^(NSArray<CLPlacemark *> * placemarks, NSError * error)
    {
        //NSLog(@"placemarks: %@", placemarks);
        //NSLog(@"error: %@", error);
    }];
}

@end
