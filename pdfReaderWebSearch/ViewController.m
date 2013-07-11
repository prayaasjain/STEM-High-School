//
//  ViewController.m
//  pdfReaderWebSearch
//
//  Created by Prayaas Jain on 6/18/13.
//  Copyright (c) 2013 Prayaas Jain. All rights reserved.
//

#import "ViewController.h"
#import "TableViewController.h"
#import "ShowPDFViewController.h"

@implementation ViewController

@synthesize currentSearchEngine,searchTextField,selectSearchButton,highlighted,show;

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"Search"]) {
        
        WebViewController *wvc = [segue destinationViewController];
        [wvc setTitle:@"Search Results"];
        wvc.selectedSearchEngine = selectSearchButton.titleLabel.text;
        wvc.desiredSearch = searchTextField.text;
        wvc.show = self.show;
        wvc.vc = self;
        
    }
    else if([segue.identifier isEqualToString:@"popOver"])
    {
        UIStoryboardPopoverSegue *popoverSegue;
        popoverSegue = (UIStoryboardPopoverSegue *)segue;
        
        
        UIPopoverController *popoverController;
        popoverController = popoverSegue.popoverController;
        popoverController.delegate = self;
        
        TableViewController *tableViewController = (TableViewController *)popoverSegue.destinationViewController;
        tableViewController.popoverController = popoverController;
        tableViewController.vc = self;
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    searchTextField.text = highlighted;
    
}

#pragma mark - UIMenuController required methods



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButton:(id)sender {
    [show dismissViewControllerAnimated:YES completion:nil];
}
@end
