//
//  Person.m
//  archive project
//
//  Created by cpsc on 10/1/16.
//  Copyright © 2016 cpsc. All rights reserved.
//

#import "Person.h"

@implementation Person

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.firstName forKey:@"FirstNameKey"];
    [aCoder encodeObject:self.lastName forKey:@"LastNameKey"];
    [aCoder encodeObject:self.CWID forKey:@"CWIDKey"];
    
    [aCoder encodeObject:self.courseList forKey:@"CourseList"];
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    
    self.firstName = [aDecoder decodeObjectForKey:@"FirstNameKey"];
    self.lastName = [aDecoder decodeObjectForKey:@"LastNameKey"];
    self.CWID = [aDecoder decodeObjectForKey:@"CWIDKey"];
    
    self.courseList = [aDecoder decodeObjectForKey:@"CourseList"]; 
    
    return self;
}

@end
