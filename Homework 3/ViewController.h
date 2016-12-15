//
//  ViewController.h
//  HW2_Richard_Erdtsieck
//
//  Created by CampusUser on 11/5/16.
//  Copyright © 2016 Richard Erdtsieck. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *studentTableView;
@property (weak,nonatomic) IBOutlet UITableView *coursesTableView;
@property (strong, nonatomic) NSMutableArray *studentArray;
@property (strong, nonatomic) NSMutableArray *cwidArray;
@property (strong, nonatomic) NSMutableArray *enrolledClassesArray;
@property (strong, nonatomic) NSMutableArray *coursesArray;
@property (strong, nonatomic) NSMutableArray *hwArray;
@property (strong, nonatomic) NSMutableArray *mtArray;
@property (strong, nonatomic) NSMutableArray *finalArray;



@end

