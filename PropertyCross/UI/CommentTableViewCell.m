//
//  CommentTableViewCell.m
//  PropertyCross
//
//  Created by Master on 27/2/16.
//  Copyright © 2016 La Salle Master. All rights reserved.
//

#import "CommentTableViewCell.h"

@implementation CommentTableViewCell

- (void) configureCellWithComment:(Comentario *) comentario AndPhoto:(UIImage *) photo
{
    self.author.text = comentario.autor;
    self.commentText.text = comentario.texto;
    self.commentImage.contentMode = UIViewContentModeScaleAspectFit;
    self.commentImage.image = photo;
    
    self.comentario = comentario;
    self.photo = photo;
}

@end
