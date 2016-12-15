//
//  studentTableViewCell.h
//  HW2_Richard_Erdtsieck
//
//  Created by CampusUser on 11/6/16.
//  Copyright © 2016 Richard Erdtsieck. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface studentTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *cwidLabel;
@property (nonatomic, weak) IBOutlet UILabel *coursesLabel;

@end
