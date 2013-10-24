//
//  AppDelegate.h
//  pdfReaderWebSearch
//
//  Created by Prayaas Jain on 6/18/13.
//  Copyright (c) 2013 Prayaas Jain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PSPDFKit/PSPDFKit.h>
#import "ShowPDFViewController.h"
#import "ListOfPDFViewController.h"


@class TestViewController;
@class ListOfPDFViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) ListOfPDFViewController *lop;
@property (strong, nonatomic) ShowPDFViewController *show;

@end
