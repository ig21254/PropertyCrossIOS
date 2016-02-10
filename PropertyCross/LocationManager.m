//
//  LocationManager.m
//  practica_mdpa
//
//  Created by Lluis Montero on 08/02/16.
//  Copyright © 2016 LaSalle. All rights reserved.
//

#import "LocationManager.h"

@interface LocationManager()<CLLocationManagerDelegate> {
    CLLocationManager *mLocationManager;
    void (^waitingForLocationCompletionHandler)(CLLocation *location);
}

@end

@implementation LocationManager

- (void)locationManager:(CLLocationManager *)manager
didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if(waitingForLocationCompletionHandler) {
        if(status == kCLAuthorizationStatusAuthorizedWhenInUse ||
           status == kCLAuthorizationStatusAuthorizedAlways) {
            if(mLocationManager.location) {
                // Send current location
                waitingForLocationCompletionHandler(mLocationManager.location);
            }
            else {
                // Start updating device location
                [mLocationManager startUpdatingLocation];
            }
        }
        else {
            // Send nil (indicates error)
            waitingForLocationCompletionHandler(nil);
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    // Stop updating device location
    [mLocationManager stopUpdatingLocation];
    // Notify the new location
    if(waitingForLocationCompletionHandler) {
        waitingForLocationCompletionHandler([locations firstObject]);
    }
}

- (void)getLocationWithCompetionHandler:(void (^)(CLLocation *location))completionHandler
{
    // Get current authorization status
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    switch (status) {
        case kCLAuthorizationStatusNotDetermined: {
            // Store copletion handler
            waitingForLocationCompletionHandler = completionHandler;
            // Request permissions
            [mLocationManager requestWhenInUseAuthorization];
        }
            break;
            
        case kCLAuthorizationStatusRestricted:
        case kCLAuthorizationStatusDenied:
        {
            // The application does not have permissions to use device location
            completionHandler(nil);
        }
            break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        case kCLAuthorizationStatusAuthorizedAlways:
        {
            // The application does have permission to user device location
            if(mLocationManager.location) {
                completionHandler(mLocationManager.location);
            }
            else {
                // Store completion handler
                waitingForLocationCompletionHandler = completionHandler;
                // Request location updates
                [mLocationManager startUpdatingLocation];
            }
        }
            break;
    }
}

#pragma mark - Object lifecycle

- (instancetype)init
{
    if(self = [super init]) {
        mLocationManager = [[CLLocationManager alloc] init];
        mLocationManager.delegate = self;
    }
    return self;
}

#pragma mark - Class methods

+ (LocationManager *)sharedInstance
{
    static LocationManager *sharedLocationManager = nil;
    @synchronized(self) {
        if (!sharedLocationManager) {
            sharedLocationManager = [LocationManager new];
        }
    }
    return sharedLocationManager;
}

@end
