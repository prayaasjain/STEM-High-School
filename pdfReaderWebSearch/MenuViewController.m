//
//  MenuViewController.m
//  pdfReaderWebSearch
//
//  Created by Peppy Sisay on 7/9/13.
//  Copyright (c) 2013 Prayaas Jain. All rights reserved.
//

#import "MenuViewController.h"
#import "ShowPDFViewController.h"
@interface MenuViewController ()

@end

@implementation MenuViewController

@synthesize show;

UIAlertView *pagealert;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (IBAction)goToButton:(id)sender {
//    pagealert = [[UIAlertView alloc] initWithTitle:@"Go to..." message:@"What page would you like to go to?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Go", nil];
//    [pagealert setAlertViewStyle:UIAlertViewStylePlainTextInput];
//    [pagealert textFieldAtIndex:0].delegate = self;
//    [pagealert textFieldAtIndex:0].accessibilityIdentifier = @"gotopage";
//    
//    [[pagealert textFieldAtIndex:0] setKeyboardType:UIKeyboardTypeNumberPad];
//    [pagealert show];
//    
//}

- (IBAction)goBackToList:(id)sender {
    [show dismissViewControllerAnimated:YES completion:^{
       // [tvc performSegueWithIdentifier:@"backtolist" sender:self];
        [show.navigationController popViewControllerAnimated:YES];
    }];

}

- (IBAction)exitMenu:(id)sender {
    [show dismissViewControllerAnimated:YES completion:nil];
}
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
//    if(buttonIndex == 1)
//    {
//        if([[alertView textFieldAtIndex:0].text intValue] != 0)
//        {
//            int page = [[alertView textFieldAtIndex:0].text intValue];
//            //NSLog(@"You entered: %i",page);
//            [tvc dismissViewControllerAnimated:YES completion:^{
//            [tvc goToPage:page];    
//            }];
//            
//        }
//    }
//}

//-(BOOL)textFieldShouldReturn:(UITextField *)textField{
//    if([textField.accessibilityIdentifier isEqual: @"gotopage"])
//    {
//        if([textField.text intValue] != 0)
//        {
//            [pagealert dismissWithClickedButtonIndex:1 animated:YES];
//            int page = [textField.text intValue];
//            //NSLog(@"You entered: %i",page);
//            [tvc dismissViewControllerAnimated:YES completion:^{
//                [tvc goToPage:page];
//                
//            }];
//            
//            
//        }
//
//   
//        
//    }
//    return YES;
//}

@end
