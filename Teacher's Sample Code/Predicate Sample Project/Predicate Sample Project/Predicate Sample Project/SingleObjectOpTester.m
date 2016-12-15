//
//  SingleObjectOpTester.m
//  Predicate Sample Project
//
//  Created by cpsc on 10/30/16.
//  Copyright © 2016 cpsc. All rights reserved.
//

#import "SingleObjectOpTester.h"
#import "Employee.h"
#import "Department.h"

@implementation SingleObjectOpTester

+ (void) performOp
{
    Department * testDept = [[Department alloc] init];
    testDept.name = @"Test_D";
    testDept.employees = [[NSMutableSet alloc] init];
    
    Employee * empObj = [[Employee alloc] init];
    empObj.firstName = @"James";
    empObj.lastName = @"Shen";
    empObj.salary = 50000;
    [testDept.employees addObject:empObj];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.firstName LIKE %@ AND SELF.lastName LIKE %@", @"Ja*", @"S*"];
    if ([predicate evaluateWithObject:empObj]) {
        NSLog(@"Test of Multi-Attribute Objet - Success.");
    } else {
        NSLog(@"Test of Multi-Attribute Objet - Failure.");
    }
    
    NSMutableArray *testArray = [[NSMutableArray alloc] init];
    [testArray addObject:empObj];
    predicate = [NSPredicate predicateWithFormat:@"firstName LIKE %@ AND lastName LIKE %@", @"Ja*", @"S*"];
    NSArray *filteredObjects = [testArray filteredArrayUsingPredicate:predicate];
    if (filteredObjects.count == 1) {
        NSLog(@"Testing Array of Multi-Attribute Objet - Success.");
    } else {
        NSLog(@"Testing Array of Multi-Attribute Objet - Failure.");
    }
    
    empObj = [[Employee alloc] init];
    empObj.firstName = @"John";
    empObj.lastName = @"Chen";
    empObj.salary = 75000;
    [testDept.employees addObject:empObj];
    
    empObj = [[Employee alloc] init];
    empObj.firstName = @"Lily";
    empObj.lastName = @"Hsu";
    empObj.salary = 65000;
    [testDept.employees addObject:empObj];

    predicate = [NSPredicate predicateWithFormat:@"ANY SELF.employees.salary = 50000"];
    if ([predicate evaluateWithObject:testDept]) {
        NSLog(@"Test of Multi-Attribute Objet with ANY operator - Success.");
    } else {
        NSLog(@"Test of Multi-Attribute Objet with ANY operator - Failure.");
    }
    
    predicate = [NSPredicate predicateWithFormat:@"ALL SELF.employees.salary >= 50000"];
    if ([predicate evaluateWithObject:testDept]) {
        NSLog(@"Test of Multi-Attribute Objet with ALL operator - Success.");
    } else {
        NSLog(@"Test of Multi-Attribute Objet with ALL operator - Failure.");
    }
    
    predicate = [NSPredicate predicateWithFormat:@"SELF.employees.@avg.salary > 50000"];
    if ([predicate evaluateWithObject:testDept]) {
        NSLog(@"Test of Multi-Attribute Objet with @avg operator - Success.");
    } else {
        NSLog(@"Test of Multi-Attribute Objet with @avg operator - Failure.");
    }
    
    predicate = [NSPredicate predicateWithFormat:@"SELF.employees.@min.salary = 50000"];
    if ([predicate evaluateWithObject:testDept]) {
        NSLog(@"Test of Multi-Attribute Objet with @min operator - Success.");
    } else {
        NSLog(@"Test of Multi-Attribute Objet with @min operator - Failure.");
    }

    predicate = [NSPredicate predicateWithFormat:@"SUBQUERY(SELF.employees, $employee, $employee.salary = 50000).@count = 1"];
    if ([predicate evaluateWithObject:testDept]) {
        NSLog(@"Test of Multi-Attribute Objet with @count operator - Success.");
    } else {
        NSLog(@"Test of Multi-Attribute Objet with @count operator - Failure.");
    }
    
}

@end
