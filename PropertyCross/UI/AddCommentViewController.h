//
//  AddCommentViewController.h
//  PropertyCross
//
//  Created by Master on 27/2/16.
//  Copyright © 2016 La Salle Master. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Comentario.h"

@protocol AddCommentViewProtocol <NSObject>

@required
- (void) didComment:(Comentario *) comentario WithImage:(UIImage *) photo;


@end


@interface AddCommentViewController : UIViewController<
UINavigationControllerDelegate,
UIImagePickerControllerDelegate>


@property (weak, nonatomic) IBOutlet UITextField * username;
@property (weak, nonatomic) IBOutlet UITextView * commentText;
@property (weak, nonatomic) IBOutlet UIImageView * photo;
@property (weak, nonatomic) IBOutlet UIButton * takePhoto;
@property (weak, nonatomic) IBOutlet UIButton * commentButton;
@property (weak, nonatomic) IBOutlet UIButton * cancelButton;

@property (nonatomic) UIImagePickerController * imagePickerController;

@property (assign) id<AddCommentViewProtocol> delegate;

@end
