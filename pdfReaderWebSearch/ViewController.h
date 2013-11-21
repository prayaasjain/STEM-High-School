//
//  ViewController.h
//  pdfReaderWebSearch
//
//  Created by Prayaas Jain on 6/18/13.
//  Copyright (c) 2013 Prayaas Jain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchType.h"
#import "WebViewController.h"
#import "TableViewController.h"
#import "ShowPDFViewController.h"

@class ShowPDFViewController;

@interface ViewController : UIViewController <UIPopoverControllerDelegate> {
    MyManager *sharedManager;
}

@property (nonatomic,strong) SearchType *currentSearchEngine;
@property (weak, nonatomic) IBOutlet UIButton *selectSearchButton;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak) NSString *highlighted;
@property (weak) ShowPDFViewController *show;
- (IBAction)backButton:(id)sender;

@end
