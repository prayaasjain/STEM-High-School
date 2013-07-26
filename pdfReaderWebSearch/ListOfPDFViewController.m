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

@synthesize listOfPDF,path,url,loadFromSite, mstring, editItems, editbar, itemNav;

bool editButtonToggle;

int numOfSelectedRows;

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


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setRestorationIdentifier:@"list"];
    self.navigationController.navigationBar.topItem.prompt = @"USC";
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    [self setTitle:@"List of available PDF Files"];
    loadFromSite = false;
    
    
    [self loadArray];
    [self.tableView reloadData];
    editButtonToggle = false;
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    editbar = [[UIToolbar alloc] initWithFrame:CGRectMake(70, 0, 700, 95)];
    editbar.barStyle = UIBarStyleBlack;

    UIBarButtonItem *editTitle = [[UIBarButtonItem alloc] initWithTitle:@"Title"
                                                                  style:UIBarButtonItemStyleBordered target:nil action:nil];
    UIBarButtonItem *editMove = [[UIBarButtonItem alloc] initWithTitle:@"Move"
                                                                 style:UIBarButtonItemStyleBordered target:nil action:nil];
    editItems = [[NSArray alloc] initWithObjects:editTitle, editMove, nil];
    [editbar setItems:editItems];
    
    //itemNav = [[UINavigationItem alloc] initWithTitle:@"Edit Toolbar"];
    //itemNav.rightBarButtonItem = rightButton;
    //itemNav.hidesBackButton = YES;
    //itemNav.leftBarButtonItems = [NSArray arrayWithObjects:editTitle, editMove, nil];
    
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(handleEdit) userInfo:@"edit" repeats:YES];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 3;
}

-(void)handleEdit{
    if(self.editing && !editButtonToggle)
    {
        editButtonToggle = true;
        
        [self.navigationController.view addSubview:editbar];
        //[editbar pushNavigationItem:item animated:YES];
    }
    else if(!self.editing){
        editButtonToggle = false;
        //[editbar popNavigationItemAnimated:YES];
        [editbar removeFromSuperview];
    }
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
    
    cell.imageView.image = [self thumbnailForPath:[listOfPDF objectAtIndex:indexPath.row]];
    cell.indentationWidth = 20;
    
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

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath   {
    if(self.editing)
    {
        numOfSelectedRows = [[tableView indexPathsForSelectedRows] count];
        // NSLog(@"number: %i",numOfSelectedRows);
        UINavigationItem *mainitem = [editbar.items objectAtIndex:0];
        if(numOfSelectedRows == 1)
        {
            for(UIBarButtonItem *item in mainitem.leftBarButtonItems)
            {
                if([item.title isEqualToString:@"Title"])
                {
                    [item setEnabled:YES];
                    // NSLog(@"ENABLED");
                }
            }
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(!self.editing)
    {
        path = [listOfPDF objectAtIndex:indexPath.row];
        [self performSegueWithIdentifier:@"showPDF" sender:self];
        UINavigationController *nc = [self navigationController];
        ShowPDFViewController *show = (ShowPDFViewController*)nc.topViewController;
        [show loadPDF:path];
    }
    else
    {
        numOfSelectedRows = [[tableView indexPathsForSelectedRows] count];
        // NSLog(@"number: %i",numOfSelectedRows);
        UINavigationItem *mainitem = [editbar.items objectAtIndex:0];
        if(numOfSelectedRows > 1)
        {
            
            for(UIBarButtonItem *item in mainitem.leftBarButtonItems)
            {
                if([item.title isEqualToString:@"Title"])
                {
                    [item setEnabled:NO];
                }
            }
        }
        else if(numOfSelectedRows == 1)
        {
            for(UIBarButtonItem *item in mainitem.leftBarButtonItems)
            {
                if([item.title isEqualToString:@"Title"])
                {
                    [item setEnabled:YES];
                    // NSLog(@"ENABLED");
                }
            }
        }
        
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete)
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
    else if([alertView.title isEqualToString:@"Edit Title"] && buttonIndex == 1)
    {
        NSString *newTitle = [alertView textFieldAtIndex:0].text;
        NSInteger row = alertView.accessibilityHint.integerValue;
        [[self.tableView.visibleCells objectAtIndex:row] textLabel].text = newTitle;
        editButtonToggle = false;
        //editButtonOutlet.style = UIBarButtonItemStyleBordered;
        
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
/*
 - (IBAction)editButton:(id)sender {
 if(editButtonToggle)
 {
 editButtonToggle = false;
 editButtonOutlet.style = UIBarButtonItemStyleBordered;
 }
 else
 {
 editButtonToggle = true;
 editButtonOutlet.style = UIBarButtonItemStyleDone;
 
 
 }
 
 }
 */

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}



-(UIImage*)thumbnailForPath:(NSString*)samplepath {
    NSURL *pdfFileUrl = [NSURL fileURLWithPath:samplepath];
    CGPDFDocumentRef pdf = CGPDFDocumentCreateWithURL((__bridge CFURLRef)pdfFileUrl);
    CGPDFPageRef page;
    
    CGRect aRect = CGRectMake(0, 0, 70, 100); // thumbnail size
    UIGraphicsBeginImageContext(aRect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIImage* thumbnailImage;
    
    
    NSUInteger totalNum = CGPDFDocumentGetNumberOfPages(pdf);
    
    for(int i = 0; i < totalNum; i++ ) {
        
        
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, 0.0, aRect.size.height);
        CGContextScaleCTM(context, 1.0, -1.0);
        
        CGContextSetGrayFillColor(context, 1.0, 1.0);
        CGContextFillRect(context, aRect);
        
        
        // Grab the first PDF page
        page = CGPDFDocumentGetPage(pdf, i + 1);
        CGAffineTransform pdfTransform = CGPDFPageGetDrawingTransform(page, kCGPDFMediaBox, aRect, 0, true);
        // And apply the transform.
        CGContextConcatCTM(context, pdfTransform);
        
        CGContextDrawPDFPage(context, page);
        
        // Create the new UIImage from the context
        thumbnailImage = UIGraphicsGetImageFromCurrentImageContext();
        return thumbnailImage;
    }
}




@end
