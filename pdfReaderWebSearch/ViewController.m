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
    
    UIMenuItem *customMenuItem1 = [[UIMenuItem alloc] initWithTitle:@"Highlight" action:@selector(doHighlight:)];
    UIMenuItem *customMenuItem2 = [[UIMenuItem alloc] initWithTitle:@"Note" action:@selector(doNote:)];
    //[myArray addObject:customMenuItem2];
    [[UIMenuController sharedMenuController] setMenuItems:[NSArray arrayWithObjects:customMenuItem1,customMenuItem2, nil]];
    
}

#pragma mark - UIMenuController required methods
- (BOOL)canBecomeFirstResponder {
    // NOTE: This menu item will not show if this is not YES!
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    // The selector(s) should match your UIMenuItem selector
    if (action == @selector(doHighlight:)) {
        return YES;
    }
    if (action == @selector(doNote:)) {
        return YES;
    }
    return NO;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButton:(id)sender {
    [show dismissViewControllerAnimated:YES completion:nil];
}
@end
