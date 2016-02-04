//
//  PropertySearchViewController.m
//  PropertyCross
//
//  Created by Master on 3/2/16.
//  Copyright © 2016 La Salle Master. All rights reserved.
//

#import "PropertySearchViewController.h"

@implementation PropertySearchViewController


- (IBAction)searchProperty:(id)sender {
    [self performSegueWithIdentifier:@"searchProperty" sender:sender];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"searchProperty"]) {
        
    }
}

@end
