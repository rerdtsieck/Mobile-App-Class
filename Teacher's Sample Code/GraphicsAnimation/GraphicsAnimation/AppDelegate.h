//
//  AppDelegate.h
//  GraphicsAnimation
//
//  Created by cpsc on 11/20/16.
//  Copyright © 2016 cpsc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic) CGContextRef currentContext;
@property (nonatomic, strong) UIImage *monkyImage;
@property (nonatomic) CGRect monkyFrame;
@property (nonatomic) int rotateCnt; 

@end

