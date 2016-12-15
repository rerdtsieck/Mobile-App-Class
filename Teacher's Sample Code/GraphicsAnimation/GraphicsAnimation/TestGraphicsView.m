//
//  TestGraphicsView.m
//  GraphicsAnimation
//
//  Created by cpsc on 11/20/16.
//  Copyright © 2016 cpsc. All rights reserved.
//

#import "TestGraphicsView.h"
#import "AppDelegate.h"

@implementation TestGraphicsView

BOOL bJumpUp = false;

- (void)makeMonkyJump {
    AppDelegate *del = (AppDelegate *) ([UIApplication sharedApplication].delegate);
    
    // NSLog(@"Calling makeMonkyJump method");
    CGFloat y;
    if (!bJumpUp) {
        y = del.monkyFrame.origin.y - 15;
        del.monkyFrame = CGRectMake(del.monkyFrame.origin.x, y, del.monkyFrame.size.width, del.monkyFrame.size.height);
        bJumpUp = true;
    } else {
        y = del.monkyFrame.origin.y + 15;
        del.monkyFrame = CGRectMake(del.monkyFrame.origin.x, y, del.monkyFrame.size.width, del.monkyFrame.size.height);
        bJumpUp = false;
    }
    //
    [self setNeedsDisplay];
}

- (void)makeMonkyRotate {
    AppDelegate *del = (AppDelegate *) ([UIApplication sharedApplication].delegate);
    
    // NSLog(@"Calling makeMonkyRotate method");
    del.rotateCnt++;
    if (del.rotateCnt == 4) del.rotateCnt = 0;
    
    //
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    //NSLog(@"Calling TestGraphicsView:drawRect method.");

    UIView *view;
    for (view in self.subviews) {
        [view drawRect:rect];
    }
    
    /*
    // a set of subviews
    CGMutablePathRef path = CGPathCreateMutable();
    
    //
    //CGRect rectangle = CGRectMake(100, 200, 150, 45);
    //CGPathAddRect(path, NULL, rectangle);
    UIView *view;
    for (view in self.subviews) {
        CGRect rectangle = view.frame;
        CGPathAddRect(path, NULL, rectangle); 
    }
    // 
    AppDelegate *del = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    del.currentContext = UIGraphicsGetCurrentContext();
    CGContextAddPath(del.currentContext, path);

    [[UIColor whiteColor] setFill];
    [[UIColor blueColor] setStroke];
    CGContextSetLineWidth(del.currentContext, 5.0f);
    
    CGContextDrawPath(del.currentContext, kCGPathFillStroke);
    CGPathRelease(path);
 */
/*
    UIColor *blueColor = [UIColor blueColor];
    [blueColor set];
    UIFont * helveticaBold = [UIFont fontWithName:@"HelveticaNeue-Bold" size:30.0f];
    NSString *myString = @"I Learn Really Fast";
    [myString drawAtPoint:CGPointMake(41.0f, 361.0f)
           withAttributes:@{NSFontAttributeName:helveticaBold}];
*/
    //
    //NSLog(@"Calling drawRect method of ImgaeDrawingView class");
    
    AppDelegate *del = (AppDelegate *) ([UIApplication sharedApplication].delegate);
    
    //NSLog(@"%@", image);
    
    //[image drawInRect:self.frame];
    if (del.monkyImage == Nil) {
        NSString *imageName = [[NSString alloc] initWithFormat:@"monkey_%d",del.rotateCnt];
        NSString *imgpath = [[NSBundle mainBundle] pathForResource:imageName ofType: @"png"];
        del.monkyImage = [[UIImage alloc] initWithContentsOfFile: imgpath];
        del.monkyFrame = CGRectMake(71.0f, 520.0f, 100.0f, 100.0f);
        [del.monkyImage drawInRect:del.monkyFrame];
        //[NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(makeMonkyJump) userInfo:nil repeats:YES];
        [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(makeMonkyRotate) userInfo:nil repeats:YES];
    } else {
        NSString *imageName = [[NSString alloc] initWithFormat:@"monkey_%d",del.rotateCnt];
        NSString *imgpath = [[NSBundle mainBundle] pathForResource:imageName ofType: @"png"];
        del.monkyImage = [[UIImage alloc] initWithContentsOfFile: imgpath];
        [del.monkyImage drawInRect:del.monkyFrame];
    }

}


@end
