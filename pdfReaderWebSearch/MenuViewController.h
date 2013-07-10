//
//  MenuViewController.h
//  pdfReaderWebSearch
//
//  Created by Peppy Sisay on 7/9/13.
//  Copyright (c) 2013 Prayaas Jain. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ShowPDFViewController;
@interface MenuViewController : UIViewController <UIAlertViewDelegate,UITextFieldDelegate>
@property ShowPDFViewController *show;

//- (IBAction)goToButton:(id)sender;
- (IBAction)goBackToList:(id)sender;
- (IBAction)exitMenu:(id)sender;


@end
