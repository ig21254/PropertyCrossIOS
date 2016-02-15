//
//  SearchResultsViewController.h
//  PropertyCross
//
//  Created by Master on 3/2/16.
//  Copyright © 2016 La Salle Master. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"
#import "PropertyRequest.h"

@interface SearchResultsViewController : UIViewController<LoginViewProtocol>

@property (strong, nonatomic) PropertyRequest * searchRequest;
@property (strong, nonatomic) IBOutlet UITableView * tableView;

@end
