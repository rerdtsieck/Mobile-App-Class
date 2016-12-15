//
//  course.h
//  HW2_Richard_Erdtsieck
//
//  Created by CampusUser on 12/3/16.
//  Copyright © 2016 Richard Erdtsieck. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface course : NSManagedObject

@property NSString *courseID;
@property NSInteger homeworkWeight;
@property NSInteger midtermWeight;
@property NSInteger finalWeight;

@end
