//
//  ViewController2.m
//  Gesture Processing
//
//  Created by cpsc on 11/13/16.
//  Copyright © 2016 cpsc. All rights reserved.
//

#import "ViewController2.h"

@interface ViewController2 ()
@property (nonatomic, strong) UISwipeGestureRecognizer *swipeGestureRecognizerL;
@property (nonatomic, strong) UISwipeGestureRecognizer *swipeGestureRecognizerR;
@end

@implementation ViewController2


- (void) handleSwipes: (UISwipeGestureRecognizer *)paramSender {
    if (paramSender.direction == UISwipeGestureRecognizerDirectionLeft) {
        NSLog(@"Going back to the previous screen.");
        UIViewController *svc = [self.storyboard instantiateViewControllerWithIdentifier:@"VC1"];
        //NSLog(@"Current View Controller %@", self);
        //NSLog(@"Root View Controller %@", svc);
        [self presentViewController:svc animated:YES completion:nil];
    } else {
        NSLog(@"Doing nothing.");
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    self.swipeGestureRecognizerL = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    self.swipeGestureRecognizerL.direction = UISwipeGestureRecognizerDirectionLeft;
    self.swipeGestureRecognizerL.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:self.swipeGestureRecognizerL];
    //
    self.swipeGestureRecognizerR = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    self.swipeGestureRecognizerR.direction = UISwipeGestureRecognizerDirectionRight;
    self.swipeGestureRecognizerR.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:self.swipeGestureRecognizerR];
 
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
