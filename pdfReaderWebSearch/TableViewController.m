//
//  TableViewController.m
//  pdfReaderWebSearch
//
//  Created by Prayaas Jain on 6/19/13.
//  Copyright (c) 2013 Prayaas Jain. All rights reserved.
//

#import "TableViewController.h"


@implementation TableViewController

@synthesize popoverController,vc;

NSMutableArray *searchEngines;
/*
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([segue.identifier isEqualToString:@"SetSearchEngine"]) {
        
        ViewController *vc = [segue destinationViewController];
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        SearchType *s = [searchEngines objectAtIndex:[path row]];
        [vc setCurrentSearchEngine:s];
        
    }
}
*/
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    searchEngines = [[NSMutableArray alloc] init];
    
    SearchType *search = [[SearchType alloc]init];
    [search setEngineName:@"Google"];
    [search setSearchURL:@"http://www.google.com/search?q="];
    [searchEngines addObject:search];
    
    search = [[SearchType alloc]init];
    [search setEngineName:@"Bing"];
    [search setSearchURL:@"http://www.bing.com/search?q="];
    [searchEngines addObject:search];
    
    search = [[SearchType alloc]init];
    [search setEngineName:@"Wikipedia"];
    [search setSearchURL:@"http://en.wikipedia.org/wiki/Special:Search?search="];
    [searchEngines addObject:search];

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
    return [searchEngines count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SearchCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    SearchType *current = [searchEngines objectAtIndex:[indexPath row]];
    [[cell textLabel] setText:current.engineName];
    
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
    [vc.selectSearchButton setTitle:[[searchEngines objectAtIndex:indexPath.row] engineName] forState:0];
    [self.popoverController dismissPopoverAnimated:YES];
    
}

@end
