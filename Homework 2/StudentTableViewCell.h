//
//  StudentTableViewCell.h
//  HW2_CPSC411_Richard_Erdtsieck
//
//  Created by CampusUser on 11/5/16.
//  Copyright © 2016 Richard Erdtsieck. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StudentTableViewCell : UITableViewCell

@property (nonatomic) IBOutlet UILabel* firstNameLabel;

@property (nonatomic) IBOutlet UILabel* lastNameLabel;

@property (nonatomic) IBOutlet UILabel* CWIDLabel;
@end
