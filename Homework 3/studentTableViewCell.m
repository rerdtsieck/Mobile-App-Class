//
//  studentTableViewCell.m
//  HW2_Richard_Erdtsieck
//
//  Created by CampusUser on 11/6/16.
//  Copyright © 2016 Richard Erdtsieck. All rights reserved.
//

#import "studentTableViewCell.h"

@implementation studentTableViewCell

@synthesize nameLabel = _nameLabel;
@synthesize cwidLabel = _cwidLabel;
@synthesize coursesLabel = _coursesLabel;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
