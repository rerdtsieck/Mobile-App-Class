//
//  BirthCertificate+CoreDataProperties.h
//  CoreData Project
//
//  Created by cpsc on 10/29/16.
//  Copyright © 2016 cpsc. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "BirthCertificate.h"
#import "Person.h"

NS_ASSUME_NONNULL_BEGIN

@interface BirthCertificate (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *issuedCity;
@property (nullable, nonatomic, retain) NSDate *issuedDate;
@property (nullable, nonatomic, retain) Person *ownedBy;

@end

NS_ASSUME_NONNULL_END
