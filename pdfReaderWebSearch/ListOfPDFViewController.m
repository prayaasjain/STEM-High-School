//
//  ListOfPDFViewController.m
//  pdfReaderWebSearch
//
//  Created by Peppy Sisay on 7/3/13.
//  Copyright (c) 2013 Prayaas Jain. All rights reserved.
//

#import "ListOfPDFViewController.h"


static NSString *kDeleteAllTitle = @"Delete All";
static NSString *kDeletePartialTitle = @"Delete (%d)";

@interface ListOfPDFViewController ()

@end

@implementation ListOfPDFViewController

@synthesize listOfPDF, path, url, loadFromSite, mstring, editItems, editbar, editButton, cancelButton, deleteButton, textLabelCell, backgroundImage;

- (void)resetUI {
    // leave edit mode for our table and apply the edit button
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.rightBarButtonItem = self.editButton;
    [self.tableView setEditing:NO animated:YES];
    
}

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated {
    self.navigationItem.hidesBackButton = true;
    [self loadArray];
    [self.tableView reloadData];
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setRestorationIdentifier:@"list"];
    
    self.tableView.separatorColor = [UIColor clearColor];
    backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_wood.png"]];
    self.tableView.backgroundView = backgroundImage;
    self.navigationController.navigationBar.topItem.prompt = @"The STEM Education Group";
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    [self setTitle:@"My Books"];
    loadFromSite = false;
    
    [self loadArray];
    [self.tableView reloadData];
    
    self.tableView.allowsMultipleSelectionDuringEditing = YES;
    
    self.deleteButton.tintColor = [UIColor redColor];
    self.navigationItem.rightBarButtonItem = self.editButton;
    
    editbar = [UIToolbar alloc];
    editbar.barStyle = UIBarStyleBlackTranslucent;
    
    [self resetUI];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload {
	
    [super viewDidUnload];
	
	self.listOfPDF = nil;
	self.tableView = nil;
    
    self.editButton = nil;
    self.cancelButton = nil;
    self.deleteButton = nil;
}

