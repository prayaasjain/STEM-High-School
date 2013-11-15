//
//  MyManager.h
//  pdfReaderWebSearch
//
//  Created by Prayaas Jain on 11/14/13.
//  Copyright (c) 2013 Prayaas Jain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyManager : NSObject {
    
    NSMutableDictionary *searchBundle;
    
}

@property (nonatomic, retain) NSMutableDictionary *searchBundle;

+ (id) sharedManager;

@end
