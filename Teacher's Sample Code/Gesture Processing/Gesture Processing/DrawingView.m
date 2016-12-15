//
//  DrawingView.m
//  Gesture Processing
//
//  Created by cpsc on 11/13/16.
//  Copyright © 2016 cpsc. All rights reserved.
//

#import "DrawingView.h"

@implementation DrawingView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //NSLog(@"Enter touchBegan: number of touches %ld", touches.count);
    //NSLog(@"Event object: %@", event);
    UITouch * touch = [touches anyObject];
    CGPoint p = [touch locationInView:self];
    
    UIImageView *monkeyView = self.subviews[0];
    CGPoint origin = monkeyView.frame.origin;
    CGSize size = monkeyView.frame.size;
    
    if (p.x > origin.x && p.y > origin.y && p.x < (origin.x + size.width) && p.y < (origin.y + size.height)) {
        NSLog(@"This is inside the Monkey Image View. %f %f", p.x, p.y);
        self.insideMonkeyView = true;
        self.lastX = p.x;
        self.lastY = p.y;
        NSLog(@"Original control position %f %f", origin.x, origin.y); 
    } else {
        self.insideMonkeyView = false;
        NSLog(@"This is outside the Monkey Image View.");
    }

}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //NSLog(@"Enter touchesMoved: number of touches %ld", touches.count);
    //NSLog(@"Event object: %@", event);
    if (self.insideMonkeyView) {
        UITouch * touch = [touches anyObject];
        CGPoint p = [touch locationInView:self];
        CGFloat diffX = p.x - self.lastX;
        CGFloat diffY = p.y - self.lastY;
        UIImageView *monkeyView = self.subviews[0];
        CGRect origFrame = monkeyView.frame;
        monkeyView.frame = CGRectMake(origFrame.origin.x+diffX, origFrame.origin.y+diffY, origFrame.size.width, origFrame.size.height);
        self.lastX = origFrame.origin.x+diffX;
        self.lastY = origFrame.origin.y+diffY;
    
        NSLog(@"Move the target control to %f %f", origFrame.origin.x+diffX, origFrame.origin.y+diffY);
        [self setNeedsDisplay];
    }
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"Enter touchesEnded: number of touches %ld", touches.count);
    self.insideMonkeyView = false;
    //NSLog(@"Event object: %@", event);
    //[self touchesMoved:touches withEvent:event];
}

@end
