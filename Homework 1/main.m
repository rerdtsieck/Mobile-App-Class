//
//  main.m
//  CPSC411_Assignment1_RichardErdtsieck
//
//  Created by CampusUser on 9/20/16.
//  Copyright © 2016 Richard Erdtsieck. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "student.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        char firstName[30];
        char lastName[30];
        char cwid[30];
        //Used to store the course info before its put into Student
        NSMutableDictionary *courses = [[NSMutableDictionary alloc] init];
        
        NSString *courseID;
        NSString *avgHomework;
        NSString *midtermScore;
        NSString *finalScore;
        NSString *homeworkWeight;
        NSString *midtermWeight;
        NSString *finalWeight;
        
        NSMutableArray *listOfCourseID = [[NSMutableArray alloc] init];
        
        int numOfCourses;
        
        Student *student = [[Student alloc] init];
        
        //Following code asks for student information and stores it in the Student Object as NSStrings
        NSLog(@"\nPlease enter your first name: ");
        scanf("%s", firstName);
        student.firstName = [NSString stringWithCString:firstName encoding:1];
        
        NSLog(@"\nPlease enter your last name: ");
        scanf("%s", lastName);
        student.lastName = [NSString stringWithCString:lastName encoding:1];
        
        NSLog(@"\nPlease enter your CWID: ");
        scanf("%s", cwid);
        student.CWID = [NSString stringWithCString:cwid encoding:1];
        
        //Find out how many times we have to loop through to get course information
        NSLog(@"\nHow many courses are you taking");
        scanf("%d", &numOfCourses);
        
        student.numOfCourses = numOfCourses;
        
        //This variable is for storing the values as we get them and then to convert to NSString
        char temp[10];
        
        //Gather information about the Courses
        for (int i = 0; i < numOfCourses; i++)
        {
            NSLog(@"\nPlease enter the course ID:");
            scanf("%s", temp);
            courseID = [NSString stringWithCString:temp encoding:1];
            
            [listOfCourseID addObject:courseID];
            
            NSLog(@"\nPlease enter your average homework score:");
            scanf("%s", temp);
            avgHomework = [NSString stringWithCString:temp encoding:1];
            
            NSLog(@"\nPlease enter the weight of your homework as an integer. ex 20 for 20%%");
            scanf("%s", temp);
            homeworkWeight = [NSString stringWithCString:temp encoding:1];
            
            NSLog(@"\nPlease enter your Midterm grade");
            scanf("%s",temp);
            midtermScore = [NSString stringWithCString:temp encoding:1];
            
            NSLog(@"\nPlease enter the weight of your midterm as an integer. ex 20 for 20%%");
            scanf("%s", temp);
            midtermWeight = [NSString stringWithCString:temp encoding:1];
            
            NSLog(@"\nPlease enter your Final grade");
            scanf("%s", temp);
            finalScore = [NSString stringWithCString:temp encoding:1];
            
            NSLog(@"\nPlease enter the weight of your final as an integer. ex 20 for 20%%");
            scanf("%s", temp);
            finalWeight = [NSString stringWithCString:temp encoding:1];
            
            [courses setValue:@[avgHomework, midtermScore, finalScore, homeworkWeight, midtermWeight, finalWeight] forKey:courseID];
            
            [student setCourseInfo:courses];
        }
        student.courseIDs = listOfCourseID;
        
        //Calculate the final grades for the classes
        [student calcScores];
        
        [student printStudentInfo];
    }
    return 0;
}
