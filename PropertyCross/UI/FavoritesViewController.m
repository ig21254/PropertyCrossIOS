//
//  FavoritesViewController.m
//  PropertyCross
//
//  Created by Master on 20/2/16.
//  Copyright © 2016 La Salle Master. All rights reserved.
//

#import "FavoritesViewController.h"
#import "PropertyDescriptionViewController.h"
#import "Property.h"
#import "UserDefaults.h"
#import "PropertyCross-Swift.h"
#import "SVProgressHUD.h"
#import "Search.h"

@interface FavoritesViewController ()<
UITableViewDataSource,
UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray<Property *> * favoritosAPI;
@property (strong, nonatomic) NSMutableArray<Property *> * favoritos;
@property (readwrite) NSInteger selectedRow;

@end

@implementation FavoritesViewController


- (void) didRemove
{
    // Get data from DB.
    self.favoritos = [Property getFavorites];
    [self.tableView reloadData];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [SVProgressHUD show];
    PropertyWrapper * propertyWrapper = [PropertyWrapper sharedInstance];
    // Search Favorites from API. We will not use this info, as the API doesn't let us add/remove favorites.
    [propertyWrapper searchFavorites:^(PropertySearchResponse * response) {
        // Get data from API.
        self.favoritosAPI = [response.datos mutableCopy];
        
        
        // Get data from DB.
        self.favoritos = [Property getFavorites];
        
        [SVProgressHUD dismiss];
        [self.tableView reloadData];
    }];
}


#pragma TABLE VIEW

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    self.favoritesTitle.text = [NSString stringWithFormat:@"Favoritos (%lu)", (unsigned long)[self.favoritos count]];
    return [self.favoritos count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SearchResultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SearchResultTableViewCell"
                                              owner:self
                                            options:0] firstObject];
        
        Property * property = [self.favoritos objectAtIndex:indexPath.row];
        
        [cell configureCellWithProperty:property];
        cell.delegate = self;
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
        [self performSegueWithIdentifier:@"goToDescriptionFromFavorites" sender:self];
    }
    
}



#pragma SEGUE
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"goToDescriptionFromFavorites"]) {
        PropertyDescriptionViewController * pdvc = segue.destinationViewController;
        pdvc.property = [self.favoritos objectAtIndex:self.selectedRow];
    }
}


@end
