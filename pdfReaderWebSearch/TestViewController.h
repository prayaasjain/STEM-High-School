//
//  TestViewController.h
//  pdfReaderWebSearch
//
//  Created by Peppy Sisay on 6/20/13.
//  Copyright (c) 2013 Prayaas Jain. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ListOfPDFViewController;
@interface TestViewController : UICollectionViewController
@property (weak, nonatomic) IBOutlet UIWebView *pdfViewer;
- (IBAction)menuButton:(id)sender;

-(void)loadPDF:(NSString *)path;
-(void)loadURL:(NSURL *)url;
-(void)handleTimer;
-(void)goToPage:(int)page;
@end
