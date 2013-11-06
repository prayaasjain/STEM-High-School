//
//  ShowPDFViewController.m
//  pdfReaderWebSearch
//
//  Created by Peppy Sisay on 6/20/13.
//  Copyright (c) 2013 Prayaas Jain. All rights reserved.
//

#import "ShowPDFViewController.h"


@interface ShowPDFViewController ()

@end

@implementation ShowPDFViewController

@synthesize pdfViewer,backView, selection, timer, offset,search,searchButton;


-(void)viewDidLoad {
    [super viewDidLoad];
    
    pdfViewer.userInteractionEnabled = YES;
    [pdfViewer setScalesPageToFit:YES];
    [self setRestorationIdentifier:@"showpdf"];
    self.navigationItem.rightBarButtonItem = searchButton;
    
    //    NSString *path = [[NSBundle mainBundle] pathForResource:@"sample" ofType:@"pdf"];
    //    NSURL *url = [[NSURL alloc] initFileURLWithPath:path];
    //    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //    [pdfViewer loadRequest:request];
    //    NSLog(@"Sample loaded path: %@\n",request.debugDescription);
    
    //    search = [[UIMenuItem alloc] initWithTitle:@"Search" action:@selector(customAction:)];
    //    [searchButton ]
    //    [[UIMenuController sharedMenuController] setMenuItems:[NSArray arrayWithObjects:search, nil]];

}

-(void) commonInitWithDocument:(PSPDFDocument *)document   {
    [super commonInitWithDocument:document];
    
}

-(id) initWithDocument:(PSPDFDocument *)document {
    self = [super initWithDocument:document];
    
    return self;
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([segue.identifier isEqualToString:@"showSearch"]) {
        ViewController *vc = [segue destinationViewController];
        vc.highlighted = selection;
        vc.show = self;
    }
    else if([segue.identifier isEqualToString:@"backtopdf"]) {
        ListOfPDFViewController *lop = [segue destinationViewController];
        lop.navigationItem.hidesBackButton = YES;
    }
}

#pragma mark - UIMenuController required methods
- (BOOL)canBecomeFirstResponder {
    // NOTE: This menu item will not show if this is not YES!
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    // The selector(s) should match your UIMenuItem selector
    if (action == @selector(customAction:)) {
        return YES;
    }
    return NO;
}

#pragma mark - Custom Action(s)
- (void)customAction:(id)sender {
    [[UIApplication sharedApplication] sendAction:@selector(copy:) to:nil from:self forEvent:nil];
    selection = [UIPasteboard generalPasteboard].string;
    [self performSegueWithIdentifier:@"showSearch" sender:self];
}

-(void)loadPDF:(NSString *)path{
    NSURL *url = [[NSURL alloc] initFileURLWithPath:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [pdfViewer loadRequest:request];
}

-(void)loadURL:(NSURL *)url{
    NSLog(@"loadURL being called");
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [pdfViewer loadRequest:request];
}

@end
