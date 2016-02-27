//
//  AddCommentViewController.m
//  PropertyCross
//
//  Created by Master on 27/2/16.
//  Copyright © 2016 La Salle Master. All rights reserved.
//

#import "AddCommentViewController.h"
#import "UserData.h"

@interface AddCommentViewController ()

@end

@implementation AddCommentViewController


- (void) viewDidAppear:(BOOL)animated
{
    UserData * user = [UserData getUserInfo];
    if (user) {
        self.username.text = user.username;
    }
}


#pragma IBActions

- (IBAction)cancelComment:(id)sender
{
    [self dismissViewControllerAnimated:false completion:nil];
}

- (IBAction)takeAPicture:(id)sender
{
    [self displayImagePicker];
}

- (IBAction)sendComment:(id)sender
{
    Comentario * comentario = [[Comentario alloc] init];
    comentario.autor = self.username.text;
    comentario.texto = self.commentText.text;
    
    comentario.foto = self.photo.image.accessibilityIdentifier;
    [self.delegate didComment:comentario WithImage:self.photo.image];
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
    
    //NSLog(@"imagePickerController:didFinishPickingMediaWithInfo: %@", info);
    
    // Do whatever you want with the given image
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    self.photo.image = image;
    self.photo.image.accessibilityIdentifier = [[info objectForKey:@"UIImagePickerControllerReferenceURL"] absoluteString];
    // Remember to close the picker
    [picker dismissViewControllerAnimated:true
                               completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}


@end
