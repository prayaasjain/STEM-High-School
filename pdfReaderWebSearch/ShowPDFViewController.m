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
    self.delegate = self;
    self.rightBarButtonItems = [self.rightBarButtonItems arrayByAddingObject:searchButton];
    
    //UIMenuItem *custom = [[UIMenuItem alloc] initWithTitle:@"CUSTOM" action:@selector(customAction:)];
    
    PSPDFMenuItem *custom = [[PSPDFMenuItem alloc] initWithTitle:@"CUSTOM" action:@selector(customAction:)];
    NSLog(@"%@",[UIMenuController sharedMenuController].menuItems.debugDescription);
    
    NSMutableArray *menuItems = [[NSMutableArray alloc] initWithObjects:custom, nil];
    
    [[UIMenuController sharedMenuController] setMenuItems:menuItems];
     NSLog(@"%@",[UIMenuController sharedMenuController].menuItems.debugDescription);
    

}


- (NSArray *)pdfViewController:(PSPDFViewController *)pdfController shouldShowMenuItems:(NSArray *)menuItems atSuggestedTargetRect:(CGRect)rect forSelectedText:(NSString *)selectedText inRect:(CGRect)textRect onPageView:(PSPDFPageView *)pageView {
    
    // disable wikipedia
    // be sure to check for PSPDFMenuItem class; there might also be classic UIMenuItems in the array.
    // Note that for words that are in the iOS dictionary, instead of Wikipedia we show the "Define" menu item with the native dict.
    // There is also a simpler way to disable wikipedia (document.allowedMenuActions)
    NSMutableArray *newMenuItems = [menuItems mutableCopy];
    for (PSPDFMenuItem *menuItem in menuItems) {
        if ([menuItem isKindOfClass:[PSPDFMenuItem class]] && [menuItem.identifier isEqualToString:@"Wikipedia"]) {
            [newMenuItems removeObjectIdenticalTo:menuItem];
            break;
        }
    }
    
    // add option to google for it.
    PSPDFMenuItem *googleItem = [[PSPDFMenuItem alloc] initWithTitle:NSLocalizedString(@"Google", nil) block:^{
        
        // trim removes stuff like \n or 's.
        NSString *trimmedSearchText = PSPDFTrimString(selectedText);
        NSString *URLString = [NSString stringWithFormat:@"http://www.google.com/search?q=%@", [trimmedSearchText stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        // create browser
        PSPDFWebViewController *browser = [[PSPDFWebViewController alloc] initWithURL:[NSURL URLWithString:URLString]];
        browser.delegate = pdfController;
        browser.contentSizeForViewInPopover = CGSizeMake(600, 500);
        
       
        [self presentModalOrInPopover:browser embeddedInNavigationController:YES withCloseButton:YES animated:YES sender:nil options:@{PSPDFPresentOptionRect : BOXED(rect)}];
        
    } identifier:@"Google"];
    [newMenuItems addObject:googleItem];
    
    return newMenuItems;
}

+(void)load {
    [super load];
    
    [PSPDFMenuItem installMenuHandlerForObject:self];
    
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


-(BOOL)canPerformAction:(SEL)action withSender:(id)sender {
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
