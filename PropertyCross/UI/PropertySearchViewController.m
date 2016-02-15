//
//  PropertySearchViewController.m
//  PropertyCross
//
//  Created by Master on 3/2/16.
//  Copyright © 2016 La Salle Master. All rights reserved.
//

#import "PropertySearchViewController.h"
#import "SearchResultsViewController.h"
#import "PropertyCross-Swift.h"
#import "LocationManager.h"

#define LOCATION_BUTTON_TAG 1
#define TEXT_QUERY_TAG 2

@implementation PropertySearchViewController

- (void) viewDidLoad
{
    [self txtDireccion].tag = TEXT_QUERY_TAG;
    [self btnLocation].tag = LOCATION_BUTTON_TAG;
}

- (IBAction)searchProperty:(id)sender
{
    [self performSegueWithIdentifier:@"searchProperty" sender:sender];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"searchProperty"]) {
        PropertyRequest * request = [[PropertyRequest alloc] init];
        request.alquiler = [[self swcEnAlquiler] isEnabled];
        request.venta = [[self swcEnVenta] isEnabled];
        if ([sender isEqual:[self txtDireccion]]) {
            request.query = [[self txtDireccion] text];
        }
        else if ([sender isEqual:[self btnLocation]]) {
            LocationManager * locationManager = [LocationManager sharedInstance];
            [locationManager getLocationWithCompetionHandler:^(CLLocation *location) {
                request.latitud = location.coordinate.latitude;
                request.longitud = location.coordinate.longitude;
            }];
        }
        SearchResultsViewController * srvc = segue.destinationViewController;
        srvc.searchRequest = request;
    }
}

@end
