//
//  WebViewController.h
//  pdfReaderWebSearch
//
//  Created by Prayaas Jain on 6/18/13.
//  Copyright (c) 2013 Prayaas Jain. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ShowPDFViewController;
@class ViewController;

@interface WebViewController : UIViewController <UIWebViewDelegate> 

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UITextField *addressBar;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property NSString *selectedSearchEngine, *desiredSearch;
@property ShowPDFViewController *show;
@property ViewController *vc;

- (IBAction)gotoAddress:(id)sender;
- (IBAction)goBack:(id)sender;
- (IBAction)goForward:(id)sender;
- (IBAction)backToPDF:(id)sender;
- (IBAction)backToSearch:(id)sender;
- (IBAction)dismissKeyboard:(id)sender;
-(void) handleSelection:(NSString*)choice;

@end
