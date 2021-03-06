//
//  SearchResultsViewController.m
//  PropertyCross
//
//  Created by Master on 3/2/16.
//  Copyright © 2016 La Salle Master. All rights reserved.
//

#import "SearchResultsViewController.h"
#import "SearchResultTableViewCell.h"
#import "PropertyDescriptionViewController.h"
#import "Property.h"
#import "UserDefaults.h"
#import "PropertyCross-Swift.h"
#import "SVProgressHUD.h"
#import "Search.h"
#import "LocationManager.h"
#import "CustomAnnotation.h"

#define SORT_BY_PRICE_ASC    @"SORT_BY_PRICE_ASC"
#define SORT_BY_PRICE_DESC   @"SORT_BY_PRICE_DESC"
#define SORT_BY_FOOTAGE_ASC  @"SORT_BY_FOOTAGE_ASC"
#define SORT_BY_FOOTAGE_DESC @"SORT_BY_FOOTAGE_DESC"


@interface SearchResultsViewController () <
UITableViewDataSource,
UITableViewDelegate,
MKMapViewDelegate>

@property (strong, nonatomic) NSArray<Property *> * propiedades;
@property (strong, nonatomic) NSArray<Property *> * originalProperties;
@property (strong, nonatomic) NSString * sorting;

@property (readwrite) NSInteger selectedRow;

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation * currentLocation;


@end


@implementation SearchResultsViewController


#pragma Initialization
- (void) viewDidLoad
{
    self.sorting = @"NONE";
    UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    [self setUpViewForOrientation:interfaceOrientation];
    [self.mapView setDelegate:self];
}


- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [SVProgressHUD show];
    PropertyWrapper * propertyWrapper = [PropertyWrapper sharedInstance];
    [propertyWrapper searchPropertyWithRequest:[self searchRequest] completionHandler:^(PropertySearchResponse * response) {
        if (response.criterio == nil) {
            response.criterio = self.searchRequest;
        }
        
        [Search storeSearchWithPropertyResponse:response];
        
        self.originalProperties = [response.datos mutableCopy];
        self.propiedades = self.originalProperties;
        self.titleBar.text = self.searchRequest.query;
        [SVProgressHUD dismiss];
        [self.tableView reloadData];
        [self updateAnotations];
    }];
    
    [[LocationManager sharedInstance] getLocationWithCompetionHandler:^(CLLocation *location) {
        // For debug purposes -> Location = Barcelona
        //self.currentLocation = [[CLLocation alloc] initWithLatitude:41.390205 longitude:2.154007];
        self.currentLocation = location;
        
        [self.mapView setRegion:MKCoordinateRegionMakeWithDistance(self.currentLocation.coordinate, 5000, 5000) animated:true];
    }];
}


#pragma - LoginViewControllerDelegate implementation
- (void)didLogin {
    [self dismissViewControllerAnimated:false completion:nil];
    [self performSegueWithIdentifier:@"goToProfileFromSearchResults" sender:self];
}

#pragma mark - UITxtFieldDelegate implementation

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.searchBar) {
        [self.searchBar resignFirstResponder];
        [self searchProperty];
        self.searchBar.text = @"";
    }
    return true;
}


#pragma COMMANDS
- (void)searchProperty
{
    
    self.searchRequest.query = self.searchBar.text;
    [SVProgressHUD show];
    PropertyWrapper * propertyWrapper = [PropertyWrapper sharedInstance];
    [propertyWrapper searchPropertyWithRequest:[self searchRequest] completionHandler:^(PropertySearchResponse * response) {
        if (response.criterio == nil) {
            response.criterio = self.searchRequest;
        }
        
        [Search storeSearchWithPropertyResponse:response];
        
        self.originalProperties = [response.datos mutableCopy];
        self.propiedades = self.originalProperties;
        [SVProgressHUD dismiss];
        [self.tableView reloadData];
    }];
    
}


- (IBAction)goToProfile:(id)sender {
    if (![UserDefaults getAccessToken]) {
        [self performSegueWithIdentifier:@"goToLoginFromSearchResults" sender:self];
    }
    else {
        [self performSegueWithIdentifier:@"goToProfileFromSearchResults" sender:self];
    }
}

- (IBAction)goToFavorites:(id)sender {
    if (![UserDefaults getAccessToken]) {
        [self performSegueWithIdentifier:@"goToLoginFromSearchResults" sender:self];
    }
    else {
        [self performSegueWithIdentifier:@"goToFavoritesFromResults" sender:self];
    }
}


- (IBAction)decodeButton:(id)sender {
    
    if (self.segmentedControl.selectedSegmentIndex == 0) {
        self.propiedades = self.originalProperties;
    } else if(self.segmentedControl.selectedSegmentIndex == 1) {
        self.propiedades = [self.originalProperties filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"alquiler=true"]];
    } else if(self.segmentedControl.selectedSegmentIndex == 2) {
        self.propiedades = [self.originalProperties filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"alquiler=false"]];
    }
    
    [self.tableView reloadData];
}

#pragma END - COMMANDS



#pragma SORTING
- (IBAction)sortPropertyResults:(id)sender
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Sorting Results"
                                                                   message:@"Choose order to sort the results"
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *firstAction = [UIAlertAction actionWithTitle:@"By price"
                                                          style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                              [self sortResultsWithOrder:SORT_BY_PRICE_ASC];
                                                          }];
    UIAlertAction *secondAction = [UIAlertAction actionWithTitle:@"By footage"
                                                           style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                               [self sortResultsWithOrder:SORT_BY_FOOTAGE_ASC];
                                                           }];
    
    [alert addAction:firstAction];
    [alert addAction:secondAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}



