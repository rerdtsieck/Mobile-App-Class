//
//  Course_EnrollmentMO+CoreDataProperties.m
//  HW2_Richard_Erdtsieck
//
//  Created by CampusUser on 12/3/16.
//  Copyright © 2016 Richard Erdtsieck. All rights reserved.
//

#import "Course_EnrollmentMO+CoreDataProperties.h"

@implementation Course_EnrollmentMO (CoreDataProperties)

+ (NSFetchRequest<Course_EnrollmentMO *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Course_Enrollment"];
}

@dynamic avgHwScore;
@dynamic finalScore;
@dynamic midtermScore;
@dynamic courseRelationship;
@dynamic studentRelationship;

@end
