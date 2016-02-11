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

@implementation PropertySearchViewController


- (IBAction)searchProperty:(id)sender
                 WithQuery:(NSString *) query {
    
    
    [self performSegueWithIdentifier:@"searchProperty" sender:sender];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"searchProperty"]) {
        BOOL enVenta = [[self swcEnVenta] isEnabled];
        BOOL enAlquiler = [[self swcEnAlquiler] isEnabled];
        NSString * query = [[self txtDireccion] text];
        
        PropertyRequest * request = [[PropertyRequest alloc] init];
        request.alquiler = [[self swcEnAlquiler] isEnabled];
        request.venta = [[self swcEnVenta] isEnabled];
        request.query = [[self txtDireccion] text];
        
        SearchResultsViewController * srvc = segue.destinationViewController;
        srvc.searchRequest = request;
        
    }
}

@end
