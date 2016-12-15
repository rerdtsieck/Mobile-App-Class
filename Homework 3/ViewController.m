//
//  ViewController.m
//  HW2_Richard_Erdtsieck
//
//  Created by CampusUser on 11/5/16.
//  Copyright © 2016 Richard Erdtsieck. All rights reserved.
//

#import "ViewController.h"
#include "coursesTableViewCell.h"
#include "studentTableViewCell.h"
#include "AppDelegate.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *student;
@property (weak, nonatomic) IBOutlet UITableView *courses;
@property (strong, nonatomic) UIAlertController *alertCtrl;
@property (nonatomic, strong) NSFetchedResultsController *fetchedStudentResultsController;
@property (nonatomic, strong) NSFetchedResultsController *fetchedCourseResultsController;

@end

@implementation ViewController

NSManagedObjectContext *context;

- (void)initializeFetchedResultsController
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Student"];
    
    NSSortDescriptor *nameSort = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    
    [request setSortDescriptors:@[nameSort]];
    
    //NSManagedObjectContext *moc = …; //Retrieve the main queue NSManagedObjectContext
    
    [self setFetchedStudentResultsController:[[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:context sectionNameKeyPath:nil cacheName:nil]];
    [[self fetchedStudentResultsController] setDelegate:self];
    
    NSError *error = nil;
    if (![[self fetchedStudentResultsController] performFetch:&error]) {
        NSLog(@"Failed to initialize FetchedStudentResultsController: %@\n%@", [error localizedDescription], [error userInfo]);
        abort();
    }
    
    NSFetchRequest *requestCourse = [NSFetchRequest fetchRequestWithEntityName:@"Course"];
    
    NSSortDescriptor *courseIDSort = [NSSortDescriptor sortDescriptorWithKey:@"courseID" ascending:YES];
    
    [requestCourse setSortDescriptors:@[courseIDSort]];
    
    //NSManagedObjectContext *moc = …; //Retrieve the main queue NSManagedObjectContext
    
    [self setFetchedCourseResultsController:[[NSFetchedResultsController alloc] initWithFetchRequest:requestCourse managedObjectContext:context sectionNameKeyPath:nil cacheName:nil]];
    [[self fetchedCourseResultsController] setDelegate:self];
    
    NSError *errorCourse = nil;
    if (![[self fetchedCourseResultsController] performFetch:&errorCourse]) {
        NSLog(@"Failed to initialize FetchedCourseResultsController: %@\n%@", [errorCourse localizedDescription], [errorCourse userInfo]);
        abort();
    }

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self arraySetUp];
    
    AppDelegate *appdelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    context = [appdelegate managedObjectContext];
    
    [self initializeFetchedResultsController];
    
    }

