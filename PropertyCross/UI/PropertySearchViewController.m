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
#import "Search.h"

#define LOCATION_BUTTON_TAG 1
#define TEXT_QUERY_TAG 2

@interface PropertySearchViewController ()<
LoginViewProtocol,
UITableViewDataSource,
UITableViewDelegate>

@property (strong, nonatomic) id sender;
@property (strong, nonatomic) NSArray<Search *> * recentSearches;

@end


@implementation PropertySearchViewController

- (void) viewDidLoad
{
    [self txtDireccion].tag = TEXT_QUERY_TAG;
    [self btnLocation].tag = LOCATION_BUTTON_TAG;

    self.recentSearches = [Search getRecentSearches];
}

- (void) viewDidAppear:(BOOL)animated
{
    self.recentSearches = [Search getRecentSearches];
    [self.tableView reloadData];
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

@end
