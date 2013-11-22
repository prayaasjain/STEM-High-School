//
//  TableViewController.h
//  pdfReaderWebSearch
//
//  Created by Prayaas Jain on 6/19/13.
//  Copyright (c) 2013 Prayaas Jain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchType.h"
#import "ViewController.h"

@class ViewController;

@interface TableViewController : UITableViewController {
    
}

@property (weak, nonatomic) UIPopoverController *popoverController;
@property (weak) ViewController *vc;
@property (weak) NSMutableArray *searchEngines;



@end
