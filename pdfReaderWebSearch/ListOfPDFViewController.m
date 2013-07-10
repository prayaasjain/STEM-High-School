//
//  ListOfPDFViewController.m
//  pdfReaderWebSearch
//
//  Created by Peppy Sisay on 7/3/13.
//  Copyright (c) 2013 Prayaas Jain. All rights reserved.
//

#import "ListOfPDFViewController.h"
#import "ShowPDFViewController.h"
#include "TargetConditionals.h"
@interface ListOfPDFViewController ()

@end

@implementation ListOfPDFViewController

@synthesize listOfPDF,path,url,loadFromSite;

//pathofmaindirectory
NSMutableString *mstring;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
/*
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqual: @"showPDF"])
    {
        TestViewController *tvc = [segue destinationViewController];
        //NSLog(@"%@",path);
            [tvc loadPDF:path];
        
        
    }
}
*/

-(void)viewDidAppear:(BOOL)animated{
    self.navigationItem.hidesBackButton = true;
    [self loadArray];
    [self.tableView reloadData];
}

-(void)loadArray{
    NSString *string = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    mstring = [[NSMutableString alloc] initWithString:string];
    [mstring appendString:@"/Inbox"];
    
    
    
    NSArray *directoryContent = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:mstring error:NULL];
    
    NSMutableArray *paths = [[NSMutableArray alloc] init];
    
    
    for(int k = 0; k < directoryContent.count; k++)
    {
        if([[directoryContent objectAtIndex:k] rangeOfString:@".pdf"].location != NSNotFound)
        {
            NSString *filepath = [[NSString alloc] initWithFormat:@"%@/%@",mstring,[directoryContent objectAtIndex:k]];
            [paths addObject:filepath];
        }
    }
    
    listOfPDF = [[NSMutableArray alloc] initWithArray:paths];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setRestorationIdentifier:@"list"];
    self.navigationController.navigationBar.topItem.prompt = @"USC";
    [self setTitle:@"List of available PDF Files"];
    loadFromSite = false;
    
    
    [self loadArray];
    [self.tableView reloadData];
    
    
    

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   // Return the number of rows in the section.
    return listOfPDF.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PdfCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
   // cell.textLabel.text = [listOfPDF objectAtIndex:indexPath.row];
    cell.textLabel.text = [[[listOfPDF objectAtIndex:indexPath.row] componentsSeparatedByString:mstring] componentsJoinedByString:@""];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    path = [listOfPDF objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"showPDF" sender:self];
    UINavigationController *nc = [self navigationController];
    ShowPDFViewController *show = (ShowPDFViewController*)nc.topViewController;
    [show loadPDF:path];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
   // NSLog(@"object: %@",[listOfPDF objectAtIndex:indexPath.row]);
    NSString *pathToDelete = [listOfPDF objectAtIndex:indexPath.row];
    
    NSError *error;
    BOOL success=[[NSFileManager defaultManager]removeItemAtPath:pathToDelete error:&error];
    
    if (error) {
        NSLog(@"ERROR: %@",error);
    }
    
    // if file is succes deleted
    if (success) {
        //remove this item from array
        [listOfPDF removeObjectAtIndex:indexPath.row];
        //and remove cell
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    }else{
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Alert!" message:@"File can not be deleted" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertView show];
    }
}



- (IBAction)clearAll:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Delete All Files" message:@"Are you sure you want to delete ALL the PDF files?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    [alert show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if([alertView.title isEqual: @"Delete All Files"] && buttonIndex == 1)
    {
        [self clearArray];
    }
}

-(void)clearArray{
    //NSLog(@"Count: %i",listOfPDF.count);
    NSMutableArray *pathsToDelete = [[NSMutableArray alloc] init];
    
    for(int k = 0; k < (int)listOfPDF.count ; k++)
    {
        [pathsToDelete addObject:[listOfPDF objectAtIndex:k]];
        //NSLog(@"Deleting: %@",[pathsToDelete objectAtIndex:k]);
    }
    for(int k = 0; k < (int)pathsToDelete.count; k++)
    {
        [[NSFileManager defaultManager]removeItemAtPath:[pathsToDelete objectAtIndex:k] error:nil];
    }
    [listOfPDF removeAllObjects];
    [self.tableView reloadData];

    
}
@end