-(void)loadArray {
    
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

- (void)didReceiveMemoryWarning {

    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    return listOfPDF.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *CellIdentifier = @"PdfCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
    // Configure the cell...
    
    NSString *docTitle;
    docTitle = [NSString stringWithString:[[[listOfPDF objectAtIndex:indexPath.row] componentsSeparatedByString:mstring] componentsJoinedByString:@""]];
    NSCharacterSet *remove = [NSCharacterSet characterSetWithCharactersInString:@"/"];
    docTitle = [[docTitle componentsSeparatedByCharactersInSet:remove] componentsJoinedByString:@""];
    docTitle = [[docTitle componentsSeparatedByString:@".pdf"] componentsJoinedByString:@""];

    cell.textLabel.text = docTitle;
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

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(self.tableView.isEditing) {
    
        NSArray *selectedRows = [self.tableView indexPathsForSelectedRows];
        self.deleteButton.title = (selectedRows.count == 0) ?
        kDeleteAllTitle : [NSString stringWithFormat:kDeletePartialTitle, selectedRows.count];
    
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"showPDF"])
    {
        ShowPDFViewController *show = (ShowPDFViewController*)[segue destinationViewController];
        NSURL *documentPath = [[NSURL alloc] initFileURLWithPath:path];
        PSPDFDocument *document = [PSPDFDocument documentWithURL:documentPath];
        //[show commonInitWithDocument:document];
        [show setDocument:document];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(!self.tableView.isEditing) {
    
        path = [listOfPDF objectAtIndex:indexPath.row];
        [self performSegueWithIdentifier:@"showPDF" sender:self];
        
        //Open view controller
        UINavigationController *nc = [self navigationController];
        ShowPDFViewController *show = (ShowPDFViewController*)nc.topViewController;
        
        //display file name
        NSString *docTitle;
        docTitle = [NSString stringWithString:[[[listOfPDF objectAtIndex:indexPath.row] componentsSeparatedByString:mstring] componentsJoinedByString:@""]];
        NSCharacterSet *remove = [NSCharacterSet characterSetWithCharactersInString:@"/"];
        docTitle = [[docTitle componentsSeparatedByCharactersInSet:remove] componentsJoinedByString:@""];
        docTitle = [[docTitle componentsSeparatedByString:@".pdf"] componentsJoinedByString:@""];
        [show setTitle:docTitle];
    
    }
    else {
        NSArray *selectedRows = [self.tableView indexPathsForSelectedRows];
        NSString *deleteButtonTitle = [NSString stringWithFormat:kDeletePartialTitle, selectedRows.count];
        
        if (selectedRows.count == self.listOfPDF.count) {
            deleteButtonTitle = kDeleteAllTitle;
        }
        self.deleteButton.title = deleteButtonTitle;
        
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(editingStyle == UITableViewCellEditingStyleDelete) {
        
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
        }
        else {
            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Alert!" message:@"File can not be deleted" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alertView show];
        }
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if([alertView.title isEqual: @"Delete All Files"] && buttonIndex == 1) {
        [self clearArray];
    }
    else if([alertView.title isEqualToString:@"Edit Title"] && buttonIndex == 1) {
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}


-(UIImage*)thumbnailForPath:(NSString*)samplepath {
    
    NSURL *pdfFileUrl = [NSURL fileURLWithPath:samplepath];
    CGPDFDocumentRef pdf = CGPDFDocumentCreateWithURL((__bridge CFURLRef)pdfFileUrl);
    CGPDFPageRef page;
    
    CGRect aRect = CGRectMake(0, 0, 55, 80); // thumbnail size
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
    return NULL;
}

#pragma mark Action methods

- (IBAction)editAction:(id)sender {

    // setup our UI for editing
    // [self.navigationController.navigationBar addSubview:editbar];
    
    [self.cancelButton setStyle:UIBarButtonItemStyleDone];
    self.navigationItem.rightBarButtonItem = self.cancelButton;
    self.deleteButton.title = kDeleteAllTitle;
    self.navigationItem.leftBarButtonItem = self.deleteButton;
    [self.tableView setEditing:YES animated:YES];
}

- (IBAction)cancelAction:(id)sender {
    [self resetUI]; // reset our UI
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	
    // the user clicked one of the OK/Cancel buttons
	if (buttonIndex == 0) {
		// delete the selected rows
        NSArray *selectedRows = [self.tableView indexPathsForSelectedRows];
        if (selectedRows.count > 0) {
            // setup our deletion array so they can all be removed at once
            NSMutableArray *deletionArray = [NSMutableArray array];
            for (NSIndexPath *selectionIndex in selectedRows) {
                [deletionArray addObject:[self.listOfPDF objectAtIndex:selectionIndex.row]];
            }
            
            for(int k = 0; k < (int)deletionArray.count; k++) {
                [[NSFileManager defaultManager]removeItemAtPath:[deletionArray objectAtIndex:k] error:nil];
            }
            [self.listOfPDF removeObjectsInArray:deletionArray];
            
            // then delete only the rows in our table that were selected
            [self.tableView deleteRowsAtIndexPaths:selectedRows withRowAnimation:UITableViewRowAnimationAutomatic];
        }
        else {
            //[listOfPDF removeAllObjects];
            [self clearArray];
            
            // since we are deleting all the rows, just reload the current table section
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
        
        [self resetUI]; // reset our UI
        [self.tableView setEditing:NO animated:YES];
        
        self.editButton.enabled = (self.listOfPDF.count > 0) ? YES : NO;
	}
}

- (IBAction)deleteAction:(id)sender {
    // open a dialog with just an OK button
	NSString *actionTitle = ([[self.tableView indexPathsForSelectedRows] count] == 1) ?
    @"Are you sure you want to remove this document?" : @"Are you sure you want to remove these documents?";
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:actionTitle
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:@"Ok"
                                                    otherButtonTitles:nil];
	actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
	[actionSheet showInView:self.view];	// show from our table view (pops up in the middle of the table)
}

@end
