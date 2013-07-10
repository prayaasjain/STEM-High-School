//
//  ListOfPDFViewController.h
//  pdfReaderWebSearch
//
//  Created by Peppy Sisay on 7/3/13.
//  Copyright (c) 2013 Prayaas Jain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListOfPDFViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate,UIAlertViewDelegate>
@property NSMutableArray *listOfPDF;
@property NSString *path;
@property NSURL *url;
- (IBAction)clearAll:(id)sender;
@property bool loadFromSite;
-(void) clearArray;
@end
