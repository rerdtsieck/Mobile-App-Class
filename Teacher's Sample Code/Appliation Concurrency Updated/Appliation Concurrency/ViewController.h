//
//  ViewController.h
//  Appliation Concurrency
//
//  Created by cpsc on 11/6/16.
//  Copyright © 2016 cpsc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic) int counter; 
@property (nonatomic, weak) NSMutableArray *objects;
@property (strong, nonatomic) IBOutlet UILabel *objCntLabel;
@property (strong, nonatomic) IBOutlet UILabel *objUsrUpdLabel;
@property (strong, nonatomic) IBOutlet UIButton *cntUpdButton;
- (IBAction)updateUpdLabel:(id)sender;

@end

