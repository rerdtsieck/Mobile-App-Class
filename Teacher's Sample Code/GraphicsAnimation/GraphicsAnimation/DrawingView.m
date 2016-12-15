//
//  DrawingView.m
//  GraphicsAnimation
//
//  Created by cpsc on 11/20/16.
//  Copyright © 2016 cpsc. All rights reserved.
//

#import "DrawingView.h"
#import "AppDelegate.h"

@implementation DrawingView
{
    CGMutablePathRef path;
    CGContextRef currentContext;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    path = CGPathCreateMutable();
    currentContext = nil;
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    //NSLog(@"Calling DrawingView:drawRect method.");
    // Draw on the context; the Graphics Context is available here
    [super drawRect:rect];

    // draw the outside frame
    CGMutablePathRef framepath = CGPathCreateMutable();
    CGRect rectangle = self.frame;
    CGPathAddRect(framepath, NULL, rectangle);
    
    AppDelegate *del = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    del.currentContext = UIGraphicsGetCurrentContext();
    [[UIColor whiteColor] setFill];
    [[UIColor blueColor] setStroke];
    CGContextSetLineWidth(del.currentContext, 5.0f);
    CGContextDrawPath(del.currentContext, kCGPathFillStroke);
    CGContextAddPath(del.currentContext, framepath);
    CGPathRelease(framepath);
    
    //[self.subviews[0] drawRect:rect];
    
    // [self setNeedsDisplay];
    
    // set up the drawing path & stroke
    //if (currentContext == nil)
    //    currentContext = UIGraphicsGetCurrentContext();
    //CGContextSetLineWidth(currentContext, 2.0f);
    //CGContextAddPath(currentContext, path);
    //[[UIColor redColor] setStroke];
    //CGContextDrawPath(currentContext, kCGPathStroke);
}


@end
