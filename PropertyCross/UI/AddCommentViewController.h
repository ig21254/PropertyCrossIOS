//
//  AddCommentViewController.h
//  PropertyCross
//
//  Created by Master on 27/2/16.
//  Copyright © 2016 La Salle Master. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddCommentViewController : UIViewController


@property (weak, nonatomic) IBOutlet UITextField * username;
@property (weak, nonatomic) IBOutlet UITextView * commentText;
@property (weak, nonatomic) IBOutlet UIImageView * photo;
@property (weak, nonatomic) IBOutlet UIButton * takePhoto;
@property (weak, nonatomic) IBOutlet UIButton * commentButton;
@property (weak, nonatomic) IBOutlet UIButton * cancelButton;

@end
