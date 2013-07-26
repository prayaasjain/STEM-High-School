//
//  TestViewController.m
//  pdfReaderWebSearch
//
//  Created by Peppy Sisay on 6/20/13.
//  Copyright (c) 2013 Prayaas Jain. All rights reserved.
//

#import "ShowPDFViewController.h"
#import "ViewController.h"
#import "ListOfPDFViewController.h"
#import "MenuViewController.h"

@interface ShowPDFViewController ()

@end

@implementation ShowPDFViewController

@synthesize pdfViewer,backView;

NSString *selection;
NSTimer *timer;
CGFloat offset;
int currentpage;
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
    
    UIMenuItem *menuItem = [[UIMenuItem alloc] initWithTitle:@"Search"
                                                      action:@selector(customAction:)];
    UIMenuItem *highlightMenuItem = [[UIMenuItem alloc] initWithTitle:@"Highlight" action:@selector(highlight:)];
    
    [[UIMenuController sharedMenuController] setMenuItems:[NSArray arrayWithObjects:menuItem,highlightMenuItem, nil]];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(handleTimer) userInfo:@"Timer" repeats:YES];
    currentpage = 1;
    //610 page 2
    //1677 page 3
    //2747 page 4
    //3814 page 5
    //4883 page 6
    //5951 page 7
    // y=1068(x-1)+610
    
}

-(void)handleTimer{
    offset = pdfViewer.scrollView.contentOffset.y;
    if(offset > (1068*(currentpage -1)+610))
        currentpage++;
    else if(offset < (1068*(currentpage -2)+610))
        currentpage--;
    //NSLog(@"Current page: %i",currentpage);
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"showSearch"])
    {
        ViewController *vc = [segue destinationViewController];
        vc.highlighted = selection;
        vc.show = self;
    }
    else if([segue.identifier isEqualToString:@"showMenu"])
    {
        MenuViewController *mvc = [segue destinationViewController];
        mvc.show = self;
    }
    else if([segue.identifier isEqualToString:@"backtopdf"])
    {
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
    if (action == @selector(highlight:)) {
        return YES;
    }
    return NO;
}

#pragma mark - Custom Action(s)
- (void)customAction:(id)sender {
    
    
    [[UIApplication sharedApplication] sendAction:@selector(copy:) to:nil from:self forEvent:nil];
    selection = [UIPasteboard generalPasteboard].string;
    
    //NSLog(@"The selected string was: %@",selection);
    [self performSegueWithIdentifier:@"showSearch" sender:self];
    
}

- (void)highlight:(id)sender {
    NSString *js = @"document.execCommand('HiliteColor')";
    [pdfViewer stringByEvaluatingJavaScriptFromString:js];
    
}



-(void)loadPDF:(NSString *)path{
    
    NSURL *url = [[NSURL alloc] initFileURLWithPath:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [pdfViewer loadRequest:request];
    //NSLog(@"Should of loaded path: %@",path);
}

-(void)goToPage:(int)page {
    CGFloat goaly = 1068 * (page-1);
    CGPoint goal = CGPointMake(pdfViewer.scrollView.contentOffset.x, goaly);
    
    [pdfViewer.scrollView setContentOffset:goal animated:YES];
}

-(void)loadURL:(NSURL *)url{
    //NSLog(@"YUP");
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [pdfViewer loadRequest:request];
}

@end
