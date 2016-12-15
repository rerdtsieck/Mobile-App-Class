//
//  NestedDrawingView.m
//  GraphicsAnimation
//
//  Created by cpsc on 11/24/16.
//  Copyright © 2016 cpsc. All rights reserved.
//

#import "NestedDrawingView.h"

@implementation NestedDrawingView
{
    CGMutablePathRef path;
    CGContextRef currentContext;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    path = CGPathCreateMutable();
    currentContext = nil;
    //CGPathMoveToPoint(path, NULL, 20, 20);
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    NSLog(@"Nested DrawingView drawRect: method invoked");
    [super drawRect:rect];
    // Draw on the context; the Graphics Context is available here
    if (currentContext == nil)
        currentContext = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(currentContext, 2.0f);
    CGContextAddPath(currentContext, path);
    [[UIColor redColor] setStroke];
    CGContextDrawPath(currentContext, kCGPathStroke);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"Enter touchBegan: number of touches %ld", touches.count);
    //NSLog(@"Event object: %@", event);
    UITouch * touch = [touches anyObject];
    CGPoint p = [touch locationInView:self];
    NSLog(@"Moving to point: %f %f", p.x, p.y);
    CGPathMoveToPoint(path, NULL, p.x, p.y);
    
    self.currentPosition = p;
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //NSLog(@"Enter touchesMoved: number of touches %ld", touches.count);
    //NSLog(@"Event object: %@", event);
    UITouch * touch = [touches anyObject];
    CGPoint p = [touch locationInView:self];
    //NSLog(@"Adding a line: %f %f", p.x, p.y);
    CGPathAddLineToPoint(path, NULL, p.x, p.y);
    //CGContextDrawPath(currentContext, kCGPathStroke);
    [self setNeedsDisplay];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //NSLog(@"Enter touchesMoved: number of touches %ld", touches.count);
    //NSLog(@"Event object: %@", event);
    [self touchesMoved:touches withEvent:event];
}

@end
