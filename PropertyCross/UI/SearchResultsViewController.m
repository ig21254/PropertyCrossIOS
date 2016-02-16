//
//  SearchResultsViewController.m
//  PropertyCross
//
//  Created by Master on 3/2/16.
//  Copyright © 2016 La Salle Master. All rights reserved.
//

#import "SearchResultsViewController.h"
#import "SearchResultTableViewCell.h"
#import "Property.h"
#import "UserDefaults.h"
#import "PropertyCross-Swift.h"
#import "SVProgressHUD.h"
#import "Search.h"

@interface SearchResultsViewController () <
UITableViewDataSource,
UITableViewDelegate>

@property (strong, nonatomic) NSArray<Property *> * propiedades;
@property (strong, nonatomic) NSArray<Property *> * originalProperties;

@end


@implementation SearchResultsViewController

- (void)didLogin {
    [self dismissViewControllerAnimated:false completion:nil];
    [self performSegueWithIdentifier:@"goToProfileFromSearchResults" sender:self];
}


- (IBAction)goToProfile:(id)sender {
    if (![UserDefaults getAccessToken]) {
        [self performSegueWithIdentifier:@"goToLoginFromSearchResults" sender:self];
    }
    else {
        [self performSegueWithIdentifier:@"goToProfileFromSearchResults" sender:self];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"SEGUE = %@", segue.identifier);
    if ([segue.identifier isEqualToString:@"goToLoginFromSearchResults"]) {
        if (![UserDefaults getAccessToken]) {
            LoginViewController *vc = segue.destinationViewController;
            vc.delegate = self;
        }
    }
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [SVProgressHUD show];
    PropertyWrapper * propertyWrapper = [PropertyWrapper sharedInstance];
    [propertyWrapper searchPropertyWithRequest:[self searchRequest] completionHandler:^(PropertySearchResponse * response) {
        
        if (response.criterio.query != nil) {
            [Search storeSearchWithPropertyResponse:response];
        }
        
        self.originalProperties = [response.datos mutableCopy];
        self.propiedades = self.originalProperties;
        [SVProgressHUD dismiss];
        [self.tableView reloadData];
    }];
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
        
        cell.title.text = property.titulo;
        
        if (property.alquiler) {
            cell.subtitle.text = @"en alquiler";
        }
        else {
            cell.subtitle.text = @"en venta";
        }
            
        cell.price.text = [NSString stringWithFormat:@"%.2f €", property.precio];
        cell.footage.text = [NSString stringWithFormat:@"%.2f m2", property.metros];
        
        cell.image.contentMode = UIViewContentModeScaleAspectFit;
        cell.image.image = [UIImage imageNamed:[NSString stringWithFormat:@"apartment%d.jpg", arc4random_uniform(4)+1]];
    }
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
}



@end