-(void) arraySetUp
{
    _studentArray = [[NSMutableArray alloc] init];
    _cwidArray = [[NSMutableArray alloc] init];
    _coursesArray = [[NSMutableArray alloc] init];
    _enrolledClassesArray = [[NSMutableArray alloc] init];
    _hwArray = [[NSMutableArray alloc] init];
    _mtArray = [[NSMutableArray alloc] init];
    _finalArray = [[NSMutableArray alloc] init];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(tableView == self.student)
    {
        return [[[self fetchedStudentResultsController]sections]count];
    }
    else
    {
        return [[[self fetchedCourseResultsController]sections]count];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    /*if(tableView == self.student)
        return _studentArray.count;
    else
        return _coursesArray.count;
     */
    if (tableView == self.student)
    {
        id<NSFetchedResultsSectionInfo> sectionInfo = [[self fetchedStudentResultsController]sections][section];
        return [sectionInfo numberOfObjects];
    }
    else
    {
        id<NSFetchedResultsSectionInfo> sectionInfo = [[self fetchedCourseResultsController]sections][section];
        return [sectionInfo numberOfObjects];
    }
}

-(void)configureStudentCell:(studentTableViewCell*)cell atIndexPath:(NSIndexPath*)indexPath
{
    NSManagedObject *studentObject = [[self fetchedStudentResultsController] objectAtIndexPath:indexPath];
    
    cell.nameLabel.text = [studentObject valueForKey:@"name"];
    cell.cwidLabel.text = [studentObject valueForKey:@"cwid"];
    cell.coursesLabel.text = [studentObject valueForKey:@"courses"];
    
}

-(void)configureCourseCell:(coursesTableViewCell*)cell atIndexPath:(NSIndexPath*)indexPath
{
    NSManagedObject *courseObject = [[self fetchedCourseResultsController] objectAtIndexPath:indexPath];
    
    NSString *temp = [NSString stringWithFormat:@"%@", [courseObject valueForKey:@"hwWeight"]];
    //NSInteger *tempInt;
    //tempInt = [NSNumber numberWithInteger:[temp integerValue]];
    
    cell.courseIDLabel.text = [courseObject valueForKey:@"courseID"];
    
    cell.hwLabel.text = temp;
    //cell.hwLabel.text = [courseObject valueForKey:@"hwWeight"];
    
    //cell.mtLabel.text = [courseObject valueForKey:@"midtermWeight"];
    temp = [NSString stringWithFormat:@"%@", [courseObject valueForKey:@"midtermWeight"]];
    cell.mtLabel.text = temp;
    
    //cell.finalLabel.text = [courseObject valueForKey:@"finalWeight"];
    temp = [NSString stringWithFormat:@"%@", [courseObject valueForKey:@"finalWeight"]];
    cell.finalLabel.text = temp;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    
    if (tableView == self.student)
    {
        studentTableViewCell *customCell = (studentTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"cell"];

        [self configureStudentCell:customCell atIndexPath:indexPath];
        
        return customCell;
        /*
        studentTableViewCell *customCell = (studentTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
        
        customCell.nameLabel.text = [self.studentArray objectAtIndex:indexPath.row];
        customCell.cwidLabel.text = [self.cwidArray objectAtIndex:indexPath.row];
        customCell.coursesLabel.text = [self.enrolledClassesArray objectAtIndex:indexPath.row];
        
        return customCell;
        */
    }
    else
    {
        coursesTableViewCell *customCell = (coursesTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
        
        [self configureCourseCell:customCell atIndexPath:indexPath];
        /*customCell.courseIDLabel.text = [self.coursesArray objectAtIndex:indexPath.row];
        customCell.hwLabel.text = [self.hwArray objectAtIndex:indexPath.row];
        customCell.mtLabel.text = [self.mtArray objectAtIndex:indexPath.row];
        customCell.finalLabel.text = [self.finalArray objectAtIndex:indexPath.row];
        */
         return customCell;
        
    }
    return cell;
}

-(void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    [_studentTableView setEditing:editing animated:animated];
    [_coursesTableView setEditing:editing animated:animated];
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)NSIndexPath
{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        if (tableView == self.student)
        {
            [_studentArray removeObjectAtIndex:indexPath.row];
            [_cwidArray removeObjectAtIndex:indexPath.row];
            [_enrolledClassesArray removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
        else
        {
            [_coursesArray removeObjectAtIndex:indexPath.row];
            [_hwArray removeObjectAtIndex:indexPath.row];
            [_mtArray removeObjectAtIndex:indexPath.row];
            [_finalArray removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
    }
}
- (IBAction)addStudentAction:(id)sender
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Add Student" message:@""  preferredStyle:UIAlertControllerStyleAlert];
    
    //Name
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField){
        textField.placeholder = @"Name";
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.borderStyle = UITextBorderStyleRoundedRect;
    }];
    
    //CWID
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField){
        textField.placeholder = @"CWID";
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.borderStyle = UITextBorderStyleRoundedRect;
    }];
    
    //Enrolled Classes
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField){
        textField.placeholder = @"Seperate enrolled classes by a space";
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.borderStyle = UITextBorderStyleRoundedRect;
    }];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Add Student" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSString *name = ((UITextField *)[alert.textFields objectAtIndex:0]).text;
        NSString *CWID = ((UITextField *)[alert.textFields objectAtIndex:1]).text;
        NSString *enrolled = ((UITextField *)[alert.textFields objectAtIndex:2]).text;
        
        //NEW
        
        AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
        NSManagedObjectContext *context = appDelegate.managedObjectContext;
        
        NSManagedObject *newStudent = [NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext:context];
        
        [newStudent setValue:name forKey:@"name"];
        [newStudent setValue:CWID forKey:@"cwid"];
        [newStudent setValue:enrolled forKey:@"courses"];
        [context save:nil];
        
        //END
        
        //[_studentArray insertObject:name atIndex:0];
        //[_cwidArray insertObject:CWID atIndex:0];
        //[_enrolledClassesArray insertObject:enrolled atIndex:0];
        
        NSIndexPath * indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        
        //[self.student reloadData];
        
        studentTableViewCell *customCell = (studentTableViewCell*)[self.student dequeueReusableCellWithIdentifier:@"cell"];
        
        [self configureStudentCell:customCell atIndexPath:indexPath];
        
        //[self.student insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        //[self.student reloadData];
    }];
    
    [alert addAction:defaultAction];
   
    [self presentViewController:alert animated:YES completion:nil];
 
}

