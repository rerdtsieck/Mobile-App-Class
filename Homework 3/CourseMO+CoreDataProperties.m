//
//  CourseMO+CoreDataProperties.m
//  HW2_Richard_Erdtsieck
//
//  Created by CampusUser on 12/3/16.
//  Copyright © 2016 Richard Erdtsieck. All rights reserved.
//

#import "CourseMO+CoreDataProperties.h"

@implementation CourseMO (CoreDataProperties)

+ (NSFetchRequest<CourseMO *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Course"];
}

@dynamic courseID;
@dynamic finalWeight;
@dynamic hwWeight;
@dynamic midtermWeight;
@dynamic courseEnrollmentRelationship;

@end
