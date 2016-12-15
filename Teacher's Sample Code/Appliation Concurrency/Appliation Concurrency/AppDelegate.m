//
//  AppDelegate.m
//  Appliation Concurrency
//
//  Created by cpsc on 11/6/16.
//  Copyright © 2016 cpsc. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void) updateTestName {
    [self willChangeValueForKey:@"testName"];
    self.testName = @"NewName";
    [self didChangeValueForKey:@"testName"];
}

- (void) updateChangedString {
    [self willChangeValueForKey:@"changedObjects"];
    self.changedObjects[2] = @"F"; 
    [self didChangeValueForKey:@"changedObjects"];
}

- (void) appendNewString {
    
    //NSLog(@"appendNewString : Thread is %@", [NSThread currentThread]);
    
    [self willChangeValueForKey:@"objects"];
    //
    NSString *newStr = [NSString stringWithFormat:@"String %ld", self.objects.count];
    // NSLog(@"Adding a string to objects array.");
    [self.objects addObject:newStr];
    //
    [self didChangeValueForKey:@"objects"];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.objects = [[NSMutableArray alloc] init];

    NSArray *testArray = [[NSArray alloc] initWithObjects:@"A",@"B",@"C",@"D",@"E", nil];
    self.changedObjects = [[NSMutableArray alloc] initWithArray:testArray];
    self.testName = @"OldName";
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    NSLog(@"Application Resign Active.");
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    NSLog(@"Application Enter Background.");
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    NSLog(@"Application Enter Foreground.");
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    NSLog(@"Application Became Active.");
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [self.tThread cancel]; 
    NSLog(@"Application Will Terminate. ");
}

@end
