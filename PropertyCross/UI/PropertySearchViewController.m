//
//  PropertySearchViewController.m
//  PropertyCross
//
//  Created by Master on 3/2/16.
//  Copyright © 2016 La Salle Master. All rights reserved.
//

#import <CoreLocation/CLGeocoder.h>
#import <CoreLocation/CLPlacemark.h>
#import "PropertySearchViewController.h"
#import "SearchResultsViewController.h"
#import "LocationManager.h"
#import "UserDefaults.h"
#import "Search.h"


#define LOCATION_BUTTON_TAG 1
#define TEXT_QUERY_TAG 2

@interface PropertySearchViewController ()<
LoginViewProtocol,
UITableViewDataSource,
UITableViewDelegate>

@property (strong, nonatomic) id sender;
@property (strong, nonatomic) NSMutableArray<Search *> * recentSearches;
@property (strong, nonatomic) PropertyRequest * request;

@end


@implementation PropertySearchViewController

- (void) viewDidLoad
{
    [self txtDireccion].tag = TEXT_QUERY_TAG;
    [self btnLocation].tag = LOCATION_BUTTON_TAG;

    self.recentSearches = [[Search getRecentSearches] mutableCopy];
    self.request = [[PropertyRequest alloc] init];
}

- (void) viewDidAppear:(BOOL)animated
{
    self.recentSearches = [[Search getRecentSearches] mutableCopy];
    [self.tableView reloadData];
}


- (IBAction)searchProperty:(id)sender
{
    self.sender = sender;
    
    self.request = [[PropertyRequest alloc] init];
    self.request.alquiler = [[self swcEnAlquiler] isEnabled];
    self.request.venta = [[self swcEnVenta] isEnabled];
    if ([self.sender isEqual:[self txtDireccion]]) {
        self.request.query = [[self txtDireccion] text];
        if (![UserDefaults getAccessToken]) {
            [self performSegueWithIdentifier:@"goToLoginFromPropertySearch" sender:self];
        }
        else {
            [self performSegueWithIdentifier:@"searchProperty" sender:sender];
        }
    }
    else if ([self.sender isEqual:[self btnLocation]]) {
        LocationManager * locationManager = [LocationManager sharedInstance];
        [locationManager getLocationWithCompetionHandler:^(CLLocation *location) {
            self.request.latitud = location.coordinate.latitude;
            self.request.longitud = location.coordinate.longitude;
        }];
        CLGeocoder* reverseGeocoder = [[CLGeocoder alloc] init];
        [reverseGeocoder reverseGeocodeLocation:[[CLLocation alloc] initWithLatitude:self.request.latitud
                                                                           longitude:self.request.longitud]
                              completionHandler:^(NSArray<CLPlacemark *> * placemarks, NSError * error)
         {
             self.request.query = placemarks[0].name;
             if (![UserDefaults getAccessToken]) {
                 [self performSegueWithIdentifier:@"goToLoginFromPropertySearch" sender:self];
             }
             else {
                 [self performSegueWithIdentifier:@"searchProperty" sender:sender];
             }
         }];
    }
    
}

- (void)didLogin {
    [self dismissViewControllerAnimated:false completion:nil];
    [self performSegueWithIdentifier:@"searchProperty" sender:self];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"searchProperty"]) {
        SearchResultsViewController * srvc = segue.destinationViewController;
        srvc.searchRequest = self.request;
    }
    
    if ([segue.identifier isEqualToString:@"goToLoginFromPropertySearch"]) {
        if (![UserDefaults getAccessToken]) {
            LoginViewController *vc = segue.destinationViewController;
            vc.delegate = self;
        }
    }
}


#pragma TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.recentSearches count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    
    Search * search = [self.recentSearches objectAtIndex:indexPath.row];
    cell.textLabel.text = search.query;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ resultados", search.num_results];
    
    return cell;
}


- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Search * search = self.recentSearches[indexPath.row];
    
    self.request.alquiler = search.alquiler;
    self.request.venta = search.venta;
    self.request.query = search.query;
    self.request.latitud = [search.latitud doubleValue];
    self.request.longitud = [search.longitud doubleValue];

    if (![UserDefaults getAccessToken]) {
        [self performSegueWithIdentifier:@"goToLoginFromPropertySearch" sender:self];
    }
    else {
        [self performSegueWithIdentifier:@"searchProperty" sender:self];
    }
    
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self deleteRecentSearch:tableView WithIndex:indexPath];
        
    }
}

- (void) deleteRecentSearch:(UITableView *) tableView WithIndex:(NSIndexPath *) indexPath
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Eliminar búsqueda reciente" message:@"¿Está seguro que quiere eliminar este elemento?" preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction: [UIAlertAction actionWithTitle:@"Eliminar" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action) {
        [Search deleteSearch: [self.recentSearches objectAtIndex:indexPath.row]];
        [self.recentSearches removeObjectAtIndex:indexPath.row];
        [tableView reloadData];
    }]];
    
    [alert addAction: [UIAlertAction actionWithTitle:@"Cancelar" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
        [tableView reloadData];
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

@end
