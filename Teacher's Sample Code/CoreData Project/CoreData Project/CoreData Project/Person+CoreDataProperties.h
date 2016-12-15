//
//  Person+CoreDataProperties.h
//  CoreData Project
//
//  Created by cpsc on 10/29/16.
//  Copyright © 2016 cpsc. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Person.h"

NS_ASSUME_NONNULL_BEGIN

@interface Person (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *dateOfBirth;
@property (nullable, nonatomic, retain) NSString *firstName;
@property (nullable, nonatomic, retain) NSString *lastName;
@property (nullable, nonatomic, retain) NSString *ssn;
@property (nullable, nonatomic, retain) NSSet<Bank *> *banks;
@property (nullable, nonatomic, retain) BirthCertificate *birthCert;
@property (nullable, nonatomic, retain) NSSet<Pet *> *pets;

@end

@interface Person (CoreDataGeneratedAccessors)

- (void)addBanksObject:(Bank *)value;
- (void)removeBanksObject:(Bank *)value;
- (void)addBanks:(NSSet<Bank *> *)values;
- (void)removeBanks:(NSSet<Bank *> *)values;

- (void)addPetsObject:(Pet *)value;
- (void)removePetsObject:(Pet *)value;
- (void)addPets:(NSSet<Pet *> *)values;
- (void)removePets:(NSSet<Pet *> *)values;

@end

NS_ASSUME_NONNULL_END
