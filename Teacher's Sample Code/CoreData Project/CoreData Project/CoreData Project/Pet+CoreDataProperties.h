//
//  Pet+CoreDataProperties.h
//  CoreData Project
//
//  Created by cpsc on 10/29/16.
//  Copyright © 2016 cpsc. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Pet.h"

NS_ASSUME_NONNULL_BEGIN

@interface Pet (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *type;
@property (nullable, nonatomic, retain) Person *owner;

@end

NS_ASSUME_NONNULL_END
