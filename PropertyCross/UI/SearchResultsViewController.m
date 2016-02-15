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

@interface SearchResultsViewController () <
UITableViewDataSource,
UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray<Property *> * propiedades;

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
    
    //NSLog(@"request: %@", self.searchRequest);
    [SVProgressHUD show];
    PropertyWrapper * propertyWrapper = [PropertyWrapper sharedInstance];
    [propertyWrapper searchPropertyWithRequest:[self searchRequest] completionHandler:^(PropertySearchResponse * response) {
        //NSLog(@"%@ (%lu)",response.datos, (unsigned long)[response.datos count]);
        
        self.propiedades = [response.datos mutableCopy];
        //NSLog(@"Propiedades: %@", self.propiedades);
        [SVProgressHUD dismiss];
        [self.tableView reloadData];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"NumberOfRows: %@ (%lu)", self.propiedades, [self.propiedades count]);
    return [self.propiedades count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Try to dequeue an existing cell
    SearchResultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        //cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
        //                              reuseIdentifier:@"cell"];
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
    }
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}



@end
