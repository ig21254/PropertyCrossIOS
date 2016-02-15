//
//  PropertySearchViewController.m
//  PropertyCross
//
//  Created by Master on 3/2/16.
//  Copyright © 2016 La Salle Master. All rights reserved.
//

#import "PropertySearchViewController.h"
#import "SearchResultsViewController.h"
#import "LocationManager.h"
#import "UserDefaults.h"

#define LOCATION_BUTTON_TAG 1
#define TEXT_QUERY_TAG 2

@interface PropertySearchViewController ()<LoginViewProtocol>

@property (strong, nonatomic) id sender;

@end


@implementation PropertySearchViewController

- (void) viewDidLoad
{
    [self txtDireccion].tag = TEXT_QUERY_TAG;
    [self btnLocation].tag = LOCATION_BUTTON_TAG;
}

- (IBAction)searchProperty:(id)sender
{
    self.sender = sender;
    
    NSLog(@"Access Token: %@", [UserDefaults getAccessToken]);
    if (![UserDefaults getAccessToken]) {
        [self performSegueWithIdentifier:@"goToLoginFromPropertySearch" sender:self];
    }
    else {
        [self performSegueWithIdentifier:@"searchProperty" sender:sender];
    }
    
}

- (void)didLogin {
    [self dismissViewControllerAnimated:false completion:nil];
    [self performSegueWithIdentifier:@"searchProperty" sender:self];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"searchProperty"]) {
        PropertyRequest * request = [[PropertyRequest alloc] init];
        request.alquiler = [[self swcEnAlquiler] isEnabled];
        request.venta = [[self swcEnVenta] isEnabled];
        if ([self.sender isEqual:[self txtDireccion]]) {
            request.query = [[self txtDireccion] text];
        }
        else if ([self.sender isEqual:[self btnLocation]]) {
            LocationManager * locationManager = [LocationManager sharedInstance];
            [locationManager getLocationWithCompetionHandler:^(CLLocation *location) {
                request.latitud = location.coordinate.latitude;
                request.longitud = location.coordinate.longitude;
            }];
        }
        SearchResultsViewController * srvc = segue.destinationViewController;
        srvc.searchRequest = request;
    }
    
    if ([segue.identifier isEqualToString:@"goToLoginFromPropertySearch"]) {
        if (![UserDefaults getAccessToken]) {
            LoginViewController *vc = segue.destinationViewController;
            vc.delegate = self;
        }
    }
}

@end
