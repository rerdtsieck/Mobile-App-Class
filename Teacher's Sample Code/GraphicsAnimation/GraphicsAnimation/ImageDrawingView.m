//
//  ImageDrawingView.m
//  GraphicsAnimation
//
//  Created by cpsc on 11/24/16.
//  Copyright © 2016 cpsc. All rights reserved.
//

#import "ImageDrawingView.h"

@implementation ImageDrawingView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    NSLog(@"Calling drawRect method of ImgaeDrawingView class");
    UIImage *image = [UIImage imageNamed:@"monkey"];
    
    //NSLog(@"%@", image);
    
    //[image drawInRect:self.frame];
    [image drawAtPoint:self.frame.origin];
    //[self setNeedsDisplay];
}


@end
