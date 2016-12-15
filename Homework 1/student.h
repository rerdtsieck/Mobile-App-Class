//
//  student.h
//  CPSC411_Assignment1_RichardErdtsieck
//
//  Created by CampusUser on 9/24/16.
//  Copyright © 2016 Richard Erdtsieck. All rights reserved.
//

#ifndef student_h
#define student_h

@interface Student : NSObject

@property NSString *firstName;
@property NSString *lastName;
@property NSString *CWID;

@property NSMutableArray *courseIDs;
@property NSMutableDictionary *courseInfo;
@property NSMutableDictionary *finalGrades;

@property int numOfCourses;

-(void) setCourseInfo:(NSMutableDictionary *) incDictionary;
-(NSMutableDictionary *) getCourseInfo;

//This function takes the information stored in student and uses it to calculate and fill the finalGrades Dictionary
-(void) calcScores;
-(void) printStudentInfo;
@end

#endif /* student_h */
