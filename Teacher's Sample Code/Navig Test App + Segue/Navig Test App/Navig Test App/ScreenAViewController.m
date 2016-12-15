//
//  ScreenAViewController.m
//  Navig Test App
//
//  Created by Shen, Tseng-Ching on 9/29/16.
//  Copyright © 2016 Shen, Tseng-Ching. All rights reserved.
//

#import "ScreenAViewController.h"
#import "ScreenBViewController.h"

@interface ScreenAViewController ()

@end

@implementation ScreenAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {              // Default is 1 if not implemented
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellId" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"Cell %ld", indexPath.row];
    return cell;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    NSLog(@"Segue is being triggered by %@", sender);
    
    ScreenBViewController * destination = segue.destinationViewController;
    destination.test = @"Parameter";
    
}


@end
