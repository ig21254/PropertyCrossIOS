//
//  CommentTableViewCell.h
//  PropertyCross
//
//  Created by Master on 27/2/16.
//  Copyright © 2016 La Salle Master. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Comentario.h"

@interface CommentTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel * author;
@property (weak, nonatomic) IBOutlet UITextView * commentText;
@property (weak, nonatomic) IBOutlet UIImageView * commentImage;

@property (strong, nonatomic) Comentario * comentario;
@property (retain) UIImage * photo;

- (void) configureCellWithComment:(Comentario *) comentario AndPhoto:(UIImage *) photo;

@end
