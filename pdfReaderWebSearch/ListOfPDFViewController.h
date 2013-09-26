//
//  ListOfPDFViewController.h
//  pdfReaderWebSearch
//
//  Created by Peppy Sisay on 7/3/13.
//  Copyright (c) 2013 Prayaas Jain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListOfPDFViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate,UIAlertViewDelegate, UIActionSheetDelegate>
@property NSMutableArray *listOfPDF;
@property NSString *path;
@property NSURL *url;
@property bool loadFromSite;
-(void) clearArray;

@property NSMutableString *mstring;
@property UIToolbar *editbar;
@property NSArray *editItems;
@property NSString *textLabelCell;

-(UIImage*)thumbnailForPath:(NSString*)samplepath;
@end
