//
//  coursesTableViewCell.h
//  HW2_Richard_Erdtsieck
//
//  Created by CampusUser on 11/6/16.
//  Copyright © 2016 Richard Erdtsieck. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface coursesTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *courseIDLabel;
@property (nonatomic, weak) IBOutlet UILabel *hwLabel;
@property (nonatomic, weak) IBOutlet UILabel *mtLabel;
@property (nonatomic, weak) IBOutlet UILabel *finalLabel;

@end
