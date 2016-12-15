//
//  TextDrawingView.m
//  GraphicsAnimation
//
//  Created by cpsc on 11/24/16.
//  Copyright © 2016 cpsc. All rights reserved.
//

#import "TextDrawingView.h"
#import "AppDelegate.h"

@implementation TextDrawingView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    NSLog(@"Calling TextDrawingView.drawRect: method");
    [super drawRect:rect];
    // a set of subviews
    CGMutablePathRef path = CGPathCreateMutable();
    
    //
    CGRect rectangle = self.frame;
    CGPathAddRect(path, NULL, rectangle);
    
    //
    AppDelegate *del = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    del.currentContext = UIGraphicsGetCurrentContext();
    CGContextAddPath(del.currentContext, path);
    
    [[UIColor whiteColor] setFill];
    [[UIColor blueColor] setStroke];
    CGContextSetLineWidth(del.currentContext, 5.0f);
    
    CGContextDrawPath(del.currentContext, kCGPathFillStroke);
    CGPathRelease(path);
    //
    UIColor *blueColor = [UIColor blueColor];
    [blueColor set];
    UIFont * helveticaBold = [UIFont fontWithName:@"HelveticaNeue-Bold" size:30.0f];
    NSString *myString = @"I Learn Really Fast";
    //
    [myString drawAtPoint:self.frame.origin
           withAttributes:@{NSFontAttributeName:helveticaBold}];
    // [self setNeedsDisplay];
    
}


@end
