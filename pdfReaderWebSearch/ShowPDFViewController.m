//
//  TestViewController.m
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


-(void)viewDidLoad
{
    [super viewDidLoad];
    
    pdfViewer.userInteractionEnabled = YES;
    [pdfViewer setScalesPageToFit:YES];
    [self setRestorationIdentifier:@"showpdf"];
    
    //    NSString *path = [[NSBundle mainBundle] pathForResource:@"sample" ofType:@"pdf"];
    //    NSURL *url = [[NSURL alloc] initFileURLWithPath:path];
    //    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //    [pdfViewer loadRequest:request];
    //    NSLog(@"Sample loaded path: %@\n",request.debugDescription);
    
//    search = [[UIMenuItem alloc] initWithTitle:@"Search"
//                                                      action:@selector(customAction:)];
//    [searchButton ]
    //[[UIMenuController sharedMenuController] setMenuItems:[NSArray arrayWithObjects:search, nil]];
    //self.rightBarButtonItems = [self.rightBarButtonItems arrayByAddingObject:searchButton];
    PSPDFBarButtonItem *more = [[PSPDFBarButtonItem alloc] initWithTitle:@"test" style:UIBarButtonItemStyleBordered target:self action:nil];
    NSMutableArray *barButtonItems = [[NSMutableArray alloc] init];
   
    [barButtonItems addObject:searchButton];
    [barButtonItems addObject:more]; //added an empty button, additionalBarButtonItems must have at least two items
    
    
    self.additionalBarButtonItems = barButtonItems;
    
    self.additionalActionsButtonItem.target = self;
    self.additionalActionsButtonItem.action = @selector(showActionSheet);
    }

-(void)showActionSheet {
    NSLog(@"This should do something to show action sheet with the added buttons...");
    //under progess..
   
}

- (IBAction)clickedSearchButton:(id)sender {
    NSLog(@"Clicked search button");
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
//    if (action == @selector(highlight:)) {
//        return YES;
//    }
    return NO;
}

#pragma mark - Custom Action(s)
- (void)customAction:(id)sender {
    
    
    [[UIApplication sharedApplication] sendAction:@selector(copy:) to:nil from:self forEvent:nil];
    selection = [UIPasteboard generalPasteboard].string;
    
    //NSLog(@"The selected string was: %@",selection);
    [self performSegueWithIdentifier:@"showSearch" sender:self];
    
}

//- (void)highlight:(id)sender {
//    NSString *js = @"document.execCommand('HiliteColor')";
//    [pdfViewer stringByEvaluatingJavaScriptFromString:js];
//    
//}

-(void)loadPDF:(NSString *)path{

    NSURL *url = [[NSURL alloc] initFileURLWithPath:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [pdfViewer loadRequest:request];
    //NSLog(@"Should of loaded path: %@",path);
}

//-(void)goToPage:(int)page {
//    CGFloat goaly = 1068 * (page-1);
//    CGPoint goal = CGPointMake(pdfViewer.scrollView.contentOffset.x, goaly);
//    
//    [pdfViewer.scrollView setContentOffset:goal animated:YES];
//}

-(void)loadURL:(NSURL *)url{
    NSLog(@"loadURL being called");
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [pdfViewer loadRequest:request];
}

@end
