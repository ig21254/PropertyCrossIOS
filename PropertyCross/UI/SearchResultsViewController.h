//
//  SearchResultsViewController.h
//  PropertyCross
//
//  Created by Master on 3/2/16.
//  Copyright © 2016 La Salle Master. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "LoginViewController.h"
#import "PropertyRequest.h"

@interface SearchResultsViewController : UIViewController<
LoginViewProtocol,
UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UIView * portraitView;
@property (strong, nonatomic) IBOutlet UIView * landscapeView;
@property (strong, nonatomic) UIView * currentView;

@property (strong, nonatomic) PropertyRequest * searchRequest;
@property (strong, nonatomic) IBOutlet UITableView * tableView;
@property (weak, nonatomic)   IBOutlet UISegmentedControl * segmentedControl;
@property (weak, nonatomic)   IBOutlet UITextField * searchBar;
@property (weak, nonatomic)   IBOutlet UILabel * titleBar;

@property (weak, nonatomic) IBOutlet MKMapView * mapView;


@end
