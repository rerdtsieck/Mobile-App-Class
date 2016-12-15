//
//  Person.h
//  archive project
//
//  Created by cpsc on 10/1/16.
//  Copyright © 2016 cpsc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject <NSCoding> 

@property(nonatomic, strong) NSString * firstName;
@property(nonatomic, strong) NSString * lastName;
@property(nonatomic, strong) NSString * CWID; 
@property(nonatomic, strong) NSMutableArray * courseList;

@end