- (void) sortResultsWithOrder:(NSString *) order
{
    NSSortDescriptor * descriptor;
    if ([order isEqualToString:SORT_BY_FOOTAGE_ASC]) {
        // Order by footage
        if ([self.sorting isEqualToString:SORT_BY_FOOTAGE_ASC]) {
            // Order DESCENDING
            descriptor = [[NSSortDescriptor alloc] initWithKey:@"metros" ascending:NO];
            self.sorting = SORT_BY_FOOTAGE_DESC;
            NSLog(@"Sort by footage descending");
        } else {
            // Order ASCENDING
            descriptor = [[NSSortDescriptor alloc] initWithKey:@"metros" ascending:YES];
            self.sorting = SORT_BY_FOOTAGE_ASC;
            NSLog(@"Sort by footage ascending");
        }
    } else {
        // Order by price
        if ([self.sorting isEqualToString:SORT_BY_PRICE_ASC]) {
            // Order DESCENDING
            descriptor = [[NSSortDescriptor alloc] initWithKey:@"precio" ascending:NO];
            self.sorting = SORT_BY_PRICE_DESC;
            NSLog(@"Sort by price descending");
        } else {
            // Order ASCENDING
            descriptor = [[NSSortDescriptor alloc] initWithKey:@"precio" ascending:YES];
            self.sorting = SORT_BY_PRICE_ASC;
            NSLog(@"Sort by price ascending");
        }
    }
    // Sort original data array.
    NSArray * sortDescriptors = [NSArray arrayWithObjects:descriptor, nil];
    self.originalProperties = [self.originalProperties sortedArrayUsingDescriptors:sortDescriptors];
    self.propiedades = [self.propiedades sortedArrayUsingDescriptors:sortDescriptors];
    
    [self.tableView reloadData];
    [self updateAnotations];
}

#pragma END - SORTING



#pragma TABLE VIEW

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.propiedades count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SearchResultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SearchResultTableViewCell"
                                             owner:self
                                            options:0] firstObject];

        Property * property = [self.propiedades objectAtIndex:indexPath.row];
        
        [cell configureCellWithProperty:property];
    }
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedRow = indexPath.row;
    
    if (![UserDefaults getAccessToken]) {
        [self performSegueWithIdentifier:@"goToLoginFromSearchResults" sender:self];
    }
    else {
        [self performSegueWithIdentifier:@"goToDescriptionFromSearch" sender:self];
    }
    
}


#pragma SEGUE
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if (![UserDefaults getAccessToken]) {
        LoginViewController *vc = segue.destinationViewController;
        vc.delegate = self;
    } else {
        if ([segue.identifier isEqualToString:@"goToDescriptionFromSearch"]) {
            PropertyDescriptionViewController * pdvc = segue.destinationViewController;
            pdvc.property = [self.propiedades objectAtIndex:self.selectedRow];
        }
    }
}


#pragma mark InterfaceOrientationMethods


- (void)setUpViewForOrientation:(UIInterfaceOrientation)orientation
{
    if(UIInterfaceOrientationIsLandscape(orientation))
    {
        self.portraitView.hidden = YES;
        self.landscapeView.hidden = NO;
        self.currentView = self.landscapeView;
    }
    else
    {
        self.landscapeView.hidden = YES;
        self.portraitView.hidden = NO;
        self.currentView = self.portraitView;
    }
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self setUpViewForOrientation:toInterfaceOrientation];
}


#pragma mark - MKMapViewDelegate implementation

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{

}

- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView
{
    [self updateAnotations];
}

- (nullable MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    // If the annotation is the user location, just return nil.
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    MKPinAnnotationView *annotationView = (MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"CustomAnnotation"];
    
    if(!annotationView) {
        // Handle any custom annotations.
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation
                                                         reuseIdentifier:@"CustomAnnotation"];
    } else {
        annotationView.annotation = annotation;
    }
    
    annotationView.canShowCallout = true;
    
    BOOL alquiler = ((CustomAnnotation*)annotation).property.alquiler;
    //NSLog(@"ALQUILER: %d", alquiler);
    if (alquiler) {
        // A vegades els pinta tots verds (??)
        annotationView.pinTintColor = [UIColor greenColor];
    }
    
    UIButton * disclosureButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [disclosureButton addTarget:self
                         action:@selector(presentMoreInfo)
               forControlEvents:UIControlEventTouchUpInside];
    annotationView.rightCalloutAccessoryView = disclosureButton;
    
    return annotationView;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view NS_AVAILABLE(10_9, 4_0)
{
    
    [self.mapView setCenterCoordinate:(((CustomAnnotation*)view.annotation).coordinate)];
    
    
    self.selectedRow = ((CustomAnnotation*)view.annotation).position;
}



- (void) updateAnotations
{
    [self.mapView removeAnnotations:[self.mapView annotations]];
    for (int i=0; i < [self.propiedades count]; ++i) {
        Property * p = [self.propiedades objectAtIndex:(NSInteger)i];
        CustomAnnotation * annotation = [[CustomAnnotation alloc] init];
        [annotation setTitle:p.titulo];
        [annotation setSubtitle:p.direccion];
        [annotation setCoordinate:(CLLocationCoordinate2DMake(p.latitud, p.longitud))];
        annotation.property = p;
        annotation.position = (NSInteger)i;
        [self.mapView addAnnotation:annotation];
    }

}


- (void)presentMoreInfo
{
    if (![UserDefaults getAccessToken]) {
        [self performSegueWithIdentifier:@"goToLoginFromSearchResults" sender:self];
    }
    else {
        [self performSegueWithIdentifier:@"goToDescriptionFromSearch" sender:self];
    }
    
}

@end
