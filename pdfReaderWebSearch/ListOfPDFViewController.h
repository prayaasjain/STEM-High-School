//
//  ListOfPDFViewController.h
//  pdfReaderWebSearch
//
//  Created by Peppy Sisay on 7/3/13.
//  Copyright (c) 2013 Prayaas Jain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShowPDFViewController.h"
#include "TargetConditionals.h"

@interface ListOfPDFViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate,UIAlertViewDelegate, UIActionSheetDelegate> {
    
    bool editButtonToggle;
    int numOfSelectedRows;
}

@property NSMutableArray *listOfPDF;
@property (weak) NSString *path;
@property (weak) NSURL *url;
@property bool loadFromSite;

-(void) clearArray;

@property NSMutableString *mstring;
@property UIToolbar *editbar;
@property (weak) NSArray *editItems;
@property (weak) NSString *textLabelCell;

-(UIImage*)thumbnailForPath:(NSString*)samplepath;

@property (nonatomic, strong) IBOutlet UIBarButtonItem *editButton;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *cancelButton;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *deleteButton;

@property (nonatomic, strong) UIImageView *backgroundImage;

- (IBAction)editAction:(id)sender;
- (IBAction)cancelAction:(id)sender;
- (IBAction)deleteAction:(id)sender;

@end
