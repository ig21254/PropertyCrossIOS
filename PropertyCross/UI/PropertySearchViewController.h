//
//  PropertySearchViewController.h
//  PropertyCross
//
//  Created by Master on 3/2/16.
//  Copyright © 2016 La Salle Master. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PropertySearchViewController : UIViewController

@property (weak) IBOutlet UISwitch * swcEnVenta;
@property (weak) IBOutlet UISwitch * swcEnAlquiler;
@property (weak, readwrite) IBOutlet UITextField * txtDireccion;
@property (weak, readwrite) IBOutlet UIButton * btnLocation;
@property (weak) IBOutlet UITableView * tableView;

@end
