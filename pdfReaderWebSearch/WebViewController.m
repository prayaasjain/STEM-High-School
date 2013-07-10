//
//  WebViewController.m
//  pdfReaderWebSearch
//
//  Created by Prayaas Jain on 6/18/13.
//  Copyright (c) 2013 Prayaas Jain. All rights reserved.
//

#import "WebViewController.h"
#import "ViewController.h"
#import "ShowPDFViewController.h"
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
    
    
    [self handleSelection:selectedSearchEngine];
    
   
    
}

-(void) handleSelection:(NSString*)choice {
    NSString *urlAddress;
    NSURL *url;
    NSURLRequest *requestObj;
    NSString *finalSearchQuery;
    
    finalSearchQuery = [desiredSearch stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    
    if([choice isEqualToString:@"Google"])
    {
        urlAddress = [[NSString alloc] initWithFormat:@"http://gog.is/%@",finalSearchQuery];
        url = [NSURL URLWithString:urlAddress];
        requestObj = [NSURLRequest requestWithURL:url];
    }
    else if([choice isEqualToString:@"Bing"])
    {
        urlAddress = [[NSString alloc] initWithFormat:@"http://www.bing.com/search?q=%@",finalSearchQuery];
        url = [NSURL URLWithString:urlAddress];
        requestObj = [NSURLRequest requestWithURL:url];
    }
    else if([choice isEqualToString:@"Wikipedia"])
    {
        urlAddress = [[NSString alloc] initWithFormat:@"http://en.wikipedia.org/wiki/Special:Search?search=%@",finalSearchQuery];
        url = [NSURL URLWithString:urlAddress];
        requestObj = [NSURLRequest requestWithURL:url];
    }
    [webView loadRequest:requestObj];
    [addressBar setText:urlAddress];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
                  
- (IBAction)gotoAddress:(id)sender {

    NSURL *url = [NSURL URLWithString:[addressBar text]];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    [webView loadRequest:requestObj];
    [addressBar resignFirstResponder];

}

- (IBAction)goBack:(id)sender {
    
    [webView goBack];
}

-(IBAction)goForward:(id)sender {
    
    [webView goForward];
}

- (IBAction)backToPdf:(id)sender {
    [show dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)backToSearch:(id)sender {
    [vc dismissViewControllerAnimated:YES completion:nil];
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
