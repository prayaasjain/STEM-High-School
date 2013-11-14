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
    self.pageTransition = PSPDFPageTransitionCurl;
    pdfViewer.userInteractionEnabled = YES;
    [pdfViewer setScalesPageToFit:YES];
    [self setRestorationIdentifier:@"showpdf"];
    self.delegate = self;
    self.rightBarButtonItems = [self.rightBarButtonItems arrayByAddingObject:searchButton];
   

}


- (NSArray *)pdfViewController:(PSPDFViewController *)pdfController shouldShowMenuItems:(NSArray *)menuItems atSuggestedTargetRect:(CGRect)rect forAnnotations:(NSArray *)annotations inRect:(CGRect)annotationRect onPageView:(PSPDFPageView *)pageView {
    
    return menuItems; 
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
    
    // add option for web search
    PSPDFMenuItem *searchItem = [[PSPDFMenuItem alloc] initWithTitle:NSLocalizedString(@"Web Search", nil) block:^{
    
        NSString *trimmedSearchText = PSPDFTrimString(selectedText);
        [self showSearchWithString:trimmedSearchText];
    
    } identifier:@"Web Search"];
    [newMenuItems addObject:searchItem];
    
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

#pragma mark - Custom Action(s)
- (void)showSearchWithString:(NSString *)selectedText {
    
    selection = selectedText;
    //NSLog(@"The selected string was: %@",selection);
    [self performSegueWithIdentifier:@"showSearch" sender:self];
    
}

-(void)loadPDF:(NSString *)path{

    NSURL *url = [[NSURL alloc] initFileURLWithPath:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [pdfViewer loadRequest:request];
    //NSLog(@"Should of loaded path: %@",path);
}

-(void)loadURL:(NSURL *)url{
    NSLog(@"loadURL being called");
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [pdfViewer loadRequest:request];
}

@end
