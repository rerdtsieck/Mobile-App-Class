//
//  ScreenBViewController.m
//  Navig Test App
//
//  Created by Shen, Tseng-Ching on 10/4/16.
//  Copyright © 2016 Shen, Tseng-Ching. All rights reserved.
//

#import "ScreenBViewController.h"

@interface ScreenBViewController ()

@end

@implementation ScreenBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.testLabel.text = self.test;
    
    // get the previous view controller
    NSInteger myIndex = [self.navigationController.viewControllers indexOfObject:self];
    UIViewController *prevViewController = [self.navigationController.viewControllers objectAtIndex:myIndex-1];
    
    NSLog(@"The Class Type of previous View Controller : %@", [prevViewController class]);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
