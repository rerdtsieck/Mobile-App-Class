//
//  ViewController.m
//  Appliation Concurrency
//
//  Created by cpsc on 11/6/16.
//  Copyright © 2016 cpsc. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()

@end

@implementation ViewController

AppDelegate *appDelegate;
dispatch_block_t uiBlockObject;
/*
- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    NSLog(@"The keyPath is %@ Thread is %@", keyPath, [NSThread currentThread]);
    if ([keyPath isEqualToString:@"objects"]) {
        NSLog(@"ViewController has been notified the changes of AppDelegate property objects %ld", ((AppDelegate *)object).objects.count);
    }
    //
    if ([keyPath isEqualToString:@"changedObjects"]) {
        NSLog(@"ViewController has been notified the changes of AppDelegate property changedObjects[2] %@ %@",
              ((AppDelegate *)object).changedObjects[2], change);
    }
    if ([keyPath isEqualToString:@"testName"]) {
        NSLog(@"ViewController has been notified the changes of AppDelegate property testName %@ %@",
              ((AppDelegate *)object).testName, change);
    }
    
    //dispatch_queue_t mainQueue = dispatch_get_main_queue();
    //dispatch_async(mainQueue, uiBlockObject);
    
} */ 

- (void) updateCntlLabel {
    self.objCntLabel.text = [[NSString alloc] initWithFormat:@"Object Count is %ld", appDelegate.objects.count];
    [self.view setNeedsDisplay];
}

- (void) addObjects {
    [appDelegate appendNewString];
    int i = 0;
    while (i <= 2) {
        [NSThread sleepForTimeInterval:1.0f];
        i++;
    }
}

- (void) addObjectsWithTimer {
    [appDelegate appendNewString];
    [self performSelectorOnMainThread:@selector(updateCntlLabel) withObject:nil waitUntilDone:NO];
}

- (void) addObjectsWithNotification {
    [appDelegate appendNewString];
    
    // post nofification
    NSNotification * notification = [NSNotification notificationWithName:@"TestUpdateObject" object:self
                                                                userInfo:@{@"updatedCount" : [NSString stringWithFormat:@"%ld", appDelegate.objects.count]}];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center postNotification:notification];
}

- (void) buildObjects {
    bool cont = true;
    appDelegate.objects = [[NSMutableArray alloc] init];
    while (cont) {
        //
        NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(addObjects) object:nil];
        [op start];
        //
        [self performSelectorOnMainThread:@selector(updateCntlLabel) withObject:nil waitUntilDone:NO];
        
        // Dispatch another UI task
        //dispatch_async(dispatch_get_main_queue(), uiBlockObject);
        
        if (appDelegate.objects.count >= 5000) cont = false;
    }
}

- (void) buildObjectsUsingThread {
    @autoreleasepool {
        bool cont = true;
        appDelegate.objects = [[NSMutableArray alloc] init];
        while (cont) {
            //
            NSLog(@"Thread continues...");
            [self addObjects];
            //
            [self performSelectorOnMainThread:@selector(updateCntlLabel) withObject:nil waitUntilDone:NO];
            
            if (appDelegate.objects.count >= 5000) cont = false;
        }
    }
}

- (void) testGCD {
    appDelegate = [UIApplication sharedApplication].delegate;
    
    // Get a concurrent queue
    dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    // Dispatch the block object
    dispatch_async(concurrentQueue, ^{
        bool cont = true;
        appDelegate.objects = [[NSMutableArray alloc] init];
        while (cont) {
            
            [self addObjects];
            
            // Dispatch another UI task
            dispatch_async(dispatch_get_main_queue(), uiBlockObject);
            
            if (appDelegate.objects.count >= 5000) cont = false;
        }
        
    });
    
    //dispatch_async(concurrentQueue, ^{
    //    [appDelegate updateChangedString];
    //});
    //dispatch_async(concurrentQueue, ^{
    //    [appDelegate updateTestName];
    //});
    //
    //[appDelegate addObserver:self forKeyPath:@"objects" options:NSKeyValueObservingOptionNew context:NULL];
    //[appDelegate addObserver:self forKeyPath:@"testName" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
}

- (void)testOperation {
    appDelegate = [UIApplication sharedApplication].delegate;
    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(buildObjects) object:nil];
    operation.completionBlock = uiBlockObject;
    NSOperationQueue *opQueue = [[NSOperationQueue alloc] init];
    //
    operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(buildObjects) object:nil];
    //operation.completionBlock = ^{
    //    self.objCntLabel.text = [[NSString alloc] initWithFormat:@"Background Job Finished"];};
    [opQueue addOperation:operation];
}

- (void)testThread {
    appDelegate.tThread = [[NSThread alloc] initWithTarget:self selector:@selector(buildObjectsUsingThread) object:nil];
    [appDelegate.tThread start];
    // [NSThread detachNewThreadSelector:@selector(buildObjectsUsingThread) toTarget:self withObject:nil];
}

- (void)testTimer {
    appDelegate.objects = [[NSMutableArray alloc] init];
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(addObjectsWithTimer) userInfo:nil repeats:YES];
}

- (void)handleUpdateObjNotification: (NSNotification *)paramNotification {
    // NSLog(@"Thread Refresh Update Object Cout %@", [NSThread currentThread]);
    self.objCntLabel.text = paramNotification.userInfo[@"updatedCount"];
}

- (void)testNotification {
    appDelegate.objects = [[NSMutableArray alloc] init];
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(addObjectsWithNotification) userInfo:nil repeats:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"Invokine viewDidLoad Main Thread %@", [NSThread mainThread]);
    
    appDelegate = [UIApplication sharedApplication].delegate;
    self.objects = appDelegate.objects;
    self.counter = 0;
    self.objCntLabel.text = @"Un-initialized Yet ...";
    self.objUsrUpdLabel.text = [[NSString alloc] initWithFormat:@"Current Number is %d", self.counter];
    
    // Initialize the block object
    uiBlockObject = ^{
        NSLog(@"Refresh the UI screen %@", [NSThread currentThread]);
        self.objCntLabel.text = [[NSString alloc] initWithFormat:@"Object Count is %ld", appDelegate.objects.count];};
    
    //[self testGCD];
    
    //[self testOperation];
    
    [self testThread];
    
    // [self testTimer];

    //[self testNotification];
    //NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    //[center addObserver:self selector:@selector(handleUpdateObjNotification:) name:@"TestUpdateObject" object:self];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)updateUpdLabel:(id)sender {
    NSLog(@"Update action Thread : %@", [NSThread currentThread]);
    self.counter += 5;
    self.objUsrUpdLabel.text = [[NSString alloc] initWithFormat:@"Current Number is %d", self.counter];
}
@end
