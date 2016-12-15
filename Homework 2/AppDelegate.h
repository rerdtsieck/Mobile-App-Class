//
//  AppDelegate.h
//  HW2_CPSC411_Richard_Erdtsieck
//
//  Created by CampusUser on 10/27/16.
//  Copyright © 2016 Richard Erdtsieck. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

