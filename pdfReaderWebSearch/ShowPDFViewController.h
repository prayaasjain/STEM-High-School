//
//  ShowPDFViewController.h
//  pdfReaderWebSearch
//
//  Created by Peppy Sisay on 7/10/13.
//  Copyright (c) 2013 Prayaas Jain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PSPDFKit/PSPDFKit.h>

#import "CustomView.h"
#import "ViewController.h"
#import "ListOfPDFViewController.h"
#import "MenuViewController.h"

@class ListOfPDFViewController;


@interface ShowPDFViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIWebView *pdfViewer;
@property (weak, nonatomic) IBOutlet CustomView *backView;

-(void)loadPDF:(NSString *)path;
-(void)loadURL:(NSURL *)url;

@property (weak) NSString *selection;
@property (weak) NSTimer  *timer;
@property CGFloat *offset;

@end
