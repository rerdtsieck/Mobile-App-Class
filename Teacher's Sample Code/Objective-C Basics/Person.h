//
//  Person.h
//  foo
//
//  Created by James Tseng-Ching Shen on 8/19/16.
//  Copyright © 2016 James Tseng-Ching Shen. All rights reserved.
//

#ifndef Person_h
#define Person_h

@interface Person : NSObject
{
    @protected char * strFirstName;     // default visibility is 'protected'
    @protected char * strLastName;
    @protected int iAge;
    @protected char * strSSN;
    
    @protected char * strDesc;
}

-(id) init;             // Default constructor need to be explictly declared 
-(void) setFirstName: (char *) strName;
-(void) setLastName: (char *) strName;
-(void) setAge: (int) iNumber;
-(void) setSSN: (char *) strNo;

-(char *) getDescription; 

-(void) dealloc;        // Override this method because of dynamically allocated memory

@end

#endif /* Person_h */
