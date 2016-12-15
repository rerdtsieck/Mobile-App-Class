//
//  main.m
//  Predicate Sample Project
//
//  Created by cpsc on 10/30/16.
//  Copyright © 2016 cpsc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SingleValOpTester.h"
#import "SingleObjectOpTester.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        [SingleValOpTester performOp];

        [SingleObjectOpTester performOp];
        
    }
    return 0;
}
