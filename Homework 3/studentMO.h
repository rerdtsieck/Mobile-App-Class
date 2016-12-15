//
//  student.h
//  HW2_Richard_Erdtsieck
//
//  Created by CampusUser on 12/3/16.
//  Copyright © 2016 Richard Erdtsieck. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface student : NSManagedObject

@property NSString* name;
@property NSString* cwid;
//@property NSString* courseList;
@property NSMutableSet *courseList;

@end
