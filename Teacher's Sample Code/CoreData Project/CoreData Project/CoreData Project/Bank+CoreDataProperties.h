//
//  Bank+CoreDataProperties.h
//  CoreData Project
//
//  Created by cpsc on 10/29/16.
//  Copyright © 2016 cpsc. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Bank.h"

NS_ASSUME_NONNULL_BEGIN

@interface Bank (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *city;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *state;
@property (nullable, nonatomic, retain) NSSet<Person *> *clients;

@end

@interface Bank (CoreDataGeneratedAccessors)

- (void)addClientsObject:(Person *)value;
- (void)removeClientsObject:(Person *)value;
- (void)addClients:(NSSet<Person *> *)values;
- (void)removeClients:(NSSet<Person *> *)values;

@end

NS_ASSUME_NONNULL_END
