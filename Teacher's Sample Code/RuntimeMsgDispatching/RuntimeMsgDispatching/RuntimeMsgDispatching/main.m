//
//  main.m
//  RuntimeMsgDispatching
//
//  Created by cpsc on 10/22/16.
//  Copyright © 2016 cpsc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        // NSLog(@"Hello, World!");
        Person * p = [[Person alloc] init];
        
        p.firstName = @"John";

        NSString * name = p.firstName;
        NSLog(@"First Name returned: %@", name);

        // [p testFunctionCall];
        
        NSString * inputString = @"Parameter 1";
        [p performSelector:NSSelectorFromString(@"testFunctionCall:") withObject:(inputString)];
        
    }
    return 0;
}
