//
//  AppDelegate.h
//  archive project
//
//  Created by cpsc on 10/1/16.
//  Copyright © 2016 cpsc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, NSKeyedArchiverDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) NSMutableArray * personList; 

@end

