//
//  DrawingView.h
//  Gesture Processing
//
//  Created by cpsc on 11/13/16.
//  Copyright © 2016 cpsc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawingView : UIView

@property (nonatomic) BOOL insideMonkeyView;
@property (nonatomic) CGFloat lastX;
@property (nonatomic) CGFloat lastY; 

@end
