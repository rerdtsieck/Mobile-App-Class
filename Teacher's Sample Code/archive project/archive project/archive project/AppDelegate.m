//
//  AppDelegate.m
//  archive project
//
//  Created by cpsc on 10/1/16.
//  Copyright © 2016 cpsc. All rights reserved.
//

#import "AppDelegate.h"
#import "Person.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)archiver:(NSKeyedArchiver *)archiver didEncodeObject:(nullable id)object {
    NSLog(@"Object has been encoded : %@", object);
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSLog(@"Calling the Delegate method");
    // Override point for customization after application launch.
    self.personList = [[NSMutableArray alloc] init];
    Person * person = [[Person alloc] init];
    [self.personList addObject:person];
    person.firstName = @"James";
    person.lastName = @"Shen";
    person.CWID = @"999999999";
    //
    person.courseList = [[NSMutableArray alloc] init];
    [person.courseList addObject:@"CS411"];
    [person.courseList addObject:@"CS431"];
    
    // Construct the file path
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
    NSString *documentsDirectory = [pathArray objectAtIndex:0];
    NSString *dataFolder = [documentsDirectory stringByAppendingString:@"/data"];
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    if (![fileManager fileExistsAtPath:dataFolder])
    {
        NSLog(@"Creating the data folder. ");
        NSError *error = nil;
        [fileManager createDirectoryAtPath:dataFolder withIntermediateDirectories:YES attributes:nil error:&error];
    }
    
    NSString *archivePath = [dataFolder stringByAppendingPathComponent:@"PersonList.txt"];
    
    // Option 1 - Save to a fie
    //[NSKeyedArchiver archiveRootObject:self.personList toFile:archivePath];
    //NSLog(@"PersonList has been save on to Disk : %@", archivePath);
    //
    //[self.personList removeObjectAtIndex:0];
    //NSLog(@"The size of PersonList : %ld", self.personList.count);
    //self.personList = nil;
    //NSLog(@"PersonList after released, %@", self.personList);
    
    //
    //self.personList = [NSKeyedUnarchiver unarchiveObjectWithFile:archivePath];
    //NSLog(@"The size of PersonList retrieved from Disk: %ld", self.personList.count);
    //
    //Person * copyPerson = [self.personList objectAtIndex:0];
    //copyPerson.courseList = [NSKeyedUnarchiver unarchiveObjectWithFile:cListArchivePath];
 
    // Option 2 - Create an NSData object first and save it to a file
    NSMutableData *data = [[NSMutableData alloc]init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    archiver.delegate = self;
    [archiver encodeObject:self.personList];
    [archiver finishEncoding];
    [data writeToFile:archivePath atomically:YES];

    NSLog(@"PersonList has been save on to Disk : %@", archivePath);

    [self.personList removeObjectAtIndex:0];
    self.personList = nil;

    NSLog(@"The size of PersonList : %ld", self.personList.count);
    NSLog(@"PersonList after released, %@", self.personList);
    
    // Read NSData and decode the object
    data = [NSMutableData dataWithContentsOfFile:archivePath];
    NSKeyedUnarchiver * unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    self.personList = [unarchiver decodeObject];

    NSLog(@"The size of PersonList retrieved from Disk: %ld", self.personList.count);
    //
    Person * copyPerson = [self.personList objectAtIndex:0];
    //copyPerson.courseList = [NSKeyedUnarchiver unarchiveObjectWithFile:cListArchivePath];
    
    NSLog(@"First Name : %@", copyPerson.firstName);
    NSLog(@"Last Name : %@", copyPerson.lastName);
    NSLog(@"CWID : %@", copyPerson.CWID);
    NSLog(@"Course List : %@", copyPerson.courseList[0]);
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
