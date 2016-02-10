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

@interface SearchResultsViewController () <
UITableViewDataSource,
UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray<Property *> * propiedades;

@end


@implementation SearchResultsViewController

-(void)didLogin {
    NSLog(@"HOLAAAA");
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


- (void) viewDidLoad
{
    [super viewDidLoad];
    
    self.propiedades = [NSMutableArray array];
    for (int i = 0; i < 50; ++i) {
        NSLog(@"Property %d", i);
        Property * property = [[Property alloc] init];
        
        property.alquiler = i%2==0;
        property.anteriorConsulta = 0;
        property.ciudad = @"Barcelona";
        property.cp = [NSString stringWithFormat:@"080%.2d", i];
        property.descripcion = @"Lorem ipsum";
        property.direccion = [NSString stringWithFormat:@"Ciudad %d", i];
        property.emailPropietario = [NSString stringWithFormat:@"email%d@gmail.com", i];
        property.telefonoPropietario = [NSString stringWithFormat:@"6006060%.2d", i];
        property.titulo = [NSString stringWithFormat:@"Titulo %d", i];
        property.longitud = i + 0.2345;
        property.latitud = i + 1.4561;
        property.precio = 1000 - 1000 % (i+1);
        property.metros = 50 + i;
        
        [self.propiedades addObject:property];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
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
        
        NSLog(@"Parsing %ld.", indexPath.row);
        cell.title.text = [self.propiedades objectAtIndex:indexPath.row].titulo;
        cell.subtitle.text = [self.propiedades objectAtIndex:indexPath.row].direccion;
    }
    
    
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}



@end
