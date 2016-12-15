//
//  AppDelegate.m
//  HW2_Richard_Erdtsieck
//
//  Created by CampusUser on 11/5/16.
//  Copyright © 2016 Richard Erdtsieck. All rights reserved.
//

#import "AppDelegate.h"
#import "sqlite3.h"
#import "StudentMO+CoreDataProperties.h"
#import "CourseMO+CoreDataProperties.h"

@interface AppDelegate ()
@property sqlite3* db;

@end

@implementation AppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

NSFetchRequest *fetchRequest;
NSArray * studentArray = nil;


- (void) dumpObjectModel
{
    NSArray * entities = [[self managedObjectModel] entities];
    NSEntityDescription * entDesc;
    for (entDesc in entities) {
        NSLog(@"***  The Entity Name %@", entDesc.name);
        NSArray * properties = [entDesc properties];
        NSPropertyDescription * property;
        for (property in properties) {
            NSLog(@"     The Property Name %@", property.name);
            
            if ([property isKindOfClass:[NSAttributeDescription class]]) {
                NSAttributeDescription * attribute = (NSAttributeDescription *) property;
                NSLog(@"          The property is an Attribute.");
                NSLog(@"          The Attribute Name %@", attribute.attributeValueClassName);
                NSLog(@"          The Attribute Type %ld", attribute.attributeType);
            }
            
            if ([property isKindOfClass:[NSRelationshipDescription class]]) {
                NSRelationshipDescription * relation = (NSRelationshipDescription *) property;
                Boolean isToMany = relation.isToMany;
                NSLog(@"          The property is an Relationship.");
                NSLog(@"          The destination entity %@", relation.destinationEntity.name);
                NSLog(@"          Is to many relation? %hhu", isToMany);
            }
        }
        NSLog(@"***********");
    }
}

-(void)getSQLiteData:(NSString*)dbPath
{
    /*_sqliteData = [[NSMutableArray alloc] init];
    sqlite3 *database;
    if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK)
    {
        const char *sql = "select Name, CWID, Courses from Student";
        sqlite3_stmt *selectStatement;
        if(sqlite_prepare_v2(database, sql, -1, &selectStatement, NULL) == SQLITE_OK)
            StudentMO *studentObject = [[StudentMO alloc] init];
        
    }*/
    
    
}

-(NSMutableArray *)fetchTableNames
{
    sqlite3_stmt* statement;
    NSString *query = @"SELECT name FROM Student WHERE type=\'table\'";
    int retVal = sqlite3_prepare_v2(_db,
                                    [query UTF8String],
                                    -1,
                                    &statement,
                                    NULL);
    
    NSMutableArray *selectedRecords = [NSMutableArray array];
    if ( retVal == SQLITE_OK )
    {
        while(sqlite3_step(statement) == SQLITE_ROW )
        {
            NSString *value = [NSString stringWithCString:(const char *)sqlite3_column_text(statement, 0)
                                                 encoding:NSUTF8StringEncoding];
            [selectedRecords addObject:value];
        }
    }
    
    sqlite3_clear_bindings(statement);
    sqlite3_finalize(statement);
    
    return selectedRecords;
}
 

- (void) establishEnrolledRelation
{
    fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *studentEntity = [NSEntityDescription entityForName:@"Student" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:studentEntity];
    
    NSError *retrieveError = nil;
    studentArray = [self.managedObjectContext executeFetchRequest:fetchRequest error:&retrieveError];
    if (retrieveError != nil) {
        NSLog(@"Failed to retrieve all Person objects due to %@", retrieveError);
    }
    
    //[self establishClientByBankName:@"America"];
    //[self establishClientByBankName:@"Citi"];
    
    NSError *saveError = nil;
    if ([self.managedObjectContext save:&saveError]) {
        NSLog(@"Successfully persist Client relation.");
    } else {
        NSLog(@"Failed to Client relation due to %@", saveError);
    }
}

/*- (void) populateTestData
{
    //[self populateBankEntities];
    
    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    
    //NSMutableSet *pSet = [[NSMutableSet alloc] init];
    StudentMO *newStudent = [NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext:self.managedObjectContext];
    newStudent.name = @"Richard Erdtsieck";
    newStudent.cwid = @"1234";
    newStudent.courses = @"411";
    
    CourseMO *newCourse = [NSEntityDescription insertNewObjectForEntityForName:@"Course" inManagedObjectContext:self.managedObjectContext];
    newCourse.courseID = @"411";
    newCourse.hwWeight = 15;
    newCourse.midtermWeight = 20;
    newCourse.finalWeight = 25;
    //[pSet addObject:newCourse];
    //pet1.owner = newPerson;
    //[pSet addObject:pet1];
    
    //pet1 = [NSEntityDescription insertNewObjectForEntityForName:@"Pet" inManagedObjectContext:self.managedObjectContext];
    //pet1.name = @"Zenzen";
    //pet1.type = @"Dog";
    //pet1.owner = newPerson;
    //[pSet addObject:pet1];
    
    //newPerson.pets = pSet;
    //newStudent.courses = pSet;
    
    [context save:nil];
    
    //pSet = [[NSMutableSet alloc] init];
    //newStudent = [NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext:self.managedObjectContext];
    //newStudent.name = @"John Doe";
    //newStudent.cwid = @"5678";
    //newStudent.courseList = @"411";
    
    //pSet = [[NSMutableSet alloc] init];
    //newCourse.courseID = @"120";
    //newCourse.hwWeight = 20;
    //newCourse.midtermWeight = 25;
    //newCourse.finalWeight = 30;
    
    //[pSet addObject:newCourse];
    //newPerson.pets = pSet;
    //pet1.owner = newPerson;
    //[pSet addObject:pet1];
    
    NSError *saveError = nil;
    if ([self.managedObjectContext save:&saveError]) {
        NSLog(@"Successfully persist objects.");
    } else {
        NSLog(@"Failed to persist objects due to %@", saveError);
    }
    
    [self establishEnrolledRelation];
}
 */

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * _databasePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"HW2_Richard_Erdtsieck.sqlite"];
    //NSString * _databasePath = @"HW2_Richard_Erdtsieck.sqlite";
    NSLog(@"%@", _databasePath);
    
    // Test the Managed Object Model API
    //[self dumpObjectModel];
    
    // Test the Managed Object API
    
    //[self populateTestData];
    
    // Test the NSPredicate usage
    
    sqlite3 * db;
        const char *dbpath = [_databasePath UTF8String];
     if (sqlite3_open(dbpath, &_db) != SQLITE_OK) {
     NSLog(@"Failed to open the database.");
     } else {
     NSLog(@"Successfully connect to the database.");
     NSMutableArray * tableNames = [self fetchTableNames];
     NSString * n;
     for (n in tableNames) {
     NSLog(@"%@", n);
     }
     }
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}


#pragma mark - Core Data stack

//@synthesize managedObjectContext = _managedObjectContext;
//@synthesize managedObjectModel = _managedObjectModel;
//@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "fullerton.edu.CoreData_Project" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    if(!_managedObjectModel)
    {
        _managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    }
    
    //NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"CoreData_Project" withExtension:@"momd"];
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"HW2_Richard_Erdtsieck" withExtension:@"momd"];
    NSLog(@"absoluteURL = %@", [modelURL absoluteURL]);
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"HW2_Richard_Erdtsieck.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}
@end
