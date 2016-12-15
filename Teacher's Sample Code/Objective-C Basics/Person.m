//
//  Person.m
//  foo
//
//  Created by James Tseng-Ching Shen on 8/19/16.
//  Copyright © 2016 James Tseng-Ching Shen. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Person.h"

@implementation Person

-(id) init
{
    self = [super init];
    return self;
}

-(void) setFirstName: (char*) sName
{
    strFirstName = sName;
}

-(void) setLastName: (char*) sName
{
    strLastName = sName;
}

-(void) setAge: (int) iNo
{
    iAge = iNo;
}

-(void) setSSN: (char *) strNo
{
    strSSN = strNo;
}

-(char *) getDescription
{
    strDesc = malloc(200 * sizeof(char));
    
    sprintf(strDesc, "First Name: %s Last Name: %s Age: %d SSN: %s", strFirstName, strLastName, iAge, strSSN);
    
    return strDesc;
}

-(void) dealloc
{
    NSLog(@"Start freeing memory now ");
    
    free(strDesc);      // This is manually freed 
    strDesc = nil;
    // [super dealloc];     // No need to call this for ARC classes
    
    NSLog(@"Finish freeing memory ");
}

@end