- (IBAction)coursesAddAction:(id)sender
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Add a Course" message:@""  preferredStyle:UIAlertControllerStyleAlert];
    
    //course ID
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField){
        textField.placeholder = @"Course ID";
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.borderStyle = UITextBorderStyleRoundedRect;
    }];
    
    //homework weight
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField){
        textField.placeholder = @"Weight of Homework";
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.borderStyle = UITextBorderStyleRoundedRect;
    }];
    
    //midterm weight
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField){
        textField.placeholder = @"Weight of Midterm";
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.borderStyle = UITextBorderStyleRoundedRect;
    }];
    
    //final weight
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField){
        textField.placeholder = @"Weight of Final";
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.borderStyle = UITextBorderStyleRoundedRect;
    }];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Add Course" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        NSString *courseID = ((UITextField *)[alert.textFields objectAtIndex:0]).text;
        NSString *hwWeight = ((UITextField *)[alert.textFields objectAtIndex:1]).text;
        NSString *mtWeight = ((UITextField *)[alert.textFields objectAtIndex:2]).text;
        NSString *finalWeight = ((UITextField *)[alert.textFields objectAtIndex:3]).text;
        
        //NEW
        
        AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
        NSManagedObjectContext *context = appDelegate.managedObjectContext;
        
        NSManagedObject *newCourse = [NSEntityDescription insertNewObjectForEntityForName:@"Course" inManagedObjectContext:context];
        
        [newCourse setValue:courseID forKey:@"courseID"];
        [newCourse setValue:[NSNumber numberWithInteger:[hwWeight integerValue]] forKey:@"hwWeight"];
        [newCourse setValue:[NSNumber numberWithInteger:[mtWeight integerValue]] forKey:@"midtermWeight"];
        [newCourse setValue:[NSNumber numberWithInteger:[finalWeight integerValue]] forKey:@"finalWeight"];
        
        [context save:nil];
        //END
        
        /*
        [_coursesArray insertObject:courseID atIndex:0];
        [_hwArray insertObject:hwWeight atIndex:0];
        [_mtArray insertObject:mtWeight atIndex:0];
        [_finalArray insertObject:finalWeight atIndex:0];
        */
        NSIndexPath * indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        
        //[self.courses reloadData];
        
        coursesTableViewCell *customCell = (coursesTableViewCell *)[self.courses dequeueReusableCellWithIdentifier:@"cell"];
        
        [self configureCourseCell:customCell atIndexPath:indexPath];

        
        //[self.courses insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }];
    
    [alert addAction:defaultAction];

    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - NSFetchedResultsControllerDelegate
- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    if (controller == self.fetchedStudentResultsController)
        [self.student beginUpdates];
    else
        [self.courses beginUpdates];
}
- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
        {
            if (controller == self.fetchedStudentResultsController)
                [self.student insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            else
                [self.courses insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
        }
        case NSFetchedResultsChangeDelete:
        {
            if (controller == self.fetchedStudentResultsController)
                [self.student deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            else
                [self.courses deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
        }
        case NSFetchedResultsChangeMove:
        case NSFetchedResultsChangeUpdate:
            break;
    }
}
- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            if(controller == self.fetchedStudentResultsController)
                [self.student insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            else
                [self.courses insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete:
            if (controller == self.fetchedStudentResultsController)
                [self.student deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            else
                [self.courses deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeUpdate:
            if (controller == self.fetchedStudentResultsController)
                [self configureStudentCell:[self.student cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            else
                [self configureCourseCell:[self.courses cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
        case NSFetchedResultsChangeMove:
            if (controller == self.fetchedStudentResultsController)
            {
                [self.student deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                [self.student insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            }
            else
            {
                [self.courses deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                [self.courses insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            }
            break;
    }
}
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    if(controller == _fetchedStudentResultsController)
        [self.student endUpdates];
    else
        [self.courses endUpdates];
}


@end
