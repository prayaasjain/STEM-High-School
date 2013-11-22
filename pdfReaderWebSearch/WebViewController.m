//
//  WebViewController.m
//  pdfReaderWebSearch
//
//  Created by Prayaas Jain on 6/18/13.
//  Copyright (c) 2013 Prayaas Jain. All rights reserved.
//

#import "WebViewController.h"

@implementation WebViewController

@synthesize webView, addressBar, activityIndicator,selectedSearchEngine,desiredSearch,show,vc;

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
    
    webView.delegate = self;
    [webView setScalesPageToFit:YES];
    sharedManager = [MyManager sharedManager];
    
    
    [self handleSelection:selectedSearchEngine];
}

-(void) handleSelection:(SearchType*)choice {
    NSString *urlAddress;
    NSURL *url;
    NSURLRequest *requestObj;
    NSString *finalSearchQuery = [sharedManager.searchBundle objectForKey:@"SEARCH"];
    
    finalSearchQuery = [finalSearchQuery stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    urlAddress = [[NSString alloc] initWithFormat:@"%@%@",choice.searchURL,finalSearchQuery];
    url = [NSURL URLWithString:urlAddress];
    requestObj = [NSURLRequest requestWithURL:url];
    [webView loadRequest:requestObj];
    [addressBar setText:urlAddress];
    
    
    
    
}



- (void)didReceiveMemoryWarning {

    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
                  
- (IBAction)gotoAddress:(id)sender {

    NSURLRequest *requestObj = [NSURLRequest alloc];
    NSURL *requestUrl = [[NSURL alloc] initWithString:[addressBar text]];
    
    if([[requestUrl scheme] isEqualToString:@"http"]) {
        requestObj = [NSURLRequest requestWithURL:requestUrl];
    }
    else {
    NSMutableString *addressquery = [[NSMutableString alloc] initWithString:@"http://"];
    [addressquery appendString:[addressBar text]];
    NSURL *url = [NSURL URLWithString:addressquery];
    requestObj = [NSURLRequest requestWithURL:url];
    }

    [webView loadRequest:requestObj];
    [addressBar resignFirstResponder];

}

- (IBAction)goBack:(id)sender {
    
    [webView goBack];
}

-(IBAction)goForward:(id)sender {
    
    [webView goForward];
}

- (IBAction)backToSearch:(id)sender {
    [vc dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)dismissKeyboard:(id)sender {
    [addressBar resignFirstResponder];
}

- (IBAction)backToPDF:(id)sender {
    
    [show dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [activityIndicator startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [activityIndicator stopAnimating];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    if(navigationType == UIWebViewNavigationTypeLinkClicked) {
        NSURL *URL = [request URL];
        
        if([[URL scheme] isEqualToString:@"http"]) {
            [addressBar setText:[URL absoluteString]];
            [self gotoAddress:nil];
        }
        else {
            
            // implement method to add 'http://' before request
            
        }
        return NO;
    }
    return YES;
}

@end
