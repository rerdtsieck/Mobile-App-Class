//
//  SingleValOpTester.m
//  Predicate Sample Project
//
//  Created by cpsc on 10/30/16.
//  Copyright © 2016 cpsc. All rights reserved.
//

#import "SingleValOpTester.h"

@implementation SingleValOpTester

+ (void) performOp
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF = %@",@"test"];
    NSString *testString = @"test";
    if ([predicate evaluateWithObject:testString]) NSLog(@"Test = operator - Success. ");
    else NSLog(@"Test = operator - Failure");
    
    predicate = [NSPredicate predicateWithFormat:@"SELF = %d",1];
    NSNumber *testInt = [[NSNumber alloc] initWithInt:1];
    if ([predicate evaluateWithObject:testInt]) NSLog(@"Test Integer = operator - Success. ");
    else NSLog(@"Test = operator - Failure");
    
    predicate = [NSPredicate predicateWithFormat:@"SELF <> %d",2];
    testInt = [[NSNumber alloc] initWithInt:1];
    if ([predicate evaluateWithObject:testInt]) NSLog(@"Test <> operator - Success. ");
    else NSLog(@"Test = operator - Failure");
    
    predicate = [NSPredicate predicateWithFormat:@"SELF LIKE %@",@"*es*"];
    testString = @"test";
    if ([predicate evaluateWithObject:testString]) NSLog(@"Test LIKE operator - Success. ");
    else NSLog(@"Test = operator - Failure");
    
    predicate = [NSPredicate predicateWithFormat:@"SELF LIKE %@ AND SELF LIKE %@",@"*es*", @"*st"];
    testString = @"test";
    if ([predicate evaluateWithObject:testString]) NSLog(@"Test AND operator - Success. ");
    else NSLog(@"Test = operator - Failure");
    
    predicate = [NSPredicate predicateWithFormat:@"SELF BEGINSWITH %@",@"te"];
    testString = @"test";
    if ([predicate evaluateWithObject:testString]) NSLog(@"Test BEGINSWITH operator - Success. ");
    else NSLog(@"Test = operator - Failure");
    
    NSArray *objects = [NSArray arrayWithObjects:@"art",@"test",@"bad", @"good", nil];
    predicate = [NSPredicate predicateWithFormat:@"SELF IN %@",objects];
    testString = @"test";
    if ([predicate evaluateWithObject:testString]) NSLog(@"Test IN operator - Success. ");
    else NSLog(@"Test = operator - Failure");
        
}

@end
