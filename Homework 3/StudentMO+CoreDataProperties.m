//
//  StudentMO+CoreDataProperties.m
//  HW2_Richard_Erdtsieck
//
//  Created by CampusUser on 12/3/16.
//  Copyright © 2016 Richard Erdtsieck. All rights reserved.
//

#import "StudentMO+CoreDataProperties.h"

@implementation StudentMO (CoreDataProperties)

+ (NSFetchRequest<StudentMO *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Student"];
}

@dynamic courses;
@dynamic cwid;
@dynamic name;
@dynamic courseEnrollmentRelationship;

@end
