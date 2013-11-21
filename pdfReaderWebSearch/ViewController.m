//
//  ViewController.m
//  pdfReaderWebSearch
//
//  Created by Prayaas Jain on 6/18/13.
//  Copyright (c) 2013 Prayaas Jain. All rights reserved.
//

#import "ViewController.h"


@implementation ViewController

@synthesize currentSearchEngine,searchTextField,selectSearchButton,highlighted,show;

- (BOOL) shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    
    if([identifier isEqualToString:@"Search"]) {
    
        if(searchTextField.text == NULL) {
            
            UIAlertView *nullSearchAlert = [[UIAlertView alloc] initWithTitle:@"Invalid Search" message:@"Search field cannot be empty" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil ];
            [nullSearchAlert show];
            return NO;
        }
        else {
            return YES;
        }
    }
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
        if([segue.identifier isEqualToString:@"Search"]) {
            
                WebViewController *wvc = [segue destinationViewController];
                [wvc setTitle:@"Search Results"];
                wvc.selectedSearchEngine = selectSearchButton.titleLabel.text;
                wvc.show = self.show;
                wvc.vc = self;
                NSString *searchText = [[NSString alloc] initWithString:searchTextField.text];
                [sharedManager.searchBundle setObject:searchText forKey:@"SEARCH"];
            
        }
        else if([segue.identifier isEqualToString:@"popOver"]) {

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

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if([alertView.title isEqual:@"Invalid Search"] && buttonIndex == 1) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"green-board-text.png"]];
    sharedManager = [MyManager sharedManager];
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
