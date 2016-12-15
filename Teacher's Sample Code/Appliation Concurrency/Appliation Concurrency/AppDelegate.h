//
//  AppDelegate.h
//  Appliation Concurrency
//
//  Created by cpsc on 11/6/16.
//  Copyright © 2016 cpsc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) NSMutableArray *objects; 
@property (nonatomic, strong) NSMutableArray *changedObjects;
@property (nonatomic, strong) NSString *testName;
@property (nonatomic, strong) NSThread *tThread; 

- (void) appendNewString;
- (void) updateChangedString;
- (void) updateTestName;

@end

