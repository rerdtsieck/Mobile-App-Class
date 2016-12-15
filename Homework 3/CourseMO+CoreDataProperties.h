//
//  CourseMO+CoreDataProperties.h
//  HW2_Richard_Erdtsieck
//
//  Created by CampusUser on 12/3/16.
//  Copyright © 2016 Richard Erdtsieck. All rights reserved.
//

#import "CourseMO+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface CourseMO (CoreDataProperties)

+ (NSFetchRequest<CourseMO *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *courseID;
@property (nonatomic) double finalWeight;
@property (nonatomic) double hwWeight;
@property (nonatomic) double midtermWeight;
@property (nullable, nonatomic, retain) NSSet<Course_EnrollmentMO *> *courseEnrollmentRelationship;

@end

@interface CourseMO (CoreDataGeneratedAccessors)

- (void)addCourseEnrollmentRelationshipObject:(Course_EnrollmentMO *)value;
- (void)removeCourseEnrollmentRelationshipObject:(Course_EnrollmentMO *)value;
- (void)addCourseEnrollmentRelationship:(NSSet<Course_EnrollmentMO *> *)values;
- (void)removeCourseEnrollmentRelationship:(NSSet<Course_EnrollmentMO *> *)values;

@end

NS_ASSUME_NONNULL_END
