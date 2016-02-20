//
//  FavoritesViewController.h
//  PropertyCross
//
//  Created by Master on 20/2/16.
//  Copyright © 2016 La Salle Master. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PropertyRequest.h"
#import "SearchResultTableViewCell.h"

@interface FavoritesViewController : UIViewController <SearchResultTableViewCellProtocol>

@property (weak) IBOutlet UILabel * favoritesTitle;
@property (weak) IBOutlet UITableView * tableView;

@end
