//
//  Course_EnrollmentMO+CoreDataProperties.h
//  HW2_Richard_Erdtsieck
//
//  Created by CampusUser on 12/3/16.
//  Copyright © 2016 Richard Erdtsieck. All rights reserved.
//

#import "Course_EnrollmentMO+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Course_EnrollmentMO (CoreDataProperties)

+ (NSFetchRequest<Course_EnrollmentMO *> *)fetchRequest;

@property (nonatomic) double avgHwScore;
@property (nonatomic) double finalScore;
@property (nonatomic) double midtermScore;
@property (nullable, nonatomic, retain) CourseMO *courseRelationship;
@property (nullable, nonatomic, retain) NSSet<StudentMO *> *studentRelationship;

@end

@interface Course_EnrollmentMO (CoreDataGeneratedAccessors)

- (void)addStudentRelationshipObject:(StudentMO *)value;
- (void)removeStudentRelationshipObject:(StudentMO *)value;
- (void)addStudentRelationship:(NSSet<StudentMO *> *)values;
- (void)removeStudentRelationship:(NSSet<StudentMO *> *)values;

@end

NS_ASSUME_NONNULL_END
