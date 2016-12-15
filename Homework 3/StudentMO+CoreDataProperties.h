//
//  StudentMO+CoreDataProperties.h
//  HW2_Richard_Erdtsieck
//
//  Created by CampusUser on 12/3/16.
//  Copyright © 2016 Richard Erdtsieck. All rights reserved.
//

#import "StudentMO+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface StudentMO (CoreDataProperties)

+ (NSFetchRequest<StudentMO *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *courses;
@property (nullable, nonatomic, copy) NSString *cwid;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, retain) Course_EnrollmentMO *courseEnrollmentRelationship;

@end

NS_ASSUME_NONNULL_END
