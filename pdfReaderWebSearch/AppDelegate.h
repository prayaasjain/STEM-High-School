//
//  AppDelegate.h
//  pdfReaderWebSearch
//
//  Created by Prayaas Jain on 6/18/13.
//  Copyright (c) 2013 Prayaas Jain. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TestViewController;
@class ListOfPDFViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) ListOfPDFViewController *lop;
@property (strong, nonatomic) TestViewController *tvc;

@end
