//
//  ProfileViewController.h
//  PropertyCross
//
//  Created by Master on 8/2/16.
//  Copyright © 2016 La Salle Master. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UIViewController <
UINavigationControllerDelegate,
UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField * username;
@property (weak, nonatomic) IBOutlet UITextField * password;
@property (weak, nonatomic) IBOutlet UITextField * confirmPassword;
@property (weak, nonatomic) IBOutlet UITextField * name;
@property (weak, nonatomic) IBOutlet UITextField * lastname;
@property (weak, nonatomic) IBOutlet UITextField * email;
@property (weak, nonatomic) IBOutlet UISwitch * notification;
@property (weak, nonatomic) IBOutlet UIImageView * photo;
@property (weak, nonatomic) IBOutlet UIButton * takePhoto;

@property (nonatomic) UIImagePickerController * imagePickerController;


@end
