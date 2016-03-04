//
//  ProfileViewController.m
//  PropertyCross
//
//  Created by Master on 8/2/16.
//  Copyright © 2016 La Salle Master. All rights reserved.
//

#import "ProfileViewController.h"
#import "User.h"
#import "UserData.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.btnFacebookLogin.readPermissions = @[@"public_profile", @"email"];
    self.btnFacebookLogin.delegate = self;
    
}

- (void) viewDidAppear:(BOOL)animated
{
    UserData * user = [UserData getUserInfo];
    
    if (user) {
        self.username.text = user.username;
        self.password.text = user.password;
        self.confirmPassword.text = user.password;
        self.name.text = user.firstname;
        self.lastname.text = user.lastname;
        self.email.text = user.email;
        self.notification.selected = user.notifications;
    }
}

- (IBAction) saveProfile:(id)sender {
    User * user = [[User alloc] init];
    
    user.nombre = self.name.text;
    user.apellidos = self.lastname.text;
    user.email = self.email.text;
    
    [UserData storeSearchWithPropertyResponse:user andNotification:[self.notification isEnabled]];
    [self dismissViewControllerAnimated:false completion:nil];
}

- (IBAction)takePhoto:(id)sender {
    [self displayImagePicker];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}


- (IBAction)cancelProfile:(id)sender
{
    [self dismissViewControllerAnimated:false completion:nil];
    [self performSegueWithIdentifier:@"goToPropertySearchFromProfile" sender:sender];
    
}


#pragma mark - Image picker implementation

- (BOOL)checkIfFrontCameraIsAvailable
{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

- (BOOL)checkIfRearCameraIsAvailable
{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

- (BOOL)checkIfFlashIsAvailable:(UIImagePickerControllerCameraDevice)device
{
    return [UIImagePickerController isFlashAvailableForCameraDevice:device];
}

- (BOOL)checkIfCameraSourceIsAvailable
{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

- (void)displayImagePicker
{
    [self displayImagePickerWithSource:UIImagePickerControllerSourceTypePhotoLibrary
                     withAllowEditting:true];
}

- (void)displayImagePickerWithSource:(UIImagePickerControllerSourceType)source
                   withAllowEditting:(BOOL)allowEdit
{
    if(!self.imagePickerController) {
        self.imagePickerController = [[UIImagePickerController alloc] init];
        self.imagePickerController.modalPresentationStyle = UIModalPresentationCurrentContext;
        self.imagePickerController.delegate = self;
    }
    
    self.imagePickerController.allowsEditing = allowEdit;
    self.imagePickerController.sourceType = source;
    [self presentViewController:self.imagePickerController
                       animated:YES
                     completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate

// This method is called when an image has been chosen from the library or taken from the camera.
- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"imagePickerController:didFinishPickingMediaWithInfo: %@", info);

    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    self.photo.image = image;

    [picker dismissViewControllerAnimated:true
                               completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}



- (void) loginButton:(FBSDKLoginButton *)loginButton
didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result
               error:	(NSError *)error {
    
}


- (void) loginButtonDidLogOut:(FBSDKLoginButton *)loginButton
{
    [UserDefaults storeAccessToken:nil];
    [self cancelProfile:self];
}




@end
