//
//  student.m
//  CPSC411_Assignment1_RichardErdtsieck
//
//  Created by CampusUser on 9/24/16.
//  Copyright © 2016 Richard Erdtsieck. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "student.h"

@implementation Student

-(void) addCourseInfo:(NSMutableDictionary *) incDictionary
{
    self.courseInfo = incDictionary;
}

-(NSMutableDictionary *) getCourseInfo
{
    return self.courseInfo;
}

//This function takes the information stored in student and uses it to calculate and fill the finalGrades Dictionary
-(void) calcScores
{
    NSMutableDictionary *finalGrades = [[NSMutableDictionary alloc] init];
    
    for (int i = 0; i < self.numOfCourses; i++)
    {
        NSString *currentClass = self.courseIDs[i];
        double totalScore = 0;
        double homeworkScore = 0;
        double midtermScore = 0;
        double finalScore = 0;
        
        NSArray *classInfo = [self.courseInfo valueForKey:currentClass];
        
        //Individually calculate the scores for HW, MidTerm, FInal
        homeworkScore = [classInfo[0] doubleValue] * ([classInfo[3] doubleValue]/100);
        midtermScore = [classInfo[1] doubleValue] * ([classInfo[4] doubleValue]/100);
        finalScore = [classInfo[2] doubleValue] * ([classInfo[5] doubleValue]/100);
        
        //Add up the scores to find total
        totalScore = homeworkScore + midtermScore + finalScore;
        
        [finalGrades setValue:[NSNumber numberWithDouble:totalScore] forKey: currentClass];
        
    }

    self.finalGrades = finalGrades;
}

-(void) printStudentInfo
{
    NSLog(@"\nStudent Info \nFirstName: %@ \nLast Name: %@ \nCWID: %@", self.firstName, self.lastName, self.CWID);

    for(id key in self.finalGrades)
        NSLog(@"\nCourse ID: %@, Final Grade: %@%% \n", key, [self.finalGrades objectForKey:key]);
}

@end
